#!/usr/bin/perl -w

# Regression testing for rt.cpan.org

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

use Class::Autouse ':devel';
use Test::More tests => 3;
use Test::Inline ();





# Change to the correct directory
chdir catdir( 't.data', '09_regression' ) or die "Failed to change to test directory";





#####################################################################
# Regression tests for rt.cpan.org bug #557
# (Test::Inline doesn't catch improper nesting)

{
	# Create basic Test::Inline object
	my $Inline = My::Inline->new();
	isa_ok( $Inline, 'Test::Inline' );

	my @errors = '';

	# Add the files
	my $rv = $Inline->add( 'My/BadPodNesting.pm' );
	is( $rv, undef, 'Adding bad file returns undef' );
	is_deeply( \@errors, [ 
		'Failed to parse sections: Test::Inline::Section: POD statement \'=begin testing bar\' illegally nested inside of section \'=begin testing foo\''
		],
		'Bad nesting error is triggered as expected' );

	package My::Inline;
	
	use base 'Test::Inline';

	sub _error {
		shift;
		@errors = @_;
		undef;
	}

	1;
}
