use warnings;
use strict;

package Data::ICal::Entry::FreeBusy;

use base qw/Data::ICal::Entry/;

=head1 NAME

Data::ICal::Entry::FreeBusy - Represents blocks of free and busy time in an iCalendar file


=head1 SYNOPSIS

    my $vfreebusy = Data::ICal::Entry::FreeBusy->new();
    $vfreebusy->add_properties(
        organizer => 'MAILTO:jsmith@host.com',
	# Dat*e*::ICal is not a typo here
        freebusy   => Date::ICal->new( epoch => ... )->ical . '/' . Date::ICal->new( epoch => ... )->ical,
    );

    $calendar->add_entry($vfreebusy);
  
=head1 DESCRIPTION

A L<Data::ICal::Entry::FreeBusy> object represents a request for information about free and
busy time or a reponse to such a request, in an iCalendar file.
(Note that the iCalendar RFC refers to entries as "components".)  It is a subclass
of L<Data::ICal::Entry> and accepts all of its methods.

=head1 METHODS

=cut

=head2 ical_entry_type

Returns C<VFREEBUSY>, its iCalendar entry name.

=cut

sub ical_entry_type {'VFREEBUSY'}

=head2 optional_unique_properties

According to the iCalendar standard, the following properties may be specified
at most one time for a free/busy entry:

	contact  dtstart  dtend  duration  dtstamp 
	organizer  uid  url 

=cut

sub optional_unique_properties {
    qw(
        contact  dtstart  dtend  duration  dtstamp
        organizer  uid  url
    );
}

=head2 optional_repeatable_properties

According to the iCalendar standard, the following properties may be specified
any number of times for free/busy entry:

        attendee comment freebusy request-status

=cut

sub optional_repeatable_properties {
    qw(
        attendee comment freebusy request-status
    );
}

=head1 AUTHOR

Jesse Vincent  C<< <jesse@bestpractical.com> >> with David Glasser and Simon Wistow


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2005 - 2009, Best Practical Solutions, LLC.  All rights reserved.

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
