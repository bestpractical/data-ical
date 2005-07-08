use warnings;
use strict;

package Data::iCal::Property;

use base qw/Class::Accessor/;

__PACKAGE__->mk_accessors(qw(key value));

sub new {
    my $class = shift;
    my $self = {};
    
    bless $self, $class;

    $self->key(shift);
    $self->value(shift);
    return ($self);
}

sub as_string {
    my $self = shift;
    return uc($self->key).":".$self->value;
}

1;

