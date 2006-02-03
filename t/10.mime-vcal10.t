#!/usr/bin/perl -w

use warnings;
use strict;

use Test::More tests => 7;
use Test::LongString;
use Test::NoWarnings;

my $encoded_vcal = <<'END_VCAL';
BEGIN:VCALENDAR
PRODID:Data::ICal 0.07
VERSION:1.0
BEGIN:VTODO
DESCRIPTION;ENCODING=QUOTED-PRINTABLE:interesting things         =0D=0AYea=
h!!=3D cbla=0D=0A=0D=0A=0D=0AGo team syncml!=0D=0A=0D=0A=0D=0A
END:VTODO
END:VCALENDAR
END_VCAL

my $decoded_desc = <<'END_DESC';
interesting things         
Yeah!!= cbla


Go team syncml!


END_DESC

BEGIN { use_ok('Data::ICal') }

my $cal = Data::ICal->new(data => $encoded_vcal, vcal10 => 1);

isa_ok($cal, 'Data::ICal');

is_string($cal->entries->[0]->property("description")->[0]->decoded_value, $decoded_desc);

$cal = Data::ICal->new;

BEGIN { use_ok 'Data::ICal::Entry::Todo' }

$cal = Data::ICal->new(vcal10 => 1);

isa_ok($cal, 'Data::ICal');

my $todo = Data::ICal::Entry::Todo->new;
$cal->add_entry($todo);

$todo->add_property(description => $decoded_desc);

$cal->entries->[0]->property('description')->[0]->encode('QUotED-PRintabLE');
is_string($cal->as_string, $encoded_vcal);


__END__
possibly useful later
DESCRIPTION;ENCODING=QUOTED-PRINTABLE;CHARSET=UTF-8:interesting thi=
ngs         =0D=0A=
Yeah!!=3D =C3=AAtre=0D=0A=
=0D=0A=
=0D=0A=
Go team syncml!=0D=0A=
=0D=0A=
=0D=0A=
END_DESC

