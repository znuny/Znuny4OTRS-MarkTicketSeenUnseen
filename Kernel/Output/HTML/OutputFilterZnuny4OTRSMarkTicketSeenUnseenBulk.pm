# --
# Copyright (C) 2012-2018 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::OutputFilterZnuny4OTRSMarkTicketSeenUnseenBulk;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::Output::HTML::Layout',
    'Kernel::System::Web::Request',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    my %ParamLabel = (
        MarkTicketsAsSeen   => "Mark tickets as seen",
        MarkTicketsAsUnseen => "Mark tickets as unseen",
    );

    PARAM:
    for my $CurrentParam (qw( MarkTicketsAsSeen MarkTicketsAsUnseen )) {

        my $CurrentParamValue = $ParamObject->GetParam( Param => $CurrentParam );

        my $SelectHTML = $LayoutObject->BuildSelection(
            Data       => $ConfigObject->Get('YesNoOptions'),
            Name       => $CurrentParam,
            SelectedID => $CurrentParamValue || 0,
        );

        my $ElementHTML = <<HTML;
                        <label for="$CurrentParam">[% Translate("$ParamLabel{$CurrentParam}") | html %]:</label>
                        <div class="Field">
                            $SelectHTML
                        </div>
                        <div class="Clear"></div>
HTML

        ${ $Param{Data} } =~ s{(</fieldset>[^<]+</div>[^<]+</div>[^<]+<div \s class="Footer")}{$ElementHTML$1}xms;
    }

    return 1;
}

1;
