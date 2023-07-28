use v6.c;

use RandomColor;

use GIMP::Raw::Types;
use GTK::Application;
use GIMP::UI::NumberPairEntry;

my $a = GTK::Application.new( title => 'org.genex.gimp.color.selection' );

$a.activate.tap(-> *@a {
  CATCH {
    default { .message.say; .backtrace.concise.say; }
  }

  my $c = RandomColor.new( count =>1, format => 'color' );
  my $l = GIMP::UI::NumberPairEntry.new(
    left-number  => 640,
    right-number => 480
  );

  $a.window.add($l);
  $a.window.show_all;
});

$a.run;
