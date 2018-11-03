# --
# Copyright (C) 2012-2018 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
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
    $Self->{Translation}->{"This configuration defines the config parameters of this item, to be shown in the preferences view. The default redirect URL from SysConfig 'MarkTicketUnseenRedirectDefaultURL' is used if no selection is made by the agent."} = "Diese Konfiguration definiert die Konfigurationsparameter des Elements in persönlichen Einstellungen. Die Standard Weiterleitungs-URL aus der SysConfig 'MarkTicketUnseenRedirectDefaultURL' wird verwendet, wenn keine Auswahl vom Agenten getroffen wurde.";
    $Self->{Translation}->{"This configuration defines the redirect URL target after a ticket article was set to unseen."} = "Diese Konfiguration definiert die Weiterleitungs-URL nachdem ein Ticket oder Artikel als ungelesen markiert wurde.";

    $Self->{Translation}->{"This configuration defines the config parameters of this item, to be shown in the preferences view. The default redirect URL from SysConfig 'MarkTicketSeenRedirectDefaultURL' is used if no selection is made by the agent."} = "Diese Konfiguration definiert die Konfigurationsparameter des Elements in persönlichen Einstellungen. Die Standard Weiterleitungs-URL aus der SysConfig 'MarkTicketSeenRedirectDefaultURL' wird verwendet, wenn keine Auswahl vom Agenten getroffen wurde.";
    $Self->{Translation}->{"This configuration defines the redirect URL target after a ticket article was set to unseen."} = "Diese Konfiguration definiert die Weiterleitungs-URL nachdem ein Ticket oder Artikel als gelesen markiert wurde.";

    $Self->{Translation}->{"This configuration registers a link in the ticket menu to mark ticket as unseen."} = "Diese Konfiguration registriert einen Link im Ticket-Menü um das Ticket als ungelesen zu markieren.";
    $Self->{Translation}->{"This configuration registers a link in the ticket menu to the ticket overviews of the agent interface to mark all articles of the ticket as unseen."} = "Diese Konfiguration registriert einen Link im Ticket-Menü in den Ticket-Übersichten um alle Artikel eines Tickets als ungelesen zu markieren.";

    $Self->{Translation}->{"This configuration registers a link in the ticket menu to mark ticket as seen."} = "Diese Konfiguration registriert einen Link im Ticket-Menü um das Ticket als gelesen zu markieren.";
    $Self->{Translation}->{"This configuration registers a link in the ticket menu to the ticket overviews of the agent interface to mark all articles of the ticket as seen."} = "Diese Konfiguration registriert einen Link im Ticket-Menü in den Ticket-Übersichten um alle Artikel eines Tickets als gelesen zu markieren.";

    $Self->{Translation}->{"This configuration registers an output filter that adds a 'Mark article as unseen' link to the article menu."} = "Diese Konfiguration registriert einen Outputfilter, der den 'Artikel als ungelesen markieren' zum Artikel-Menü hinzufügt.";

    $Self->{Translation}->{"This configuration registers an output filter that adds the 'Mark tickets as unseen' selection to the bulk view."} = "Diese Konfiguration registriert einen Outputfilter, der die 'Tickets als ungelesen markieren' Auswahl zur Sammelaktion-Ansicht hinzufügt.";
    $Self->{Translation}->{"This configuration registers an output filter that adds the 'Mark tickets as seen' selection to the bulk view."} = "Diese Konfiguration registriert einen Outputfilter, der die 'Tickets als gelesen markieren' Auswahl zur Sammelaktion-Ansicht hinzufügt.";

    return 1;
}

1;
