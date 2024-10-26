use v6.c;

use RandomColor;

use BABL;
use GIMP::Raw::Types;
use GTK::Application;
use GTK::Box;
use GIMP::RGB;
use GIMP::UI::Color::Area;
use GIMP::UI::Color::HexEntry;

BABL.init;

my $a = GTK::Application.new(
  title => 'org.genex.gimp.color.selection'
);

$a.activate.tap(-> *@a {
  CATCH {
    default { .message.say; .backtrace.concise.say; }
  }

  my $b   = GTK::Box.new-hbox(10);
  my $rc  = RandomColor.new( count => 1, format => 'color' );
  my $c   = $rc.head;
  my $ca  = GIMP::UI::Color::Area.new;
  $ca.set-color( GIMP::RGB.new( |$c.rgbd ) );
  say $ca.get-color;
  my $he  = GIMP::UI::Color::HexEntry.new(
    text => $c.to-string('hex').substr(1)
  );
  $b.pack-start($_, True, True) for $ca, $he;

  $he.Color-Changed.tap: SUB {
    $ca.color = GIMP::RGB.new.parse-hex($he.text)
  }

  $a.window.add($b);
  $a.window.show_all;
});

$a.run;
