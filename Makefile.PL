use inc::Module::Install;

name ('Data-ICal');
author ('Jesse Vincent <jesse@bestpractical.com>');
version_from ('lib/Data/ICal.pm');
abstract_from('lib/Data/ICal.pm');
license('perl');
build_requires('Test::More');
build_requires('Test::Warn');
build_requires('Test::NoWarnings');
build_requires('Test::LongString');
requires('Class::Accessor');
requires('Text::vFile::asData');
requires('MIME::QuotedPrint');
requires('Class::ReturnValue');

&WriteAll;
