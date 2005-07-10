#!/usr/bin/perl -w

# Test as much of Test::Inline::Content (and subclasses)

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

use Test::More tests => 21;
use Test::Inline ();





#####################################################################
# Test::Inline::Content Tests

my $Content = Test::Inline::Content->new;
isa_ok( $Content, 'Test::Inline::Content' );

# We'll need an Inline object
my $Inline = Test::Inline->new;
isa_ok( $Inline, 'Test::Inline' );
my $example = File::Spec->catfile( 't.data', 'example' );
ok( $Inline->add( $example ), 'Adding example file' );

# Check the ::Script object created by the addition
my $Script = $Inline->class('Foo::Bar');
isa_ok( $Script, 'Test::Inline::Script' );

# Generate the content badly
is( $Content->process(), undef, '->process(bad) return undef' );
is( $Content->process($Inline), undef, '->process(bad) return undef' );
is( $Content->process($Inline, 1), undef, '->process(bad) return undef' );
is( $Content->process($Inline, 'Test::Inline::Script'), undef, '->process(bad) return undef' );

# Generate it properly
my $rv = $Content->process($Inline, $Script);
ok( (defined $rv and ! ref $rv and length $rv), '->process(good) returns a string' );
ok( $rv =~ /\bfail\(/, '->process returns a failing default script' );





#####################################################################
# Test::Inline::Content::Legacy Tests

is( Test::Inline::Content::Legacy->new(),      undef, '->Legacy() returns undef' );
is( Test::Inline::Content::Legacy->new(undef), undef, '->Legacy() returns undef' );
is( Test::Inline::Content::Legacy->new(1),     undef, '->Legacy() returns undef' );
is( Test::Inline::Content::Legacy->new(1),     undef, '->Legacy() returns undef' );
my $foo = 0;
my $Legacy = Test::Inline::Content::Legacy->new( sub {
	Test::More::isa_ok( $_[0], 'Test::Inline' );
	Test::More::isa_ok( $_[1], 'Test::Inline::Script' );
	$foo++;
	return "bar";
} );
is( ref($Legacy->coderef), 'CODE', '->coderef returns the ref' );
$rv = $Legacy->process( $Inline, $Script );
is( $foo, 1, 'Legacy function ran as expected' );
is( $rv, 'bar', 'Legacy->process returns as expected' );





#####################################################################
# Test::Inline::Content::Default Tests

my $Default = Test::Inline::Content::Default->new;
isa_ok( $Default, 'Test::Inline::Content::Default' );
$rv = $Default->process( $Inline, $Script );
ok( (defined $rv and ! ref $rv and length $rv), '->process(good) returns a string' );

