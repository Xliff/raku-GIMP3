use v6.c;

use RandomColor;
use Cairo;
use GDK::Cairo;
use GTK::Application;
use GTK::DrawingArea;
use GTK::FlowBox;
use GTK::Grid;
use GDK::Pixbuf;
use GDK::Rectangle;
use GTK::Statusbar;

use GIMP::Raw::Types;

use GDK::KeySyms;
use GIMP::UI::Button;
use GIMP::UI::Ruler;

constant COORDS      = 1;
constant COLOR_BATCH = 20;
constant DRAW_WIDTH  = 4;

class ColoredRectangle {
  has $.c;
  has $.r;

  method draw ($c) {
    $c.line_width = DRAW_WIDTH;
    $c.rgba( |self.c.rgbad );
    $c.move_to(self.r.x               , self.r.y);
    $c.line_to(self.r.x + self.r.width, self.r.y);
    $c.line_to(self.r.x + self.r.width, self.r.y + self.r.height);
    $c.line_to(self.r.x               , self.r.y + self.r.height);
    $c.line_to(self.r.x               , self.r.y);
    $c.stroke;
  }
}

sub MAIN ($filename) {
  die "Could not find image file at `$filename`!" unless $filename.IO.r;

  my $a = GTK::Application.new( title => 'org.genex.gimp.ruler' );

  $a.activate.tap( -> *@a {
    my $image = GDK::Pixbuf.new-from-file($filename);

    my $grid  = GTK::Grid.new;
    my $da    = GTK::DrawingArea.new;
    my $hr    = GIMP::UI::Ruler.new( :hr );
    my $vr    = GIMP::UI::Ruler.new( :vr );
    my $bb    = GTK::Box.new-hbox(10);
    my $st    = GTK::Statusbar.new;
    my $pb    = GIMP::Button.new-with-label('Submit');
    my $fb    = GTK::FlowBox.new-vbox;

    for ($hr, $vr, $hr).rotor( 2 => -1 ) {
      .head.add-track-widget($da);
      .head.add-track-widget( .tail );
      .head.lower = 0;
    }
    my ($x-max, $y-max) = ($hr.upper, $vr.upper) = $image.size;
    $hr.set-size-request($x-max, 20);
    $vr.set-size-request(20, $y-max);

    my ($draw-axes, $button-down, @new-colors, @rectangles);
    $da.draw.tap( -> *@a {
      my $cr = Cairo::Context.new( @a[1] ) but GdkCairoContextAdditions;
      $cr.operator = OPERATOR_SOURCE;
      $cr.set_source_pixbuf($image);
      $cr.paint;
      .draw($cr) for @rectangles;
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
        GDK_POINTER_MOTION_MASK,
        GDK_ENTER_NOTIFY_MASK,
        GDK_LEAVE_NOTIFY_MASK
      )
    );
    $a.window.add-events( GDK_KEY_PRESS_MASK );

    $a.window.key-press-event.tap( -> *@a {
      my $e = cast( GdkEventKey, @a[1] );

      given $e.key-enum {
        when GDK_KEY_BackSpace { @rectangles.pop if +@rectangles; $da.redraw }
      }
      @a.tail.r = 1;
    });

    $da.button-press-event.tap( -> *@a {;
      my $me = cast( GdkEventButton, @a[1] );
      @new-colors = |RandomColor.new(
        count  => COLOR_BATCH,
        format => 'color'
      ) unless @new-colors;
      @rectangles.push: ColoredRectangle.new(
        c => @new-colors.pop,
        r => GdkRectangle.new(
          x => $hr.position.Int,
          y => $vr.position.Int
        )
      );
      @rectangles.gist.say;
      $button-down = True;
      @a.tail.r = 1;
    });

    $da.button-release-event.tap( -> *@a {
      $button-down = False;
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
      if $button-down {
        ( .r.width, .r.height ) = (
          ($me.x - .r.x).Int,
          ($me.y - .r.y).Int
        ) given @rectangles.tail
      }
      $st.pop(COORDS);
      $st.push(COORDS, "({ $me.x.Int }, { $me.y.Int })");
      $da.redraw;
      @a.tail.r = 1;
    });

    my (@new-pixbufs, @new-images);
    my  $rollNum = 1;
    $pb.clicked.tap( -> *@a {
      while $_ =  @rectangles.pop {
        @new-pixbufs.push: $image.subpixbuf( |$_ );

        # Save last pixbuf
        @new-pixbufs.tail.save(
          $*HOME.add('Pictures').add(
            'CR.' ~ DateTime.now.yyyy-mm-dd('') ~ ".{ $rollNum++ }.png"
          ).absolute,
          'png'
        );

        @new-images.push: GTK::Image.new( @new-pixbufs.tail );
        $fb.pack_start(@new-images.tail);
      }
    });

    $bb.pack_start($pb);
    $bb.pack_end($st, True, True);

    $grid.attach($hr, 1, 0);
    $grid.attach($vr, 0, 1);
    $grid.attach($da, 1, 1);
    $grid.attach($fb, 2, 1);
    $grid.attach($bb, 1, 2);

    $a.window.add($grid);
    $a.window.show-all;
  });

  $a.run;
}
