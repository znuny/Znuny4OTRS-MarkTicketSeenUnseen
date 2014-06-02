# --
# Kernel/Modules/AgentTicketMarkSeenUnseen.pm - to mark tickets and articles as seen or unseen
# Copyright (C) 2014 Znuny GmbH, http://znuny.com/
# --

package Kernel::Modules::AgentTicketMarkSeenUnseen;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    $Self->{Debug} = $Param{Debug} || 0;

    # check all needed objects
    for (qw(TicketObject ParamObject LayoutObject ConfigObject LogObject UserObject)) {
        if ( !$Self->{$_} ) {
            $Self->{LayoutObject}->FatalError( Message => "Got no $_!" );
        }
    }

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my %GetParam;
    for my $Param ( qw(TicketID ArticleID Subaction) ) {

        $GetParam{ $Param } = $Self->{ParamObject}->GetParam( Param => $Param );
    }

    for my $RequiredParam ( qw(TicketID Subaction) ) {

        if ( !$GetParam{ $RequiredParam } ) {
            $Self->{LayoutObject}->FatalError(
                Message => "Need $RequiredParam!",
            );
        }
    }

    if ( !scalar grep { $GetParam{Subaction} eq $_ } qw( Seen Unseen ) ) {

        $Self->{LayoutObject}->FatalError(
            Message => "Invalid value '$GetParam{Subaction}' for parameter 'Subaction'!",
        );
    }

    my @ArticleIDs = $Self->{TicketObject}->ArticleIndex(
        TicketID => $GetParam{TicketID},
    );

    if ( $GetParam{ArticleID} ) {

        if ( !scalar grep { $GetParam{ArticleID} eq $_ } @ArticleIDs ) {

            $Self->{LayoutObject}->FatalError(
                Message => "Can't find ArticleID '$GetParam{ArticleID}' of ticket with TicketID '$GetParam{TicketID}'!",
            );
        }

        # reverse the ArticleIDs to get the correct index for the redirect URL
        @ArticleIDs = reverse @ArticleIDs;

        # remember article index for later replacement in redirect URL
        ( $GetParam{ArticleIndex} ) = grep { $ArticleIDs[ $_ ] eq $GetParam{ArticleID} } 0..$#ArticleIDs;

        @ArticleIDs = ( $GetParam{ArticleID} );
    }

    # determine required function for subaction
    my $TicketActionFunction  = 'TicketFlagDelete';
    my $ArticleActionFunction = 'ArticleFlagDelete';

    if ( $GetParam{Subaction} eq 'Seen' ) {
        $TicketActionFunction  = 'TicketFlagSet';
        $ArticleActionFunction = 'ArticleFlagSet';
    }

    # perform action
    ARTICLE:
    for my $ArticleID ( sort @ArticleIDs ) {

        # article flag
        my $Success = $Self->{TicketObject}->$ArticleActionFunction(
            ArticleID => $ArticleID,
            Key       => 'Seen',
            Value     => 1,               # irrelevant in case of delete
            UserID    => $Self->{UserID},
        );

        next ARTICLE if $Success;

        $Self->{LayoutObject}->FatalError(
            Message => "Error while setting article with ArticleID '$ArticleID' ".
                        "of ticket with TicketID '$GetParam{TicketID}' as ".
                        ( lc $GetParam{Subaction} ).
                        "!",
        );
    }

    # ticket flag
    my $Success = $Self->{TicketObject}->$TicketActionFunction(
        TicketID => $GetParam{TicketID},
        Key      => 'Seen',
        Value    => 1,               # irrelevant in case of delete
        UserID   => $Self->{UserID},
    );

    if ( !$Success ) {
        $Self->{LayoutObject}->FatalError(
            Message => "Error while setting ticket with ".
                        "TicketID '$GetParam{TicketID}' as ".
                        ( lc $GetParam{Subaction} ).
                        "!",
        );
    }

    # get back to our last search result if the request came from a search view
    if ( $Self->{ParamObject}->GetParam( Param => 'RedirectToSearch' ) ) {
        return $Self->{LayoutObject}->Redirect(
            OP => 'Action=AgentTicketSearch;Subaction=Search;Profile=last-search;TakeLastSearch=1;',
        );
    }

    my %UserPreferences = $Self->{UserObject}->GetPreferences(
        UserID => $Self->{UserID},
    );

    my $RedirectURL = $UserPreferences{'UserMarkTicket'. $GetParam{Subaction} .'RedirectURL'};
    $RedirectURL  ||= $Self->{ConfigObject}->Get('MarkTicket'. $GetParam{Subaction} .'RedirectDefaultURL');
    $RedirectURL  ||= 'Action=AgentTicketZoom;TicketID=###TicketID###';

    REPLACE:
    for my $ReplaceParam ( qw(TicketID ArticleID ArticleIndex) ) {

        # make sure the placeholder gets replaced
        $GetParam{ $ReplaceParam } ||= '';

        $RedirectURL =~ s{###$ReplaceParam###}{$GetParam{$ReplaceParam}}g;
    }

    return $Self->{LayoutObject}->Redirect(
        OP => $RedirectURL,
    );
}

1;
