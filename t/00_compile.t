#!/usr/bin/perl -w

# Compile testing for Test::Inline

use strict;
use lib ();
use UNIVERSAL 'isa';
use File::Spec::Functions ':ALL';
BEGIN {
	$| = 1;
	unless ( $ENV{HARNESS_ACTIVE} ) {
		require FindBin;
		chdir ($FindBin::Bin = $FindBin::Bin); # Avoid a warning
		lib->import( catdir( updir(), updir(), 'modules') );
	}
}

use Test::More tests => 7;

# Check their perl version
ok( $] >= 5.005, "Your perl is new enough" );

# Does the module load
use Class::Autouse ':devel';
use_ok('Test::Inline'                  );
use_ok('Test::Inline::Util'            );
use_ok('Test::Inline::Script'          );
use_ok('Test::Inline::Section'         );
use_ok('Test::Inline::Handler::File'   );
use_ok('Test::Inline::Handler::Extract');

exit(0);
