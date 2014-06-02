# --
# Kernel/Language/de_Znuny4OTRSMarkTicketSeenUnseen.pm - the German translation of the texts of Znuny4OTRSMarkTicketSeenUnseen
# Copyright (C) 2013 Znuny GmbH, http://znuny.com/
# --

package Kernel::Language::de_Znuny4OTRSMarkTicketSeenUnseen;

use strict;
use warnings;

sub Data {
    my $Self = shift;

    # menu modules
    $Self->{Translation}->{"Mark seen"} = "Gelesen markieren";
    $Self->{Translation}->{"Mark unseen"} = "Ungelesen markieren";

    $Self->{Translation}->{"mark ticket as seen"} = "Ticket als gelesen markieren";
    $Self->{Translation}->{"mark ticket as unseen"} = "Ticket als ungelesen markieren";

    $Self->{Translation}->{"Mark ticket as seen"} = "Ticket als gelesen markieren";
    $Self->{Translation}->{"Mark ticket as unseen"} = "Ticket als ungelesen markieren";

    $Self->{Translation}->{"Mark article as unseen"} = "Artikel als ungelesen markieren";

    # bulk action
    $Self->{Translation}->{"Mark tickets as seen"} = "Tickets als gelesen markieren";
    $Self->{Translation}->{"Mark tickets as unseen"} = "Tickets als ungelesen markieren";

    # preferences
    $Self->{Translation}->{"Screen after marking ticket as seen"} = "Ansicht nachdem ein Ticket als gelesen markiert wurde";
    $Self->{Translation}->{"Screen after marking ticket as unseen"} = "Ansicht nachdem ein Ticket als ungelesen markiert wurde";

    $Self->{Translation}->{"Show this screen after I marked a ticket as seen"} = "Diese Ansicht nach dem als gelesen markieren eines Tickets anzeigen";
    $Self->{Translation}->{"Show this screen after I marked a ticket as unseen"} = "Diese Ansicht nach dem als ungelesen markieren eines Tickets anzeigen";

    # SysConfigs
    $Self->{Translation}->{""} = "";

    return 1;
}

1;
