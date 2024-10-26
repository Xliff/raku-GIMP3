use v6.c;

use RandomColor;

use BABL;
use GIMP::Raw::Types;
use GTK::Application;
use GIMP::RGB;
use GIMP::UI::Color::Notebook;

BABL.init;

my $a = GTK::Application.new( title => 'org.genex.gimp.color.selection' );

$a.activate.tap(-> *@a {
  CATCH {
    default { .message.say; .backtrace.concise.say; }
  }

  my $c = RandomColor.new( count =>1, format => 'color' );
  my $l = GIMP::UI::Color::Notebook.new(
    GIMP::RGB.new( |$c.head.rgbd )
  );

  say "Notebook: { +$l.GimpColorNotebook.p } / Object: { +$l.GObject.p }";

  $a.window.add($l);
  $a.window.show_all;
});

$a.run;
