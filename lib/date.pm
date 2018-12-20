package Date;

use strict;
use 5.018002;
use warnings;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(
  get_date_msg
);

sub process_time {
  my ($time) = @_;

  length $time == 1 ? '0' . $time : $time;
}

sub easy_process_time {
  my (@time_list) = @_;
  my @result = ();

  foreach (@time_list) {
    push @result, process_time($_);
  }

  @result;
}

sub get_date_msg {
  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();

  ($mon, $mday, $hour, $min, $sec) = easy_process_time(($mon, $mday, $hour, $min, $sec));

  "[$year-$mon-$mday $hour:$min:$sec]";
}

1;
