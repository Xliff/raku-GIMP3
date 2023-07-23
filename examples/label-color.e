use v6.c;

use GTK::Application;
use GIMP::RGB;
use GIMP::UI::Label::Color;

my $a = GTK::Application.new( title => 'org.genex.gimp.label.color' );

$a.activate.tap(-> *@a {
  CATCH {
    default { .message.say; .backtrace.concise.say; }
  }

  my $l = GIMP::UI::Label::Color.new( 'Hello!', GIMP::RGB.new( b => 1 ) );

  $a.window.add($l);
  $a.window.show_all;
});

$a.run;
