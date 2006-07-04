use Test::More qw[no_plan];
use strict;
$^W = 1;

BEGIN { use_ok 'Email::Date' }

use Date::Parse;
my @date = strptime(format_date);
cmp_ok $date[-2], '>', 100, 'format_date returned something parsable';
my $date = find_date(<<__MESSAGE__);
Resent-Date: Tue, 6 Jul 2004 16:11:06 -0400
__MESSAGE__

isa_ok $date, 'Time::Piece';
