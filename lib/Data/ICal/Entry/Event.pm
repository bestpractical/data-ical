use warnings;
use strict;

package Data::ICal::Entry::Event;

use base qw/Data::ICal::Entry/;

=head1 NAME

Data::ICal::Entry::Event - Represents an event in an iCalendar file


=head1 SYNOPSIS

    my $vevent = Data::ICal::Entry::Event->new();
    $vevent->add_properties(
        summary => "my party",
        description => "I'll cry if I want to",
	# Dat*e*::ICal is not a typo here
        dtstart   => Date::ICal->new( epoch => time )->ical,
    );

    $calendar->add_entry($vevent);

    $vevent->add_entry($alarm); 
  
=head1 DESCRIPTION

A L<Data::ICal::Entry::Event> object represents a single event in an iCalendar file.
(Note that the iCalendar RFC refers to entries as "components".)  It is a subclass
of L<Data::ICal::Entry> and accepts all of its methods.

=head1 METHODS

=cut

=head2 ical_entry_type

Returns C<VEVENT>, its iCalendar entry name.

=cut

sub ical_entry_type {'VEVENT'}

=head2 optional_unique_properties

According to the iCalendar standard, the following properties may be specified
at most one time for an event:

	class  created  description  dtstart  geo 
	last-modified  location  organizer  priority 
	dtstamp  sequence  status  summary  transp 
	uid  url  recurrence-id 

In addition, C<dtend> and C<duration> may be specified at most once each, but not both
in the same entry (though this restriction is not enforced).

=cut

sub optional_unique_properties {
    qw(
        class  created  description  dtstart  geo
        last-modified  location  organizer  priority
        dtstamp  sequence  status  summary  transp
        uid  url  recurrence-id

        dtend duration
    );
}

=head2 optional_repeatable_properties

According to the iCalendar standard, the following properties may be specified
any number of times for an event:

	attach  attendee  categories  comment 
	contact  exdate  exrule  request-status  related-to 
	resources  rdate  rrule  

=cut

sub optional_repeatable_properties {
    qw(
        attach  attendee  categories  comment
        contact  exdate  exrule  request-status  related-to
        resources  rdate  rrule
    );
}

=head1 AUTHOR

Jesse Vincent  C<< <jesse@bestpractical.com> >>


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
