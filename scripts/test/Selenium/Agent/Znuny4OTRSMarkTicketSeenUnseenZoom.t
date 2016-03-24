# --
# Copyright (C) 2012-2016 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

# get the Znuny4OTRS Selenium object
my $SeleniumObject = $Kernel::OM->Get('Kernel::System::UnitTest::Selenium');

# store test function in variable so the Selenium object can handle errors/exceptions/dies etc.
my $SeleniumTest = sub {

    # initialize Znuny4OTRS Helpers and other needed objects
    my $HelperObject = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
    my $ZnunyHelper  = $Kernel::OM->Get('Kernel::System::ZnunyHelper');
    my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

    # create test user and login
    my %TestUser = $SeleniumObject->AgentLogin(
        Groups => [ 'admin', 'users' ],
    );

    # create test Ticket and Articles
    my $TicketID = $HelperObject->TicketCreate();

    # navigate to created test ticket in AgentTicketZoom page without an article
    $SeleniumObject->AgentInterface(
        Action      => 'AgentTicketZoom',
        TicketID    => $TicketID,
        WaitForAJAX => 0,
    );

    my $ArticleIDFirst = $HelperObject->ArticleCreate(
        TicketID => $TicketID,
    );
    my $ArticleIDSecond = $HelperObject->ArticleCreate(
        TicketID => $TicketID,
    );

    # navigate to created test ticket in AgentTicketZoom page with an article
    $SeleniumObject->AgentInterface(
        Action   => 'AgentTicketZoom',
        TicketID => $TicketID
    );

    # check for elements
    $Self->True(
        $SeleniumObject->find_element( 'li#nav-Mark-seen a', 'css' )->is_displayed(),
        "Mark Ticket as seen link is visible",
    );

    $Self->True(
        $SeleniumObject->find_element( 'li#nav-Mark-unseen a', 'css' )->is_displayed(),
        "Mark Ticket as unseen link is visible",
    );

    $Self->True(
        $SeleniumObject->find_element( '#AgentTicketMarkSeenUnseenArticle', 'css' )->is_displayed(),
        "Mark Article as unseen link is visible",
    );

    # mark Ticket as unseen
    $SeleniumObject->find_element( 'li#nav-Mark-unseen a', 'css' )->click();

    # check if flags were set correctly
    my %Flags = $TicketObject->ArticleFlagGet(
        ArticleID => $ArticleIDFirst,
        UserID    => $TestUser{UserID},
    );

    $Self->False(
        $Flags{Seen},
        "Initial Article Seen Flag - ID $ArticleIDFirst",
    );

    %Flags = $TicketObject->ArticleFlagGet(
        ArticleID => $ArticleIDSecond,
        UserID    => $TestUser{UserID},
    );

    $Self->False(
        $Flags{Seen},
        "Initial Article Seen Flag - ID $ArticleIDSecond",
    );

    # call Seen Subaction directly
    $SeleniumObject->AgentInterface(
        Action      => 'AgentTicketMarkSeenUnseen',
        Subaction   => 'Seen',
        TicketID    => $TicketID,
        ArticleID   => $ArticleIDFirst,
        WaitForAJAX => 0,
    );

    # check if URL call has marked the Article as seen
    %Flags = $TicketObject->ArticleFlagGet(
        ArticleID => $ArticleIDFirst,
        UserID    => $TestUser{UserID},
    );

    $Self->True(
        $Flags{Seen},
        "Subaction Article Seen Flag - ID $ArticleIDFirst",
    );

    %Flags = $TicketObject->ArticleFlagGet(
        ArticleID => $ArticleIDSecond,
        UserID    => $TestUser{UserID},
    );

    $Self->False(
        $Flags{Seen},
        "Subaction Article Seen Flag - ID $ArticleIDSecond",
    );

    # re navigate to created test ticket in AgentTicketZoom page
    $SeleniumObject->AgentInterface(
        Action   => 'AgentTicketZoom',
        TicketID => $TicketID
    );

    # check if AJAX Requets have marked the remaining Article as read
    %Flags = $TicketObject->ArticleFlagGet(
        ArticleID => $ArticleIDFirst,
        UserID    => $TestUser{UserID},
    );

    $Self->True(
        $Flags{Seen},
        "Zoom AJAX Article Seen Flag - ID $ArticleIDFirst",
    );

    %Flags = $TicketObject->ArticleFlagGet(
        ArticleID => $ArticleIDSecond,
        UserID    => $TestUser{UserID},
    );

    $Self->True(
        $Flags{Seen},
        "Zoom AJAX Article Seen Flag - ID $ArticleIDSecond",
    );
};

# finally run the test(s) in the browser
$SeleniumObject->RunTest($SeleniumTest);

1;
