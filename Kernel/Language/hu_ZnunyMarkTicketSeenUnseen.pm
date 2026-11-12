# --
# Copyright (C) 2012 Znuny GmbH, https://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Language::hu_ZnunyMarkTicketSeenUnseen;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Perl Module: Kernel/Output/HTML/ArticleAction/MarkArticleSeenUnseen.pm
    $Self->{Translation}->{'Mark article as unseen'} = 'Bejegyzés megjelölése olvasatlanként';
    $Self->{Translation}->{'Mark as unseen'} = 'Megjelölés olvasatlanként';

    # SysConfig
    $Self->{Translation}->{'Configure which screen should be shown after marking a ticket or article as seen.'} =
        'Annak beállítása, hogy mely képernyő legyen megjelenítve, miután egy jegyet vagy bejegyzést olvasottként jelöltek meg.';
    $Self->{Translation}->{'Configure which screen should be shown after marking a ticket or article as unseen.'} =
        'Annak beállítása, hogy mely képernyő legyen megjelenítve, miután egy jegyet vagy bejegyzést olvasatlanként jelöltek meg.';
    $Self->{Translation}->{'Defines the config parameters available in the preferences view. The default redirect URL from SysConfig \'MarkTicketSeenRedirectDefaultURL\' is used if no selection is made by the agent.'} =
        'Meghatározza a beállítások nézetben elérhető beállítási paramétereket. A „MarkTicketSeenRedirectDefaultURL” rendszerbeállításból származó alapértelmezett átirányítási URL lesz használva, ha az ügyintéző nem választ ki semmit.';
    $Self->{Translation}->{'Defines the config parameters available in the preferences view. The default redirect URL from SysConfig \'MarkTicketUnseenRedirectDefaultURL\' is used if no selection is made by the agent.'} =
        'Meghatározza a beállítások nézetben elérhető beállítási paramétereket. A „MarkTicketUnseenRedirectDefaultURL” rendszerbeállításból származó alapértelmezett átirányítási URL lesz használva, ha az ügyintéző nem választ ki semmit.';
    $Self->{Translation}->{'Defines the redirect URL for setting a ticket article to \'seen\'.'} =
        'Meghatározza az átirányítási URL-t a jegy bejegyzésének „olvasott” állapotra állításához.';
    $Self->{Translation}->{'Defines the redirect URL for setting a ticket article to \'unseen\'.'} =
        'Meghatározza az átirányítási URL-t a jegy bejegyzésének „olvasatlan” állapotra állításához.';
    $Self->{Translation}->{'Last viewed overview'} = 'Utoljára megtekintett áttekintő';
    $Self->{Translation}->{'Last viewed screen'} = 'Utoljára megtekintett képernyő';
    $Self->{Translation}->{'Mark ticket as seen'} = 'Jegy megjelölése olvasottként';
    $Self->{Translation}->{'Mark ticket as unseen'} = 'Jegy megjelölése olvasatlanként';
    $Self->{Translation}->{'Registers a link in the ticket menu of ticket overviews to mark all articles of the ticket as seen.'} =
        'Egy hivatkozást regisztrál a jegyáttekintők jegymenüben a jegy összes bejegyzésének olvasottként való megjelöléséhez.';
    $Self->{Translation}->{'Registers a link in the ticket menu of ticket overviews to mark all articles of the ticket as unseen.'} =
        'Egy hivatkozást regisztrál a jegyáttekintők jegymenüben a jegy összes bejegyzésének olvasatlanként való megjelöléséhez.';
    $Self->{Translation}->{'Registers a link in the ticket menu to mark a ticket as seen.'} =
        'Egy hivatkozást regisztrál a jegymenüben egy jegy olvasottként való megjelöléséhez.';
    $Self->{Translation}->{'Registers a link in the ticket menu to mark a ticket as unseen.'} =
        'Egy hivatkozást regisztrál a jegymenüben egy jegy olvasatlanként való megjelöléséhez.';
    $Self->{Translation}->{'Registers an output filter that adds the \'Mark tickets as unseen\' selection to the bulk view.'} =
        'Egy kimenetszűrőt regisztrál, amely hozzáadja a „Jegyek megjelölése olvasatlanként” kiválasztást a tömeges nézethez.';
    $Self->{Translation}->{'Screen after marking as seen'} = 'Olvasottként megjelölés utáni képernyő';
    $Self->{Translation}->{'Screen after marking as unseen'} = 'Olvasatlanként megjelölés utáni képernyő';


    push @{ $Self->{JavaScriptStrings} //= [] }, (
    );

}

1;
