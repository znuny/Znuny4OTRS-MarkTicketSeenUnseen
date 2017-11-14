# --
# Copyright (C) 2012-2017 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::FilterElementPost::Znuny4OTRSMarkTicketSeenUnseenBulk;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::Language',
    'Kernel::Output::HTML::Layout',
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

    my $ConfigObject   = $Kernel::OM->Get('Kernel::Config');
    my $ParamObject    = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $LayoutObject   = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $LanguageObject = $Kernel::OM->Get('Kernel::Language');

    my $YesNoOptions = $ConfigObject->Get('YesNoOptions');
    my %ParamLabels  = (
        MarkTicketsAsSeen   => 'Mark tickets as seen',
        MarkTicketsAsUnseen => 'Mark tickets as unseen',
    );

    PARAM:
    for my $CurrentParam ( sort keys %ParamLabels ) {
        my $CurrentParamValue = $ParamObject->GetParam( Param => $CurrentParam );

        my $SelectHTML = $LayoutObject->BuildSelection(
            Data       => $YesNoOptions,
            Name       => $CurrentParam,
            SelectedID => $CurrentParamValue || 0,
        );

        my $CurrenParamTranslation = $LanguageObject->Translate( $ParamLabels{$CurrentParam} );
        my $ElementHTML            = <<HTML;
<label for="$CurrentParam">$CurrenParamTranslation:</label>
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
