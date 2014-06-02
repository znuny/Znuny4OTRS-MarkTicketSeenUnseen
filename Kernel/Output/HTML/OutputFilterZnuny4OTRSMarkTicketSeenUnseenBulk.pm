# --
# Kernel/Output/HTML/OutputFilterZnuny4OTRSMarkTicketAsSeenUnseenBulk.pm - adds a the 'Mark tickets as seen' and 'Mark tickets as unseen' selections to the buk action view
# Copyright (C) 2014 Znuny GmbH, http://znuny.com/
# --

package Kernel::Output::HTML::OutputFilterZnuny4OTRSMarkTicketAsSeenUnseenBulk;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    for (qw(ConfigObject LayoutObject ParamObject)) {
        $Self->{$_} = $Param{$_} || die "Got no $_!";
    }

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my %ParamLabel = (
        MarkTicketsAsSeen   => "Mark tickets as seen",
        MarkTicketsAsUnseen => "Mark tickets as unseen",
    );

    PARAM:
    for my $CurrentParam ( qw( MarkTicketsAsSeen MarkTicketsAsUnseen ) ) {

        my $CurrentParamValue = $Self->{ParamObject}->GetParam( Param => $CurrentParam );

        my $SelectHTML = $Self->{LayoutObject}->BuildSelection(
            Data       => $Self->{ConfigObject}->Get('YesNoOptions'),
            Name       => $CurrentParam,
            SelectedID => $CurrentParamValue || 0,
        );

        my $ElementHTML = <<HTML;
                        <label for="$CurrentParam">\$Text{"$ParamLabel{$CurrentParam}"}:</label>
                        <div class="Field">
                            $SelectHTML
                        </div>
                        <div class="Clear"></div>
HTML

        ${ $Param{Data} } =~ s{(</div>)[^<]+(</fieldset>)}{$1$ElementHTML$2}xms;
    }

    return 1;
}

1;
