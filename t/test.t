use Test::More tests => 5;
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

my $birthday = 1153432704; # no, really!

my $tz = sprintf "%s%02u%02u", Email::Date::_tz_diff(1153432704);

SKIP: {
    skip "test only useful in US/Eastern, -0400, not $tz", 1 if $tz ne '-0400';

    is(
        format_date(1153432704),
        'Thu, 20 Jul 2006 17:58:24 -0400',
        "rjbs's birthday date format properly",
    );
}

is(
  format_gmdate(1153432704),
  'Thu, 20 Jul 2006 21:58:24 +0000',
  "rjbs's birthday date format properly in GMT",
);
