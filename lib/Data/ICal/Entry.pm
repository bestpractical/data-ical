use warnings;
use strict;

package Data::ICal::Entry;
use Data::ICal::Property;


sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}



sub as_string {
    my $self = shift;

    return join( "\n",
        $self->header, ( map { $_->as_string } @{ $self->properties } ),
        $self->footer )
      . "\n";

}

sub properties {
    my $self = shift;
    return $self->{'properties'} || [];
}

sub add_property {
    my $self = shift;
    my $prop = shift;
    my $val = shift;
    push @{$self->{'properties'}}, Data::ICal::Property->new($prop => $val);
}

sub add_properties {
    my $self = shift;
    my %args = @_;
    while (my ( $prop, $val) = each %args) {
        $self->add_property( $prop => $val);
    }
}


sub mandatory_unique_properties {
}

sub mandatory_repeatable_properties {
}

sub optional_unique_properties {
}

sub optional_repeatable_properties {
}

sub ical_entry_type {
    return 'UNDEFINED';
}

sub header {
    my $self = shift;
    return 'BEGIN:'.$self->ical_entry_type;
}

sub footer {
    my $self = shift;
    return 'END:'.$self->ical_entry_type;
}
1;
