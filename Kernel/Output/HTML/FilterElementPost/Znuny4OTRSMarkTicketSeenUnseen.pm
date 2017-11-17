# --
# Copyright (C) 2012-2017 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::FilterElementPost::Znuny4OTRSMarkTicketSeenUnseen;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Language',
    'Kernel::Output::HTML::Layout',
    'Kernel::System::Web::Request',
);

use Kernel::System::VariableCheck qw(:all);

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $LayoutObject   = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $LanguageObject = $Kernel::OM->Get('Kernel::Language');
    my $ParamObject    = $Kernel::OM->Get('Kernel::System::Web::Request');

    my $TranslateTitle = $LanguageObject->Translate("Mark article as unseen");
    my $TranslateLink  = $LanguageObject->Translate("Mark as unseen");

    # check regular parameter
    my $TicketID = $ParamObject->GetParam( Param => 'TicketID' );

    my $JSBlock = <<"JS_BLOCK";
    Core.Agent.Znuny4OTRSMarkTicketSeenUnseen.Init({TicketID:'$TicketID', TranslateTitle:'$TranslateTitle', TranslateLink:'$TranslateLink'});
JS_BLOCK

    $LayoutObject->AddJSOnDocumentCompleteIfNotExists(
        Key  => 'Znuny4OTRSMarkTicketSeenUnseen',
        Code => $JSBlock,
    );

    return 1;
}

1;
