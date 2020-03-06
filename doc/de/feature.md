# Funktionalität

## Tickets als gelesen/ungelesen markieren

In OTRS ist es nicht möglich, Tickets (also alle Artikel eines Tickets) als gelesen oder ungelesen zu markieren. Dieses Paket ergänzt OTRS um diese Funktionalität.

Im Ticket- und Artikel-Menü stehen entsprechende Links zur Verfügung, um ein Ticket oder dessen Artikel als gelesen oder ungelesen zu markieren. Im Artikel-Menü steht nur der "ungelesen markieren"-Link zur Verfügung, da der Artikel beim Lesen bereits automatisch als gelesen markiert wird.

Auch in den Übersichten ist es möglich, einzelne oder mehrere Tickets gleichzeitig als gelesen oder ungelesen zu markieren. Dazu werden beim Markieren eines einzelnen Tickets im Ticket-Menü in der Übersicht die entsprechenden Links angezeigt.

Um mehrere Tickets gleichzeitig als gelesen oder ungelesen zu markieren, muss eine Sammelaktion ausgeführt werden. Die Sammelaktion-Ansicht wird um zwei "Ja/Nein"-Auswahlboxen erweitert, mit denen festgelegt werden kann, ob die zuvor selektierten Tickets als gelesen oder ungelesen markiert werden sollen.

## Weiterleitung nach Markierung

Über die neuen SysConfig-Optionen `MarkTicketSeenRedirectDefaultURL` und `MarkTicketUnseenRedirectDefaultURL` lässt sich festlegen, auf welche Ansicht der Agent standardmäßig nach der Markierung weitergeleitet werden soll. Diese Einstellungen lassen sich vom Agenten in seinen persönlichen Einstellungen überschreiben. Wurden keine persönliche Einstellungen getroffen, so gilt das Standardverhalten aus der SysConfig.
