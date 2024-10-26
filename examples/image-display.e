use v6.c;

use GTK::Application;
use GIMP::Env;
use GIMP::Image;

# cw: As an extension or Plugin.

sub MAIN ($filename) {
  if GIMP::Image.file.load($filename, :interactive) -> $i {
    say "I: { $i.^name } { $i.WHERE // '»NIL«' }";

    #my $d = GIMP::Display.new($i);

    #say "D: { $d.WHERE }";

    #$d.present;
    #$a.window.add($d);
    #$a.window.show_all;
  } else {
    exit;
  }
}
