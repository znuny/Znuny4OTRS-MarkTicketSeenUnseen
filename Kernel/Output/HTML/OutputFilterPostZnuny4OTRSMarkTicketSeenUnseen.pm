# --
# Copyright (C) 2012-2015 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::OutputFilterPostZnuny4OTRSMarkTicketSeenUnseen;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Output::HTML::Layout',
    'Kernel::System::Log',
    'Kernel::System::Web::Request',
);

use Kernel::System::VariableCheck qw(:all);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $LogObject    = $Kernel::OM->Get('Kernel::System::Log');
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    my $TranslateTitle
        = $Kernel::OM->Get('Kernel::Output::HTML::Layout')->{LanguageObject}->Translate("Mark article as unseen");
    my $TranslateLink = $Kernel::OM->Get('Kernel::Output::HTML::Layout')->{LanguageObject}->Translate("Mark unseen");

    # check regular parameter
    my $TicketID = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'TicketID' );

    my $JSBlock = <<"JS_BLOCK";
    Core.Agent.Znuny4OTRSMarkTicketSeenUnseen.Init({TicketID:'$TicketID', TranslateTitle:'$TranslateTitle', TranslateLink:'$TranslateLink', });
JS_BLOCK

    $Self->AddJSOnDocumentCompleteIfNotExists(
        Key  => 'Znuny4OTRSMarkTicketSeenUnseen',
        Code => $JSBlock,
    );

    return 1;
}

sub AddJSOnDocumentCompleteIfNotExists {
    my ( $Self, %Param ) = @_;

    my $LogObject    = $Kernel::OM->Get('Kernel::System::Log');
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # check needed stuff
    NEEDED:
    for my $Needed (qw(Key Code)) {

        next NEEDED if defined $Param{$Needed};

        $LogObject->Log(
            Priority => 'error',
            Message  => "Parameter '$Needed' is needed!",
        );
        return;
    }

    my $Exists = 0;
    CODEJS:
    for my $CodeJS ( @{ $LayoutObject->{_JSOnDocumentComplete} || [] } ) {

        next CODEJS if $CodeJS !~ m{ Key: \s $Param{Key}}xms;
        $Exists = 1;
        last CODEJS;
    }

    return 1 if $Exists;

    my $AddCode = "// Key: $Param{Key}\n" . $Param{Code};

    $LayoutObject->AddJSOnDocumentComplete(
        Code => $AddCode,
    );

    return 1;
}

1;
