use warnings;
use strict;

package Data::ICal::Property;

use base qw/Class::Accessor/;

use Carp;

=head1 NAME

Data::ICal::Property - Represents a property on an entry in an iCalendar file

  
=head1 DESCRIPTION

A L<Data::ICal::Property> object represents a single property on an
entry in an iCalendar file.

You shouldn't need to access L<Data::ICal::Property> values directly -- just use
C<add_property> in L<Data::ICal::Entry>.

=head1 METHODS

=cut

=head2 new $key, $value, [$parameter_hash]

Creates a new L<Data::ICal::Property> with key C<$key> and value C<$value>.

If C<$parameter_hash> is provided, sets the property's parameters to it.
The parameter hash should have keys equal to the names of the parameters (case 
insensitive; parameter hashes should not contain two different keys which are
the same when converted to upper case); the values should either be a string
if the parameter has a single value or an array reference of strings if
the parameter has multiple values.

=cut

sub new {
    my $class = shift;
    my $self  = {};

    bless $self, $class;

    $self->key(shift);
    $self->value(shift);
    $self->parameters( shift || {} );
    return ($self);
}

=head2 key [$key]

Gets or sets the key name of this property.

=head2 value [$value]

Gets or sets the value of this property.

=head2 parameters [$param_hash]

Gets or sets the parameter hash reference of this property.

=cut

__PACKAGE__->mk_accessors(qw(key value parameters));

=head2 as_string

Returns the property formatted as a string (including trailing newline).

=cut

sub as_string {
    my $self   = shift;
    my $string = uc( $self->key )
        . $self->_parameters_as_string . ":"
        . $self->value . "\n";

  # Assumption: the only place in an iCalendar that needs folding are property
  # lines
    return $self->_fold($string);
}

=begin private

=head2 _parameters_as_string

Returns the property's parameters as a string.  Properties are sorted alphabetically
to aid testing.

=end private

=cut

sub _parameters_as_string {
    my $self = shift;
    my $out  = '';
    for my $name ( sort keys %{ $self->parameters } ) {
        my $value = $self->parameters->{$name};
        $out .= ';'
            . uc($name) . '='
            . $self->_quoted_parameter_values(
            ref $value ? @$value : $value );
    }
    return $out;
}

=begin private

=head2 _quoted_parameter_values @values

Quotes any of the values in C<@values> that need to be quoted and returns the quoted values
joined by commas.

If any of the values contains a double-quote, erases it and emits a warning.

=end private

=cut

sub _quoted_parameter_values {
    my $self   = shift;
    my @values = @_;

    for my $val (@values) {
        if ( $val =~ /"/ ) {

            # Get all the way back to the user's code
            local $Carp::CarpLevel = $Carp::CarpLevel + 1;
            carp "Invalid parameter value (contains double quote): $val";
            $val =~ tr/"//d;
        }
    }

    return join ',', map { /[;,:]/ ? qq("$_") : $_ } @values;
}

=begin private

=head2 _fold $string

Returns C<$string> folded with newlines and leading whitespace so that each
line is at most 75 characters.

(Note that it folds at 75 characters, not 75 bytes as specified in the standard.)

=end private

=cut

sub _fold {
    my $self   = shift;
    my $string = shift;

    # We can't just use a s//g, because we need to include the added space and
    # first character of the next line in the count for the next line.
    while ( $string =~ /(.{76})/ ) {
        $string =~ s/(.{75})(.)/$1\n $2/;
    }
    return $string;
}

1;

