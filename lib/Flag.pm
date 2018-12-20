package Flag;

use 5.018002;
use strict;
use warnings;
use Logger;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT = qw(
  var
  parse
);

our $VERSION = '0.01';

my %CLI_params = ();

sub must {
  my ($tag, $value) = @_;

  if(!defined($value)){
    die err("$tag cannot be undef");
  }
}

sub is_param {
  my ($value) = @_;
  my @value_arr = split "", $value;
  my $prefix = shift @value_arr;

  $prefix eq "-";
}

sub var {
  my @tags = qw(
    name
    default
    help
  );

  foreach (0..2) {
    must($tags[$_], $_[$_]);
  }

  my ($name, $default, $help) = @_;
  my %params = ('name'=>$name, 'default'=>$default, 'help'=>$help);

  $CLI_params{$name} = {%params};
}

sub parse {
  my (@args) = @ARGV;
  my %params = ();
  my ($key, $value, $str);

  # No register var or no CLI params
  if(!scalar(@args) || !scalar(keys %CLI_params)){
    die err("There are no parameters.");
  }

  for(my $i = 0;$i < scalar @args;$i += 2){
    $str = $args[$i];
    $key = substr $str, 1, length $str;
    $value = $args[$i + 1];

    if(!defined($value) || is_param($value)){
      my $help_info = $CLI_params{$key}{"help"};

      die err("Usage: -$key <args> --$help_info\n");
    }

    $params{$key} = $value;
  }

  %params;
}

1;
