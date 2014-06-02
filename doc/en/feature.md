# Mark ticket as seen/unseen

In the OTRS standard it's not possible to mark tickets (all unseen articles of which) as seen. Additional it's not possible to mark whole tickets or single articles as unseen again. This package extends the system with the functionality to set complete tickets or single articles as seen or unseen again.

The ticket menu and the article menu in the ticket zoom view got extended by two same named links to use one of these functionalities. In the article menu only the "mark unseen" link is available, since viewing an article marks it as seen automatically.

Additionally it's possible to mark a single or multiple tickets as seen or unseen from within one of the overviews, like the search result view. After selecting one single ticket the links will be seen in the showing ticket menu.

A ticket bulk action have to be used to mark multiple tickets as seen or unseen. After selecting the designated tickets from an overview and opening the bulk action, two new yes/no selection fields, one for each functionality, will be shown. Depending on the selection made, all selected tickets will be marked as seen or unseen completely.

# Redirect after marking a ticket

Two new SysConfigs 'MarkTicketSeenRedirectDefaultURL' and 'MarkTicketUnseenRedirectDefaultURL' have been added to the system. This SysConfig define where the agent should get redirected after marking a ticket as seen or unseen by default. This setting can be overwritten by the agent in the personal preferences screen. If no selection is made by the agent the SysConfig selection will be used.