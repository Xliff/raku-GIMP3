use v6.c;

use Cairo;
use GDK::Cairo;
use GDK::Pixbuf;
use GTK::Application;
use GTK::Grid;
use GTK::DrawingArea;
use GTK::Statusbar;

use GIMP::Raw::Types;
use GIMP::UI::Ruler;


sub MAIN ($filename) {
  die "Could not find image file at `$filename`!" unless $filename.IO.r;

  constant COORDS = 1;

  my $a = GTK::Application.new( title => 'org.genex.gimp.ruler' );

  $a.activate.tap( -> *@a {
    my $image = GDK::Pixbuf.new-from-file($filename);

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
    my ($x-max, $y-max) = ($hr.upper, $vr.upper) = $image.size;
    $hr.set-size-request($x-max, 20);
    $vr.set-size-request(20, $y-max);

    my $draw-axes;
    $da.draw.tap( -> *@a {
      my $cr = Cairo::Context.new( @a[1] )
        but GDK::Additions::Cairo::Context;
      $cr.set_source_pixbuf($image);
      $cr.paint;
      if $draw-axes {
        my ($x, $y) = ($hr.position.Int, $vr.position.Int);
        $cr.operator = OPERATOR_XOR;
        $cr.rgba(1, 1, 1, 0.35);
        $cr.move_to($x, 0);
        $cr.line_to($x, $y-max);
        $cr.stroke;
        $cr.move_to(0, $y);
        $cr.line_to($x-max, $y);
        $cr.stroke
      }
      @a.tail.r = 1;
    });

    $da.queue-draw;
    $da.set-size-request(640,480);
    $da.add-events(
      [+|](
        GDK_BUTTON_PRESS_MASK,
        GDK_BUTTON_RELEASE_MASK,
        GDK_KEY_PRESS_MASK,
        GDK_POINTER_MOTION_MASK,
        GDK_ENTER_NOTIFY_MASK,
        GDK_LEAVE_NOTIFY_MASK
      )
    );
    $da.button-press-event.tap( -> *@a {
      my $me = cast( GdkEventButton, @a[1] );
      say "Clicked!";
      @a.tail.r = 1;
    });
    $da.enter-notify-event.tap( -> *@a {
      $draw-axes = True;
      @a.tail.r = 1;
    });
    $da.leave-notify-event.tap( -> *@a {
      $draw-axes = False;
      $da.redraw;
      @a.tail.r = 1;
    });
    $da.motion-notify-event.tap( -> *@a {
      my $me = cast( GdkEventMotion, @a[1] );
      ($hr.position, $vr.position) = ($me.x, $me.y);
      $st.pop(COORDS);
      $st.push(COORDS, "({ $me.x.Int }, { $me.y.Int })");
      $da.redraw;
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
}
