#!/usr/local/bin/perl -w

use Test::More 'no_plan';

package Catch;

sub TIEHANDLE {
    my($class, $var) = @_;
    return bless { var => $var }, $class;
}

sub PRINT  {
    my($self) = shift;
    ${'main::'.$self->{var}} .= join '', @_;
}

sub READ {}
sub READLINE {}
sub GETC {}

my $Original_File = 't/Tests.t';

package main;

# pre-5.8.0's warns aren't caught by a tied STDERR.
$SIG{__WARN__} = sub { $main::_STDERR_ .= join '', @_; };
tie *STDOUT, 'Catch', '_STDOUT_' or die $!;
tie *STDERR, 'Catch', '_STDERR_' or die $!;

{
    undef $main::_STDOUT_;
    undef $main::_STDERR_;
#line 91 t/Tests.t
ok(2+2 == 4);

    undef $main::_STDOUT_;
    undef $main::_STDERR_;
}

{
    undef $main::_STDOUT_;
    undef $main::_STDERR_;
#line 103 t/Tests.t

my $foo = 0;
ok( !$foo,      'foo is false' );
ok( $foo == 0,  'foo is zero'  );


    undef $main::_STDOUT_;
    undef $main::_STDERR_;
}

{
    undef $main::_STDOUT_;
    undef $main::_STDERR_;
#line 177 t/Tests.t
  use File::Spec;
  is( $Original_File, File::Spec->catfile(qw(t Tests.t)) );

    undef $main::_STDOUT_;
    undef $main::_STDERR_;
}

    undef $main::_STDOUT_;
    undef $main::_STDERR_;
eval q{
  my $example = sub {
    local $^W = 0;

#line 113 t/Tests.t

  # This is an example.
  2+2 == 4;
  5+5 == 10;

;

  }
};
is($@, '', "example from line 113");

    undef $main::_STDOUT_;
    undef $main::_STDERR_;

    undef $main::_STDOUT_;
    undef $main::_STDERR_;
eval q{
  my $example = sub {
    local $^W = 0;

#line 122 t/Tests.t
  sub mygrep (&@) { }
  mygrep { $_ eq 'bar' } @stuff
;

  }
};
is($@, '', "example from line 122");

    undef $main::_STDOUT_;
    undef $main::_STDERR_;

    undef $main::_STDOUT_;
    undef $main::_STDERR_;
eval q{
  my $example = sub {
    local $^W = 0;

#line 131 t/Tests.t

  my $result = 2 + 2;

;

  }
};
is($@, '', "example from line 131");

{
    undef $main::_STDOUT_;
    undef $main::_STDERR_;
#line 131 t/Tests.t

  my $result = 2 + 2;

  ok( $result == 4,         'addition works' );

    undef $main::_STDOUT_;
    undef $main::_STDERR_;
}

    undef $main::_STDOUT_;
    undef $main::_STDERR_;

    undef $main::_STDOUT_;
    undef $main::_STDERR_;
eval q{
  my $example = sub {
    local $^W = 0;

#line 142 t/Tests.t

  local $^W = 1;
  print "Hello, world!\n";
  print STDERR  "Beware the Ides of March!\n";
  warn "Really, we mean it\n";

;

  }
};
is($@, '', "example from line 142");

{
    undef $main::_STDOUT_;
    undef $main::_STDERR_;
#line 142 t/Tests.t

  local $^W = 1;
  print "Hello, world!\n";
  print STDERR  "Beware the Ides of March!\n";
  warn "Really, we mean it\n";

  is( $_STDERR_, <<OUT,       '$_STDERR_' );
Beware the Ides of March!
Really, we mean it
OUT
  is( $_STDOUT_, "Hello, world!\n",                   '$_STDOUT_' );

    undef $main::_STDOUT_;
    undef $main::_STDERR_;
}

    undef $main::_STDOUT_;
    undef $main::_STDERR_;

    undef $main::_STDOUT_;
    undef $main::_STDERR_;
eval q{
  my $example = sub {
    local $^W = 0;

#line 158 t/Tests.t

  1 + 1 == 2;

;

  }
};
is($@, '', "example from line 158");

    undef $main::_STDOUT_;
    undef $main::_STDERR_;

    undef $main::_STDOUT_;
    undef $main::_STDERR_;
eval q{
  my $example = sub {
    local $^W = 0;

#line 166 t/Tests.t

  print "Hello again\n";
  print STDERR "Beware!\n";

;

  }
};
is($@, '', "example from line 166");

    undef $main::_STDOUT_;
    undef $main::_STDERR_;

