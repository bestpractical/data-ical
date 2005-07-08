use inc::Module::Install;

name ('Data-iCal');
author ('Jesse Vincent <jesse@bestpractical.com>');
version_from ('lib/Data/iCal.pm');
abstract_from('lib/Data/iCal.pm');
license('perl');
requires('Test::More');

&WriteAll;
