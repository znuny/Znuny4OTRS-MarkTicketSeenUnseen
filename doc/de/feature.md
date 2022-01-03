# Funktionalität

## Ticket als gelesen/ungelesen markieren

Im OTRS Standard ist es nicht möglich Tickets, also alle ungelesenen Artikel eines Tickets, als gelesen zu markieren. Ebenfalls ist es nicht möglich Tickets oder einzelne Artikel wieder als ungelesen zu markieren. Dieses Paket erweitert das System um die Funktionalität komplette Tickets oder einzelne Artikel als gelesen oder ungelesen zu markieren.

Um eine der beiden neuen Funktionalitäten zu nutzen, stehen im Ticket- und Artikel-Menü entsprechende Links zur Verfügung um das Ticket oder den Artikel als "gelesen markieren" oder "ungelesen markieren". Im Artikel-Menü steht nur der "ungelesen markieren"-Link zur Verfügung, da der Artikel beim lesen automatisch als gelesen markiert wird.

Auch in den Übersichten ist es möglich einzelne oder mehrere Tickets gleichzeitig als gelesen oder ungelesen zu markieren. Dazu wird beim markieren eines einzelnen Tickets im Ticket-Menü der Übersicht die entsprechenden Links angezeigt.

Um mehrere Tickets gleichzeitig als gelesen oder ungelesen zu markieren, muss eine Sammelaktion durchgeführt werden. Die Sammelaktion Ansicht wird um zwei Ja/Nein Auswahlboxen erweitert, mit denen festgelegt werden kann ob die zuvor selektierten Tickets als gelesen oder ungelesen markiert werden sollen.

## Weiterleitung nach Markierung

Über die neuen SysConfigs 'MarkTicketSeenRedirectDefaultURL' und 'MarkTicketUnseenRedirectDefaultURL' lässt sich festlegen auf welche Ansicht der Agent standardmäßig nach der Markierung umgeleitet werden soll. Diese Einstellungen lassen sich vom Agenten in seinen persönlichen Einstellungen überschreiben. Wurden keine persönliche Einstellung getroffen, tritt das Standardverhalten aus der SysConfig in Kraft.