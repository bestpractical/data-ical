use warnings;
use strict;

package Data::ICal::Todo;

use base qw/Data::ICal::Entry/;

sub ical_entry_type { 'VTODO' }
sub optional_unique_properties {
    qw(
      class  completed  created  description  dtstamp
      dtstart  geo  last-mod  location  organizer
      percent  priority  recurid  seq  status
      summary  uid  url
    );
}

sub optional_repeatable_properties {
    qw(
      attach  attendee  categories  comment  contact
      exdate  exrule  rstatus  related  resources
      rdate  rrule  x-prop
    );
}



1;
