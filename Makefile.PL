use inc::Module::Install;

name ('Data-ICal');
author ('Jesse Vincent <jesse@bestpractical.com>');
version_from ('lib/Data/ICal.pm');
abstract_from('lib/Data/ICal.pm');
license('perl');
build_requires('Test::More');
build_requires('Test::Warn');
build_requires('Test::NoWarnings');
requires('Class::Accessor');

&WriteAll;
