#!/usr/bin/perl -w

use warnings;
use strict;

use Test::More tests => 4;
use Test::LongString;
use Test::NoWarnings;

BEGIN { use_ok('Data::ICal') }

my $cal = Data::ICal->new(data => <<'END_VCAL');
BEGIN:VCALENDAR
BEGIN:VTODO
DESCRIPTION;ENCODING=QUOTED-PRINTABLE:interesting things         =0D=0A
 Yeah!!=3D =63bla=0D=0A=0D=0A=0D=0AGo team syncml!=0D=0A=0D=0A=0D=0A
END:VTODO
END:VCALENDAR
END_VCAL

isa_ok($cal, 'Data::ICal');

is_string($cal->entries->[0]->property("description")->[0]->decoded_value, <<"END_DESC");
interesting things         \r
Yeah!!= cbla\r
\r
\r
Go team syncml!\r
\r
\r
END_DESC


__END__
DESCRIPTION;ENCODING=QUOTED-PRINTABLE;CHARSET=UTF-8:interesting thi=
ngs         =0D=0A=
Yeah!!=3D =C3=AAtre=0D=0A=
=0D=0A=
=0D=0A=
Go team syncml!=0D=0A=
=0D=0A=
=0D=0A=
END_DESC

