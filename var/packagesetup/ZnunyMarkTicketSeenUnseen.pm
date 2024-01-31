# --
# Copyright (C) 2012 Znuny GmbH, https://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package var::packagesetup::ZnunyMarkTicketSeenUnseen;

use strict;
use warnings;
use utf8;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Cache',
    'Kernel::System::DB',
    'Kernel::System::Log',
    'Kernel::System::ZnunyHelper',
);

use Kernel::System::VariableCheck qw(:all);

=head1 NAME

var::packagesetup::ZnunyMarkTicketSeenUnseen - code to execute during package installation

=head1 SYNOPSIS

All code to execute during package installation

=head1 PUBLIC INTERFACE

=over 4

=cut

=item new()

create an object

    use Kernel::System::ObjectManager;
    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $CodeObject    = $Kernel::OM->Get('var::packagesetup::ZnunyMarkTicketSeenUnseen');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=item CodeInstall()

run the code install part

    my $Result = $CodeObject->CodeInstall();

=cut

sub CodeInstall {
    my ( $Self, %Param ) = @_;

    my $ConfigObject      = $Kernel::OM->Get('Kernel::Config');
    my $LogObject         = $Kernel::OM->Get('Kernel::System::Log');
    my $ZnunyHelperObject = $Kernel::OM->Get('Kernel::System::ZnunyHelper');

    my $ArticleActions      = $Self->_ArticleActionsGet();
    my $ArticleActionsAdded = $ZnunyHelperObject->_ArticleActionsAdd( %{$ArticleActions} );
    if ( !$ArticleActionsAdded ) {
        $LogObject->Log(
            Priority => 'error',
            Message  => 'Error adding article actions.',
        );
        return;
    }

    return if !$Self->_RemoveDeprecatedUserPreferences(%Param);

    return 1;
}

=item CodeReinstall()

run the code reinstall part

    my $Result = $CodeObject->CodeReinstall();

=cut

sub CodeReinstall {
    my ( $Self, %Param ) = @_;

    return $Self->CodeInstall();
}

=item CodeUpgrade()

run the code upgrade part

    my $Result = $CodeObject->CodeUpgrade();

=cut

sub CodeUpgrade {
    my ( $Self, %Param ) = @_;

    return $Self->CodeInstall();
}

=item CodeUninstall()

run the code uninstall part

    my $Result = $CodeObject->CodeUninstall();

=cut

sub CodeUninstall {
    my ( $Self, %Param ) = @_;

    my $LogObject         = $Kernel::OM->Get('Kernel::System::Log');
    my $ZnunyHelperObject = $Kernel::OM->Get('Kernel::System::ZnunyHelper');

    my $ArticleActions        = $Self->_ArticleActionsGet();
    my $ArticleActionsRemoved = $ZnunyHelperObject->_ArticleActionsRemove( %{$ArticleActions} );
    if ( !$ArticleActionsRemoved ) {
        $LogObject->Log(
            Priority => 'error',
            Message  => 'Error removing article actions.',
        );
        return;
    }

    return 1;
}

sub _ArticleActionsGet {
    my ( $Self, %Param ) = @_;

    my $ArticleActions = {
        Internal => [    # Channel name (Internal, Phone, Email, Chat or Invalid)
            {
                Key      => 'ZnunyMarkTicketSeenUnseen',
                Module   => 'Kernel::Output::HTML::ArticleAction::MarkArticleSeenUnseen',
                Priority => 10,
            },
        ],
        Phone => [       # Channel name (Internal, Phone, Email, Chat or Invalid)
            {
                Key      => 'ZnunyMarkTicketSeenUnseen',
                Module   => 'Kernel::Output::HTML::ArticleAction::MarkArticleSeenUnseen',
                Priority => 10,
            },
        ],
        Email => [       # Channel name (Internal, Phone, Email, Chat or Invalid)
            {
                Key      => 'ZnunyMarkTicketSeenUnseen',
                Module   => 'Kernel::Output::HTML::ArticleAction::MarkArticleSeenUnseen',
                Priority => 10,
            },
        ],
    };

    return $ArticleActions;
}

sub _RemoveDeprecatedUserPreferences {
    my ( $Self, %Param ) = @_;

    my $DBObject    = $Kernel::OM->Get('Kernel::System::DB');
    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

    my %PreferencesToRemove = (
        MarkTicketUnseenRedirectURL => [
            'Action=AgentTicketZoom;TicketID=###TicketID####1',
            'LastScreenView',
        ],
        MarkTicketSeenRedirectURL => [
            'Action=AgentTicketZoom;TicketID=###TicketID####1',
        ],
    );

    my $SQL = '
        DELETE FROM user_preferences
        WHERE       preferences_key = ?
                    AND preferences_value = ?
    ';

    for my $PreferenceKey ( sort keys %PreferencesToRemove ) {
        for my $PreferenceValue ( @{ $PreferencesToRemove{$PreferenceKey} } ) {
            my @Bind = (
                \$PreferenceKey,
                \$PreferenceValue,
            );

            return if !$DBObject->Do(
                SQL  => $SQL,
                Bind => \@Bind,
            );
        }
    }

    $CacheObject->CleanUp(
        Type => 'User',
    );

    return 1;
}

1;

=back
