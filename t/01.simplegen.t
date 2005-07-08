#!/usr/bin/perl -w

use warnings;
use strict;

use Test::More tests => 15;

use_ok('Data::ICal');

my $s = Data::ICal->new();

isa_ok($s, 'Data::ICal');

can_ok($s, 'as_string');

can_ok($s, 'add_entry');


use_ok('Data::ICal::Todo');

my $todo = Data::ICal::Todo->new();
isa_ok($todo, 'Data::ICal::Entry');


can_ok($todo, 'add_property');
can_ok($todo, 'add_properties');
can_ok($todo, 'properties');


$todo->add_properties( url => 'http://example.com/todo1',
                        summary => 'A sample todo',
                        comment => 'a first comment',
                        comment => 'a second comment',
                        summary => 'This summary trumps the first summary'
                    
                    );


is(scalar @{$s->entries},0);
ok($s->add_entry($todo));
is(scalar @{ $s->entries},1);


my $output = $s->as_string;

like( $output, qr/^BEGIN:VCALENDAR/, "Starts ok");
like( $output, qr/END:VCALENDAR/, "Ends ok");
like($output, qr/BEGIN:VTODO/, "has a single vtodo");

