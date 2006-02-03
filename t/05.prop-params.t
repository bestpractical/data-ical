#!/usr/bin/perl -w

use warnings;
use strict;

use Test::More tests => 4;
use Test::LongString;
use Test::NoWarnings;

BEGIN { use_ok('Data::ICal::Entry::Todo') }

my $todo = Data::ICal::Entry::Todo->new();
isa_ok($todo, 'Data::ICal::Entry::Todo');

$todo->add_property( summary => [ 'Sum it up.', { language => "en-US", value => "TEXT" } ] ); 
# example from RFC 2445 4.2.11
$todo->add_properties( attendee => [ 'MAILTO:janedoe@host.com', 
    { member => [ 'MAILTO:projectA@host.com', 'MAILTO:projectB@host.com' ] } ]);

is_string($todo->as_string, <<'END_VCAL', "Got the right output");
BEGIN:VTODO
ATTENDEE;MEMBER="MAILTO:projectA@host.com","MAILTO:projectB@host.com":MAILT
 O:janedoe@host.com
SUMMARY;LANGUAGE=en-US;VALUE=TEXT:Sum it up.
END:VTODO
END_VCAL
