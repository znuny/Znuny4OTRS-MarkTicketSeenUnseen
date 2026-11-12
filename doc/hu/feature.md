# Funkcionalitás

## Jegyek megjelölése olvasottként vagy olvasatlanként

Ez a csomag lehetőséget ad a jegyek (egy jegy összes bejegyzésének) olvasottként vagy olvasatlanként való megjelölésére.

A jegy- és bejegyzésmenüben megfelelő hivatkozások érhetők el egy jegy vagy a bejegyzéseinek olvasottként vagy olvasatlanként való megjelöléséhez. Csak a „megjelölés olvasatlanként” hivatkozás érhető el a bejegyzésmenüben, mivel a bejegyzés automatikusan olvasottként kerül megjelölésre, amikor elolvassák.

Egy vagy több jegy egyszerre történő olvasottként vagy olvasatlanként való megjelölése is lehetséges az áttekintésekben. Ehhez megfelelő hivatkozások vannak megjelenítve az áttekintés jegymenüjében, ha egy önálló jegyet kiválaszt.

Több jegy egyszerre történő olvasottként vagy olvasatlanként való megjelöléséhez tömeges műveletet kell végrehajtani. A tömeges művelet nézete két „Igen/Nem” választómezővel lett kiegészítve, amelyek annak megadásához használhatók, hogy a korábban kiválasztott jegyek olvasottként vagy olvasatlanként legyenek-e megjelölve.

## Továbbítás a megjelölés után

Az új `MarkTicketSeenRedirectDefaultURL` és `MarkTicketUnseenRedirectDefaultURL` rendszerbeállítási lehetőségek lehetővé teszik annak megadását, hogy alapértelmezetten melyik nézetre kell átirányítani az ügyintézőt a jegyek megjelölése után. Ezeket a beállításokat az ügyintéző felülírhatja a személyes beállításaiban. Ha nem történtek személyes beállítások, akkor a rendszerbeállítások alapértelmezett viselkedése lesz érvényes.
