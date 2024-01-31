# Functionality

## Mark tickets as read/unread

This package adds the possibility to mark tickets (all articles of a ticket) as read or unread.

In the ticket and article menu, appropriate links are available to mark a ticket or its articles as read or unread. Only the "mark unread" link is available in the article menu, since the article is automatically marked as read when it is read.

It is also possible to mark single or several tickets as read or unread at the same time in the overviews. To do this, the corresponding links are displayed in the overview in the ticket menu when you select a single ticket.

To mark several tickets as read or unread at the same time, a bulk action must be executed. The bulk action view is extended by two "Yes/No" selection boxes, which can be used to specify whether the previously selected tickets are to be marked as read or unread.

## Forwarding after marking

The new SysConfig options `MarkTicketSeenRedirectDefaultURL` and `MarkTicketUnseenRedirectDefaultURL` allow you to specify which view the agent should be forwarded to by default after marking the tickets. These settings can be overwritten by the agent in his personal settings. If no personal settings have been made, the default behavior of the SysConfig applies.
