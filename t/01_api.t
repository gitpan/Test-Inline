#!/usr/bin/perl -w

# Formal testing for Test::Inline.
# Tests loading and API of classes.

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

# Load the class to test
use Test::Inline;

# Execute the API test
use Test::More 'tests' => 75;
use Test::ClassAPI;
Test::ClassAPI->execute('complete', 'collisions');

1;

__DATA__

Algorithm::Dependency::Source=interface
Algorithm::Dependency::Item=interface

[Test::Inline]
Algorithm::Dependency::Source=isa
new=method
ExtractHandler=method
InputHandler=method
OutputHandler=method
add=method
add_class=method
add_all=method
classes=method
class=method
filenames=method
schedule=method
manifest=method
save=method

[Test::Inline::Section]
Algorithm::Dependency::Item=isa
parse=method
new=method
begin=method
setup=method
example=method
context=method
name=method
after=method
classes=method
tests=method
anonymous=method
content=method

[Test::Inline::Script]
Algorithm::Dependency::Source=isa
Algorithm::Dependency::Item=isa
new=method
class=method
filename=method
config=method
setup=method
sections=method
sorted=method
merged_content=method
tests=method
file_content=method

[Test::Inline::Handler::Extract]
new=method
elements=method

[Test::Inline::Handler::File]
new=method
exists_file=method
exists_dir=method
read=method
write=method
class_file=method
find=method

[Algorithm::Dependency::Source]
load=method
item=method
items=method
missing_dependencies=method

[Algorithm::Dependency::Item]
id=method
depends=method
