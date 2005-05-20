use inc::Module::Install;

name           ( 'Test-Inline'                        );
abstract       ( 'Inlining your tests next to the code being tested' );
author         ( 'Adam Kennedy<adam@ali.as>'          );
version_from   ( 'lib/Test/Inline.pm'                 );
requires       ( 'perl'                  => '5.005'   );
requires       ( 'File::Spec'            => '0.82'    );
requires       ( 'List::Util'            => '1.11'    );
requires       ( 'File::Slurp'           => '9999.04' );
requires       ( 'File::Find::Rule'      => '0.26'    );
requires       ( 'Algorithm::Dependency' => '1.02'    );
requires       ( 'Class::Autouse'        => '1.15'    );
requires       ( 'File::Flat'            => '0.95'    );
requires       ( 'Getopt::Long'          => '2.34'    );
build_requires ( 'Test::More'            => '0.47'    );
build_requires ( 'Test::ClassAPI'        => '1.02'    );
install_script ( 'bin/inline2test'                    );
no_index       ( directory               => 't.data'  );

auto_install();

&WriteAll;
