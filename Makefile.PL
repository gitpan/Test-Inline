use inc::Module::Install;

# Generate configuration
name           ( 'Test-Inline'                        );
abstract       ( 'Inlining your tests next to the code being tested' );
author         ( 'Adam Kennedy <adam@ali.as>'         );
version_from   ( 'lib/Test/Inline.pm'                 );
requires       ( 'perl'                  => '5.005'   );

# Other people's CPAN modules
requires       ( 'File::Spec'            => '0.80'    );
requires       ( 'List::Util'            => '1.11'    );
requires       ( 'Getopt::Long'          => '2.34'    );
requires       ( 'File::Slurp'           => '9999.04' );
requires       ( 'File::Find::Rule'      => '0.26'    );

# My CPAN modules
requires       ( 'Config::Tiny'          => '2.00'    );
requires       ( 'Params::Util'          => '0.05'    );
requires       ( 'Class::Autouse'        => '1.15'    );
requires       ( 'Algorithm::Dependency' => '1.02'    );
requires       ( 'File::Flat'            => '0.95'    );

# Because some programs incorrectly do things like...
#   if ( installed('Test::Inline') ) { system('pod2test') }
# ... we need to make sure it is installed.
# This is a temporary arrangement to end in 2008.
requires       ( 'Pod::Tests'            => '0.18'    );

# Testing modules (bundled where appropriate)
build_requires ( 'Test::More'            => '0.47'    );
build_requires ( 'Test::ClassAPI'        => '1.02'    );
include        ( 'Test::ClassAPI'                     );
include        ( 'Class::Inspector'                   );

# Miscellaneous items
install_script ( 'bin/inline2test'                    );
no_index       ( directory               => 't.data'  );
auto_install   (                                      );

&WriteAll;
