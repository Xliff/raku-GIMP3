use v6.c;

use GIMP::Raw::Types;

use GTK::Application;
use GIMP::RGB;
use GIMP::UI::Color::HexEntry;

my $a = GTK::Application.new( title => 'org.genex.gimp.color.hexentry' );

$a.activate.tap(-> *@a {
  CATCH {
    default { .message.say; .backtrace.concise.say; }
  }

  my $c = GIMP::UI::Color::HexEntry.new;

  $a.window.add($c);
  $a.window.show_all;
});

$a.run;
