use v6.c;

use GTK::Application;
use GIMP::Env;
use GIMP::Image;
use GIMP::Display;

sub MAIN ($filename) {
  my $a = GTK::Application.new( title => 'org.genex.gimp.image-display' );

  $a.activate.tap(-> *@a {
    CATCH {
      default { .message.say; .backtrace.concise.say; }
    }

    say "F: { $filename.IO.r }";

    if GIMP::Image.file.load($filename, :interactive) -> $i {
      say "I: { $i.^name } { $i.WHERE // '»NIL«' }";

      my $d = GIMP::Display.new($i);

      say "D: { $d.WHERE }";

      $d.present;
      #$a.window.add($d);
      #$a.window.show_all;
    } else {
      $a.quit( :gio )
    }
  });

  $a.run;
}
