# --
# Copyright (C) 2012-2022 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::FilterElementPost::ZnunyMarkTicketSeenUnseenBulkAction;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Output::HTML::Layout',
    'Kernel::System::Ticket::Article',
    'Kernel::System::Ticket',
    'Kernel::System::Web::Request',
);

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $ParamObject   = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $TicketObject  = $Kernel::OM->Get('Kernel::System::Ticket');
    my $ArticleObject = $Kernel::OM->Get('Kernel::System::Ticket::Article');
    my $LayoutObject  = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # Only handle popup close
    # Check it by searching JSData added by Layout::Popup::PopupClose().
    return 1 if index( ${ $Param{Data} }, '"PopupClose":"LoadParentURLAndClose"' ) == -1;

    my %RequiredGetParams = (
        Action    => 'AgentTicketBulk',
        Subaction => 'Do',
    );

    my %GetParam;
    for my $Param ( sort keys %RequiredGetParams ) {
        $GetParam{$Param} = $ParamObject->GetParam( Param => $Param );

        return 1 if !$GetParam{$Param};
        return 1 if $GetParam{$Param} ne $RequiredGetParams{$Param};
    }

    my %FlagActionMapping = (
        MarkTicketsAsSeen   => 'Seen',
        MarkTicketsAsUnseen => 'Unseen',
    );

    my $FlagAction;
    FLAGACTION:
    for my $CurrentFlagAction ( sort keys %FlagActionMapping ) {
        next FLAGACTION if !$ParamObject->GetParam( Param => $CurrentFlagAction );
        $FlagAction = $CurrentFlagAction;
        last FLAGACTION;
    }
    return 1 if !$FlagAction;

    # determine required function for subaction
    my $TicketActionFunction  = 'TicketFlagDelete';
    my $ArticleActionFunction = 'ArticleFlagDelete';

    if ( $FlagAction eq 'MarkTicketsAsSeen' ) {
        $TicketActionFunction  = 'TicketFlagSet';
        $ArticleActionFunction = 'ArticleFlagSet';
    }

    # get involved tickets
    my @TicketIDs = grep {$_} $ParamObject->GetArray( Param => 'TicketID' );
    return 1 if !@TicketIDs;

    TICKETID:
    for my $TicketID ( sort @TicketIDs ) {
        my @ArticleIDs = $ArticleObject->ArticleIndex(
            TicketID => $TicketID,
        );

        ARTICLEID:
        for my $ArticleID ( sort @ArticleIDs ) {

            # article flag
            my $Success = $ArticleObject->$ArticleActionFunction(
                TicketID  => $TicketID,
                ArticleID => $ArticleID,
                Key       => 'Seen',
                Value     => 1,                         # irrelevant in case of delete
                UserID    => $LayoutObject->{UserID},
            );

            next ARTICLEID if $Success;

            $LayoutObject->FatalError(
                Message => "Error while setting article with ArticleID '$ArticleID' " .
                    "of ticket with TicketID '$TicketID' as " .
                    ( lc $FlagActionMapping{$FlagAction} ) .
                    "!",
            );
        }

        # ticket flag
        my $Success = $TicketObject->$TicketActionFunction(
            TicketID => $TicketID,
            Key      => 'Seen',
            Value    => 1,                         # irrelevant in case of delete
            UserID   => $LayoutObject->{UserID},
        );

        next TICKETID if $Success;

        $LayoutObject->FatalError(
            Message => "Error while setting ticket with TicketID '$TicketID' as " .
                ( lc $FlagActionMapping{$FlagAction} ) .
                "!",
        );
    }

    return 1;
}

1;
