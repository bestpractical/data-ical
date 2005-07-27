use inc::Module::Install;

name ('Data-ICal');
author ('Jesse Vincent <jesse@bestpractical.com>');
version_from ('lib/Data/ICal.pm');
abstract_from('lib/Data/ICal.pm');
license('perl');
requires('Test::More');
requires('Class::Accessor');

&WriteAll;
