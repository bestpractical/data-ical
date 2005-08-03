#!/usr/bin/perl -w

use warnings;
use strict;

use constant TESTS_IN_TEST_CALENDAR => 15;
use Test::More tests => 6 + 2 * TESTS_IN_TEST_CALENDAR;
use Test::LongString;
use Test::NoWarnings; # this catches our warnings like setting unknown properties

BEGIN { use_ok('Data::ICal') }



our $s;
$s = Data::ICal->new('t/ics/nonexistent.ics');

is($s, undef, "Caught no file death");

$s = Data::ICal->new('t/ics/badlyformed.ics'); 
is($s, undef, "Caught badly formed ics file death"); 

$s = Data::ICal->new('t/ics/test.ics');

isa_ok($s, 'Data::ICal');

test_calendar();

SKIP: {
    skip "Can't create t/ics/out.ics: $!", 1 + TESTS_IN_TEST_CALENDAR unless open(ICS,">t/ics/out.ics");
    print ICS $s->as_string;
    close ICS;

    undef($s); 
    $s = Data::ICal->new('t/ics/out.ics');
    isa_ok($s, 'Data::ICal');

    test_calendar();

    unlink('t/ics/out.ics');
}

sub test_calendar {
    is($s->ical_entry_type, 'VCALENDAR', "Is a VCALENDAR");
    my $id = $s->property('prodid')->[0]->value;
    my $name = $s->property('x-wr-calname')->[0]->value;
    is($id,'Data::ICal test', 'Got id');
    is($name,'Data::ICal test calendar', 'Got name');

    my @entries = @{$s->entries};
    is(@entries,2,"Correct number of entries");
    
    my ($event, $timezone);

    for (@entries) {
        if ( $_->ical_entry_type eq 'VEVENT' ) {
            $event = $_;
        } elsif ( $_->ical_entry_type eq 'VTIMEZONE' ) {
            $timezone = $_;
        }
    }    
    undef(@entries);

    # Event 
    isa_ok($event, 'Data::ICal::Entry::Event');
    is($event->property('location')->[0]->value, 'The Restaurant at the End of the Universe', 'Correct location');
    is($event->property('url')->[0]->value, 'http://www.bestpractical.com', 'Correct URL');
    is($event->property('url')->[0]->parameters->{VALUE}, 'URI', 'Got parameter');

    # check sub entries
    @entries = @{$event->entries};
    is(@entries, 1, "Got sub entries");
    isa_ok($entries[0],'Data::ICal::Entry::Alarm::Audio');
    undef(@entries);

    # TimeZone
    isa_ok($timezone, 'Data::ICal::Entry::TimeZone');
    is($timezone->property('tzid')->[0]->value, 'Europe/London', 'Got TimeZone ID');
    
    # check daylight and standard settings
    @entries = @{$timezone->entries};
    is(@entries, 6, 'Got Daylight/Standard Entries');
    is( grep( ($_->ical_entry_type eq 'DAYLIGHT'), @entries), 3, '3 DAYLIGHT');
    is( grep( ($_->ical_entry_type eq 'STANDARD'), @entries), 3, '3 STANDARD');
}
