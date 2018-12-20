package Logger;

use 5.018002;
use strict;
use warnings;
use Term::ANSIColor;
use Date;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(
  warn
  err
  log
  info
);

use constant WARN_COLOR => "yellow";
use constant INFO_COLOR => "blue";
use constant ERROR_COLOR => "red";
use constant LOG_COLOR => "white";

sub print_color_msg {
  my ($msg, $color, $is_bold) = @_;
  my $bold = $is_bold || "bold";

  print color "$bold $color";
  print "$msg\n";
  print color "reset";
}

sub warn {
  my ($msg) = @_;

  print_color_msg($msg, WARN_COLOR);
}

sub err {
  my ($msg) = @_;

  print_color_msg("Error: $msg", ERROR_COLOR);
}

sub info {
  my ($msg) = @_;

  print_color_msg($msg, INFO_COLOR);
}

sub log {
  my ($msg) = @_;

  print_color_msg(get_date_msg . " $msg", LOG_COLOR);
}

1;
