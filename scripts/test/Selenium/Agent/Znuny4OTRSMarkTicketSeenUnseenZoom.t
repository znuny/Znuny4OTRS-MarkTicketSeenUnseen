# --
# Copyright (C) 2014 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

# get selenium object
my $Selenium = $Kernel::OM->Get('Kernel::System::UnitTest::Selenium');

$Selenium->RunTest(
    sub {
        my $Helper     = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
        my $UserObject = $Kernel::OM->Get('Kernel::System::User');

        # create test user and login
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => [ 'admin', 'users' ],
        ) || die "Did not get test user";

        my %TestUserList = $UserObject->UserSearch(
            UserLogin => $TestUserLogin,
        );
        %TestUserList = reverse %TestUserList;

        my %TestUser = $UserObject->GetUserData(
            UserID => $TestUserList{$TestUserLogin},
        );

        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        # get ticket object
        my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

        # create test ticket
        my $TicketID = $TicketObject->TicketCreate(
            Title        => 'Selenium ticket',
            Queue        => 'Raw',
            Lock         => 'unlock',
            Priority     => '3 normal',
            State        => 'new',
            CustomerID   => 'SeleniumCustomer',
            CustomerUser => 'customer@example.com',
            OwnerID      => 1,
            UserID       => 1,
        );
        $Self->True(
            $TicketID,
            "Ticket is created - ID $TicketID",
        );

        my $ArticleIDFirst = $TicketObject->ArticleCreate(
            TicketID       => $TicketID,
            ArticleType    => 'note-internal',
            SenderType     => 'agent',
            Subject        => 'Selenium subject test',
            Body           => 'Selenium body test',
            ContentType    => 'text/plain; charset=ISO-8859-15',
            HistoryType    => 'OwnerUpdate',
            HistoryComment => 'Some free text!',
            UserID         => 1,
            NoAgentNotify  => 1,
        );
        $Self->True(
            $ArticleIDFirst,
            "ArticleCreate - ID $ArticleIDFirst",
        );

        my $ArticleIDSecond = $TicketObject->ArticleCreate(
            TicketID       => $TicketID,
            ArticleType    => 'note-internal',
            SenderType     => 'agent',
            Subject        => 'Selenium subject test',
            Body           => 'Selenium body test',
            ContentType    => 'text/plain; charset=ISO-8859-15',
            HistoryType    => 'OwnerUpdate',
            HistoryComment => 'Some free text!',
            UserID         => 1,
            NoAgentNotify  => 1,
        );
        $Self->True(
            $ArticleIDSecond,
            "ArticleCreate - ID $ArticleIDSecond",
        );

        # get script alias
        my $ScriptAlias = $Kernel::OM->Get('Kernel::Config')->Get('ScriptAlias');

        # navigate to created test ticket in AgentTicketZoom page
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentTicketZoom;TicketID=$TicketID");

        # check for elements
        $Self->True(
            $Selenium->find_element('//*[@id="nav-Mark seen"]/a')->is_displayed(),
            "Mark Ticket as seen link is visible",
        );

        $Self->True(
            $Selenium->find_element('//*[@id="nav-Mark unseen"]/a')->is_displayed(),
            "Mark Ticket as unseen link is visible",
        );

        $Self->True(
            $Selenium->find_element('#AgentTicketMarkSeenUnseenArticle', 'css')->is_displayed(),
            "Mark Article as unseen link is visible",
        );


        # workaround since OTRS uses the name as the ID which can contain spaces -.-
        $Selenium->find_element('//*[@id="nav-Mark unseen"]/a')->click();

        my %Flags = $TicketObject->ArticleFlagGet(
            ArticleID => $ArticleIDFirst,
            UserID    => $TestUser{UserID},
        );

        $Self->False(
            $Flags{Seen},
            "Article Seen Flag - ID $ArticleIDFirst",
        );

        %Flags = $TicketObject->ArticleFlagGet(
            ArticleID => $ArticleIDSecond,
            UserID    => $TestUser{UserID},
        );

        $Self->False(
            $Flags{Seen},
            "Article Seen Flag - ID $ArticleIDSecond",
        );

        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentTicketMarkSeenUnseen;Subaction=Seen;TicketID=$TicketID;ArticleID=$ArticleIDFirst");

        # wait until page has finished loading
        $Selenium->WaitFor( JavaScript => 'return typeof($) === "function"' );

        %Flags = $TicketObject->ArticleFlagGet(
            ArticleID => $ArticleIDFirst,
            UserID    => $TestUser{UserID},
        );

        $Self->True(
            $Flags{Seen},
            "Article Seen Flag - ID $ArticleIDFirst",
        );

        %Flags = $TicketObject->ArticleFlagGet(
            ArticleID => $ArticleIDSecond,
            UserID    => $TestUser{UserID},
        );

        $Self->False(
            $Flags{Seen},
            "Article Seen Flag - ID $ArticleIDSecond",
        );

        # re navigate to created test ticket in AgentTicketZoom page
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentTicketZoom;TicketID=$TicketID");

        # wait until page has finished loading
        $Selenium->WaitFor( JavaScript => 'return typeof($) === "function"' );

        # wait for the AJAX request to complete
        sleep 5;

        %Flags = $TicketObject->ArticleFlagGet(
            ArticleID => $ArticleIDFirst,
            UserID    => $TestUser{UserID},
        );

        $Self->True(
            $Flags{Seen},
            "Article Seen Flag - ID $ArticleIDFirst",
        );

        %Flags = $TicketObject->ArticleFlagGet(
            ArticleID => $ArticleIDSecond,
            UserID    => $TestUser{UserID},
        );

        $Self->True(
            $Flags{Seen},
            "Article Seen Flag - ID $ArticleIDSecond",
        );
    }
);

1;
