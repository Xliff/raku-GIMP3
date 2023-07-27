use v6.c;

use RandomColor;

use BABL;
use GIMP::Raw::Types;
use GTK::Application;
use GIMP::RGB;
use GIMP::UI::Color::Area;

BABL.init;

my $a = GTK::Application.new( title => 'org.genex.gimp.color.selection' );

$a.activate.tap(-> *@a {
  CATCH {
    default { .message.say; .backtrace.concise.say; }
  }

  my $c = RandomColor.new( count => 1, format => 'color' );
  my $l = GIMP::UI::Color::Area.new(
    color => GIMP::RGB.new( |$c.head.rgbd )
  );

  $*SCHEDULER.cue(every => 2, {
    $l.set_color(
      GIMP::RGB.new(
        |RandomColor.new(
          count  => 1,
          hue    => 'purple',
          format => 'color'
        ).head.rgbd
      )
    );
  });

  $a.window.add($l);
  $a.window.show_all;
});

$a.run;
