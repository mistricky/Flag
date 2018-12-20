package Flag;

use 5.018002;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT = qw(

);

our $VERSION = '0.01';

my %CLI_params = ();

sub is_param {
  my ($value) = @_;
  my @value_arr = split "", $value;
  my $prefix = shift @value_arr;

  $prefix eq "-";
}

sub var {
  my ($name, $default, $help) = @_;
  my %params = ('name'=>$name, 'default'=>$default, 'help'=>$help);

  print "$name, $default, $help\n";

  $CLI_params{$name} = {%params};
}

sub parse {
  my (@args) = @_;
  my %params = ();
  my ($key, $value, $str);

  for(my $i = 0;$i < scalar @args;$i += 2){
    $str = $args[$i];
    $key = substr $str, 1, length $str;
    $value = $args[$i + 1];

    if(!defined($value) || is_param($value)){
      my $help_info = $CLI_params{$key}{"help"};

      die "Usage -$key $help_info\n";
    }

    $params{$key} = $value;
  }

  return %params;
}

1;
