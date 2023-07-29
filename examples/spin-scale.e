use v6.c;

use GIMP::Raw::Types;
use GTK::Application;
use GIMP::UI::SpinScale;

my $a = GTK::Application.new( title => 'org.genex.gimp.spinscale' );

$a.activate.tap(-> *@a {
  CATCH {
    default { .message.say; .backtrace.concise.say; }
  }

  my $l = GIMP::UI::SpinScale.new;
  $a.window.add($l);
  $a.window.show_all;
});

$a.run;
