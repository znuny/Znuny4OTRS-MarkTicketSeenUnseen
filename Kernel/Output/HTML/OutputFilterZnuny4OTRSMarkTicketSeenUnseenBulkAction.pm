# --
# Kernel/Output/HTML/OutputFilterZnuny4OTRSMarkTicketSeenUnseenBulkAction.pm - handles the 'Mark tickets as unseen' selection made in the buk action view
# Copyright (C) 2014 Znuny GmbH, http://znuny.com/
# --

package Kernel::Output::HTML::OutputFilterZnuny4OTRSMarkTicketSeenUnseenBulkAction;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    for (qw(ConfigObject LogObject LayoutObject ParamObject TicketObject)) {
        $Self->{$_} = $Param{$_} || die "Got no $_!";
    }

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my %RequiredGetParam = (
        Action    => 'AgentTicketBulk',
        Subaction => 'Do',
    );

    my %GetParam;
    for my $Param ( qw(Action Subaction) ) {
        $GetParam{ $Param } = $Self->{ParamObject}->GetParam( Param => $Param );

        return 1 if !$GetParam{ $Param };
        return 1 if $GetParam{ $Param } ne $RequiredGetParam{ $Param };
    }

    my %ParamFlagMapping = (
        MarkTicketsAsSeen   => 'Seen',
        MarkTicketsAsUnseen => 'Unseen',
    );

    my @TicketIDs;
    PARAM:
    for my $CurrentParam ( qw(MarkTicketsAsUnseen MarkTicketsAsSeen) ) {

        next PARAM if !$Self->{ParamObject}->GetParam( Param => $CurrentParam );

        # determine required function for subaction
        my $TicketActionFunction  = 'TicketFlagDelete';
        my $ArticleActionFunction = 'ArticleFlagDelete';

        if ( $CurrentParam eq 'MarkTicketsAsSeen' ) {
            $TicketActionFunction  = 'TicketFlagSet';
            $ArticleActionFunction = 'ArticleFlagSet';
        }

        # get involved tickets if not present, filtering empty TicketIDs
        if ( !@TicketIDs ) {
            @TicketIDs
                = grep {$_}
                $Self->{ParamObject}->GetArray( Param => 'TicketID' );
        }

        # end loop if no ticket should get edited (?!)
        last PARAM if !scalar @TicketIDs;

        TICKET:
        for my $TicketID ( sort @TicketIDs ) {

            my @ArticleIDs = $Self->{TicketObject}->ArticleIndex(
                TicketID => $TicketID,
            );

            ARTICLE:
            for my $ArticleID ( sort @ArticleIDs ) {

                # article flag
                my $Success = $Self->{TicketObject}->$ArticleActionFunction(
                    ArticleID => $ArticleID,
                    Key       => 'Seen',
                    Value     => 1,                               # irrelevant in case of delete
                    UserID    => $Self->{LayoutObject}->{UserID},
                );

                next ARTICLE if $Success;

                $Self->{LayoutObject}->FatalError(
                    Message => "Error while setting article with ArticleID '$ArticleID' ".
                                "of ticket with TicketID '$TicketID' as ".
                                ( lc $ParamFlagMapping{ $CurrentParam } ) .
                                "!",
                );
            }

            # ticket flag
            my $Success = $Self->{TicketObject}->$TicketActionFunction(
                TicketID => $TicketID,
                Key      => 'Seen',
                Value    => 1,                               # irrelevant in case of delete
                UserID   => $Self->{LayoutObject}->{UserID},
            );

            if ( !$Success ) {
                $Self->{LayoutObject}->FatalError(
                    Message => "Error while setting ticket with TicketID '$TicketID' as ".
                                ( lc $ParamFlagMapping{ $CurrentParam } ) .
                                "!",
                );
            }
        }

        # only one action is logical
        last PARAM;
    }

    return 1;
}

1;