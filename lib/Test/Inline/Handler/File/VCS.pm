package Test::Inline::Handler::File::VCS;

=pod

=head1 NAME

Test::Inline::Handler::File - Test::Inline IO Handler for Version Control Systems

=head1 DESCRIPTION

This class implements a Test::Inline 2 IO Handler for outputing test files
into trees of directories checkout out from a version control system.

=head1 METHODS

=cut

use strict;
use File::Spec ();
use base 'Test::Inline::Handler::File';

use vars qw{$VERSION};
BEGIN {
	$VERSION = '2.00_09';
}





#####################################################################
# Constructor and Accessors

=pod

=head2 new $path

The C<new> constructor takes a root path of the checkout module and creates
an IO handler for that location.

If not passed a param, it will assume the current directory
as the root of the module. If set to a subdirectory, this should not be
fatal, as long as the directory is added to the repository.

The constructor will automatically detect the type of version control
system in use, and should act accordindly.

Initially, this class support CVS and Subversion.

Returns a new C<Test::Inline::Handler::File::VCS>, or C<undef> if it
cannot determine the VCS type.

=cut

sub new {
	my $class = shift;
	my $self  = $class->SUPER::new( @_ ) or return undef;

	# Are we a Subversion checkout
	if ( $self->exists_dir( '.svn' ) ) {
		$self->{VCS} = 'SVN';
	} elsif ( $self->exists_dir('CVS') and $self->exists_file('CVS/Root') ) {
		$self->{VCS} = 'CVS';
	} else {
		return undef;
	}

	$self;
}

=pod

=head2 VCS

The C<VCS> accessor returns the code for the version control system.

Currently, this is C<'CVS'> for CVS, or C<'SVN'> for Subversion.

=cut

sub VCS { $self->{type} }





#####################################################################
# Filesystem API

=pod

=head2 write $file, $content

The C<write> method works as for the parent L<Test::Inline::Handler::File>
class, except that if the file does not yet exist, it will be additionally
added to the version control system.

=cut

sub write {
	my $self   = shift;
	my $adding = $self->exists_file($_[0]);

	# Add the file
	my $rv = $self->SUPER::write( @_ );
	return $rv unless $rv;
	return $rv unless $adding;

	# Add via the VCS's driver
	if ( $self->VCS eq 'CVS' ) {
		$self->_cvs_add( @_ ) or return undef;
	} elsif ( $self->VCS eq 'SVN' ) {
		$self->_svn_add( @_ ) or return undef;
	}

	$rv;
}

sub _cvs_add {
	my $self = shift;

	### FIXME - Complete this. Silently return true for now.
	1;
}

sub _svn_add {
	my $self = shift;

	### FIXME - Complete this. Silently return true for now.
	1;
}

1;

=pod

=head1 TO DO

- Support additional Version Control Systems

=head1 SUPPORT

See the main L<SUPPORT|Test::Inline/SUPPORT> section.

=head1 AUTHOR

Adam Kennedy (Maintainer), L<http://ali.as/>, cpan@ali.as

=head1 COPYRIGHT

Copyright (c) 2004 - 2005 Phase N Austalia. All rights reserved.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
