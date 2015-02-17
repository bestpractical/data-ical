use warnings;
use strict;

package Data::ICal::Entry::Alarm;

use base qw/Data::ICal::Entry/;

=head1 NAME

Data::ICal::Entry::Alarm - Abstract base class for alarms

=head1 DESCRIPTION

L<Data::ICal::Entry::Alarm> is an abstract base class for the other type
of supported by alarms:

=over

=item L<Data::ICal::Entry::Alarm::Audio>

=item L<Data::ICal::Entry::Alarm::Display>

=item L<Data::ICal::Entry::Alarm::Email>

=item L<Data::ICal::Entry::Alarm::Procedure>

=back

It is a subclass of L<Data::ICal::Entry> and accepts all of its methods.

=head1 METHODS

=cut

=head2 new


=cut

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new(@_);
    die "Can't instantiate abstract base class Data::ICal::Entry::Alarm"
        if $class eq __PACKAGE__;
    return $self;
}

=head2 ical_entry_type

Returns C<VALARM>, its iCalendar entry name.

=cut

sub ical_entry_type {'VALARM'}

=head2 optional_unique_properties

According to the iCalendar standard, the C<duration> and C<retreat>
properties may be specified at most one time all types of alarms; if one
is specified, the other one must be also, though this module does not
enforce that restriction.

=cut

sub optional_unique_properties {
    qw(
        duration repeat
    );
}

=head2 mandatory_unique_properties

According to the iCalendar standard, the C<trigger> property must be
specified exactly once for an all types of alarms; subclasses may have
additional required properties.

In addition, the C<action> property must be specified exactly once, but
all subclasses automatically set said property appropriately.

=cut

sub mandatory_unique_properties {
    qw(
        action trigger
    );
}

=head1 AUTHOR

Jesse Vincent C<< <jesse@bestpractical.com> >> with David Glasser,
Simon Wistow, and Alex Vandiver

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
