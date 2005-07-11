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

use Test::More tests => 11;

# Check their perl version
ok( $] >= 5.005, "Your perl is new enough" );

# Does the module load
use Class::Autouse ':devel';
use_ok('Test::Inline::Content'          );
use_ok('Test::Inline::Content::Legacy'  );
use_ok('Test::Inline::Content::Default' );
use_ok('Test::Inline::Content::Simple'  );
use_ok('Test::Inline::Extract'          );
use_ok('Test::Inline::IO::File'         );
use_ok('Test::Inline'                   );
use_ok('Test::Inline::Util'             );
use_ok('Test::Inline::Script'           );
use_ok('Test::Inline::Section'          );

exit(0);
