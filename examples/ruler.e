use v6.c;

use Cairo;
use GTK::Application;
use GTK::Grid;
use GTK::DrawingArea;
use GTK::Statusbar;

use GIMP::Raw::Types;
use GIMP::UI::Ruler;

constant COORDS = 1;

my $a = GTK::Application.new( title => 'org.genex.gimp.ruler' );

$a.activate.tap( -> *@a {
  my $grid  = GTK::Grid.new;
  my $da    = GTK::DrawingArea.new;
  my $hr    = GIMP::UI::Ruler.new( :hr );
  my $vr    = GIMP::UI::Ruler.new( :vr );
  my $st    = GTK::Statusbar.new;

  for ($hr, $vr, $hr).rotor( 2 => -1 ) {
    .head.add-track-widget($da);
    .head.add-track-widget( .tail );
    .head.lower = 0;
  }
  # cw: Too many literals for comfort!
  ($hr.upper, $vr.upper) = (640, 480);
  $hr.set-size-request(640, 20);
  $vr.set-size-request(20, 480);

  $da.draw.tap( -> *@a {
    my $cr = Cairo::Context.new( @a[1] );
    $cr.rgb(1, 1, 1);
    $cr.paint;
    @a.tail.r = 1;
  });

  $da.queue-draw;
  $da.set-size-request(640,480);
  $da.add-events(GDK_BUTTON_PRESS_MASK +| GDK_POINTER_MOTION_MASK);
  $da.button-press-event.tap( -> *@a {
    my $me = cast( GdkEventButton, @a[1] );
    say "Clicked!";
    @a.tail.r = 1;
  });
  $da.motion-notify-event.tap( -> *@a {
    my $me = cast( GdkEventMotion, @a[1] );
    ($hr.position, $vr.position) = ($me.x, $me.y);
    $st.pop(COORDS);
    $st.push(COORDS, "({ $me.x.Int }, { $me.y.Int })");
    @a.tail.r = 1;
  });

  $grid.attach($hr, 1, 0);
  $grid.attach($vr, 0, 1);
  $grid.attach($da, 1, 1);
  $grid.attach($st, 1, 2);

  $a.window.add($grid);
  $a.window.show-all;
});

$a.run;
