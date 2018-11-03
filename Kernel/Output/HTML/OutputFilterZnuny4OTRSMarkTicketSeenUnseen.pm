# --
# Copyright (C) 2012-2018 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::OutputFilterZnuny4OTRSMarkTicketSeenUnseen;

use strict;
use warnings;

our @ObjectDependencies = (
);

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
                    <a href="[% Env("Baselink") %]Action=AgentTicketMarkSeenUnseen;Subaction=Unseen;TicketID=[% Data.TicketID | html %];ArticleID=[% Data.ArticleID | html %]" title="[% Translate("Mark article as unseen") | html %]">[% Translate("Mark unseen") | html %]</a>
                </li>
HTML

    ${ $Param{Data} } =~ s{( <ul \s class="Actions"> )}{$1$LinkHTML}xms;

    return 1;
}

1;
