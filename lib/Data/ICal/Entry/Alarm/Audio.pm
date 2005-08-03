use warnings;
use strict;

package Data::ICal::Entry::Alarm::Audio;

use base qw/Data::ICal::Entry/;

=head1 NAME

Data::ICal::Entry::Alarm::Audio - Represents an audio alarm in an iCalendar file


=head1 SYNOPSIS

    my $valarm = Data::ICal::Entry::Alarm::Audio->new();
    $valarm->add_properties(
        attach => [ "ftp://host.com/pub/sounds/bell-01.aud", { fmttype => "audio/basic" } ],
	# Dat*e*::ICal is not a typo here
        trigger   => [ Date::ICal->new( epoch => ... )->ical, { value => 'DATE-TIME' } ],
    );

    $vevent->add_entry($valarm);
  
=head1 DESCRIPTION

A L<Data::ICal::Entry::Alarm::Audio> object represents an audio alarm attached
to a todo item or event in an iCalendar file.  (Note that the iCalendar RFC
refers to entries as "components".)  It is a subclass of L<Data::ICal::Entry>
and accepts all of its methods.

=head1 METHODS

=cut

=head2 new

Creates a new L<Data::ICal::Entry::Alarm::Audio> object; sets its C<ACTION> property
to C<AUDIO>.

=cut

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new(@_);
    $self->add_property( action => "AUDIO" );
    return $self;
}

=head2 ical_entry_type

Returns C<VALARM>, its iCalendar entry name.

=cut

sub ical_entry_type {'VALARM'}

=head2 optional_unique_properties

According to the iCalendar standard, the following properties may be specified
at most one time for an audio alarm:

	duration repeat attach

Note that if one of C<duration> or C<repeat> is specified, the other one must be also,
though this module does not enforce that restriction.

=cut

sub optional_unique_properties {
    qw(
        duration repeat attach
    );
}

=head2 mandatory_unique_properties

According to the iCalendar standard, the C<trigger> property must be specified
exactly once for an audio alarm.  (In addition, the C<action> property must be
specified exactly once, but the module automatically sets it for you.)

=cut

sub mandatory_unique_properties {
    qw(
        action trigger
    );
}

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
