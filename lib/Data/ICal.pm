use warnings;
use strict;

package Data::ICal;
use base qw/Data::ICal::Entry/;

use Text::vFile::asData;

our $VERSION = '0.02';

use Carp;

=head1 NAME

Data::ICal - Generates iCalendar (RFC 2445) calendar files


=head1 SYNOPSIS

    use Data::ICal;

    my $calendar = Data::ICal->new();

    my $vtodo = Data::ICal::Entry::Todo->new();
    $vtodo->add_properties(
        # ... see Data::ICal::Entry::Todo documentation
    );

    # ... or

    $calendar = Data::ICal->new('foo.ics'); # parse existing file


    $calendar->add_entry($vtodo);

    print $calendar->as_string;
  
=head1 DESCRIPTION

A L<Data::ICal> object represents a C<VCALENDAR> object as defined in the
iCalendar protocol (RFC 2445, MIME type "text/calendar"), as implemented in many
popular calendaring programs such as Apple's iCal.  L<Data::ICal> only provides
the ability to generate ICal files, not to parse them.

Each L<Data::ICal> object is a collection of "entries", which are objects of a
subclass of L<Data::ICal::Entry>.  The types of entries defined by iCalendar
(which refers to them as "components") include events, to-do items, journal
entries, free/busy time indicators, and time zone descriptors; in addition,
events and to-do items can contain alarm entries.  (Currently, L<Data::ICal>
only implements to-do items and events.)

L<Data::ICal> is a subclass of L<Data::ICal::Entry>; see its manpage for more
methods applicable to L<Data::ICal>.

=head1 METHODS

=cut

=head2 new

Creates a new L<Data::ICal> object. 

If a file name is passed, this parses that file into the object; otherwise it
just sets its C<VERSION> and C<PRODID> properties to "2.0" and the value of the
C<product_id> method respectively.

Returns undef upon failure to open file or parse .ics file.

=cut

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new(@_);

    if (@_) {
        $self->parse_file(@_) || return undef;
    } else {
        $self->add_properties(
            version => '2.0',
            prodid  => $self->product_id,
        );
    }
    return $self;
}

=head2 parse_file

Parse a .ics file and populate a L<Data::ICal> object.

=cut

sub parse_file {
    my ( $self, $file ) = @_;

    # open the file (checking as we go, like good little Perl mongers)
    open my ($fh), $file or return undef;
    my $cal = Text::vFile::asData->new->parse($fh) || return undef;
    close $fh;

    return undef unless exists $cal->{objects};

    # loop through all the vcards
    foreach my $object ( @{ $cal->{objects} } ) {
        $self->parse_object($object);
    }
    return 1;
}

=head2 ical_entry_type

Returns C<VCALENDAR>, its iCalendar entry name.

=cut

sub ical_entry_type {'VCALENDAR'}

=head2 product_id

Returns the product ID used in the calendar's C<PRODID> property; you may
wish to override this in a subclass for your own application.

=cut

sub product_id {
    my $self = shift;
    return "Data::ICal $VERSION";
}

=head2 mandatory_unique_properties

According to the iCalendar standard, the following properties must be specified
exactly one time for a calendar:

      prodid version

=cut

sub mandatory_unique_properties {
    qw(
        prodid version
    );
}

=head2 optional_unique_properties

According to the iCalendar standard, the following properties may be specified
at most one time for a calendar:

      calscale method

=cut

sub optional_unique_properties {
    qw(
        calscale method
    );
}

=head1 CONFIGURATION AND ENVIRONMENT

L<Data::ICal> requires no configuration files or environment variables.


=head1 DEPENDENCIES

L<Data::ICal> requires L<Class::Accessor>.


=head1 INCOMPATIBILITIES

None reported.


=head1 BUGS AND LIMITATIONS

L<Data::ICal> does not support time zone daylight or standard entries, so time zone
components are basically useless.

While L<Data::ICal> tries to check which properties are required and repeatable, this
only works in simple cases; it does not check for properties that must either both exist
or both not exist, or for mutually exclusive properties.

L<Data::ICal> does not check to see if property parameter names are known in
general or allowed on the particular property.

L<Data::ICal> does not check to see if nested entries are nested properly (alarms in
todos and events only, everything else in calendars only).

L<Data::ICal> has no automatic support for converting binary data to the appropriate
encoding and setting the corresponding parameters.

There is no L<Data::ICal::Entry::Alarm> base class.

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-data-ical-generator@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


=head1 AUTHOR

Jesse Vincent  C<< <jesse@bestpractical.com> >> with David Glasser and Simon Wistow


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2005, Best Practical Solutions, LLC.  All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

=cut

1;
