# --
# Kernel/Output/HTML/OutputFilterZnuny4OTRSMarkTicketSeenUnseen.pm - adds a 'Mark article as unseen' link to the article menu
# Copyright (C) 2014 Znuny GmbH, http://znuny.com/
# --

package Kernel::Output::HTML::OutputFilterZnuny4OTRSMarkTicketSeenUnseen;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $LinkHTML = <<'HTML';
                <li>
                    <a href="$Env{"Baselink"}Action=AgentTicketMarkSeenUnseen;Subaction=Unseen;TicketID=$QData{"TicketID"};ArticleID=$QData{"ArticleID"}" title="$Text{"Mark article as unseen"}">$Text{"Mark unseen"}</a>
                </li>
HTML

    ${ $Param{Data} } =~ s{(<!-- \s+ dtl:block:ArticleMenu-->)}{$LinkHTML$1}xms;

    return 1;
}

1;
