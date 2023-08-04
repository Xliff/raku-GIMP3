use v6.c;

use GIMP::Raw::Types;

use RandomColor;
use Cairo;
use GDK::Cairo;
use GDK::KeySyms;
use GDK::Pixbuf;
use GDK::Rectangle;
use GTK::Application;
use GTK::FlowBox;
use GTK::Grid;
use GTK::Image;
use GTK::Statusbar;
use GIMP::Image;
use GIMP::Layer;
use GIMP::UI::Button;
use GIMP::UI::Ruler;
use GIMP::UI::ZoomPreview;

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

my ($rollNum, $pixbuf, $image, $layer, @new-pixbufs, @new-images, $fb) = (1);

sub saveRegion {
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
    $fb.pack_start( @new-images.tail );
  }
}

sub MAIN ($filename) {
  die "Could not find image file at `$filename`!" unless $filename.IO.r;

  my $a = GTK::Application.new( title => 'org.genex.cutouts' );

  $a.activate.tap( -> *@a {
    $pixbuf = GDK::Pixbuf.new-from-file($filename);
    $layer  = GIMP::Layer.new-from-pixbuf($pixbuf);

    my $grid  = GTK::Grid.new;
    my $da    = GIMP::UI::ZoomPreview.new($layer);
    my $hr    = GIMP::UI::Ruler.new( :hr );
    my $vr    = GIMP::UI::Ruler.new( :vr );
    my $bb    = GTK::Box.new-hbox(10);
    my $st    = GTK::Statusbar.new;
    my $pb    = GIMP::Button.new-with-label('Submit');

    # Initialize the film row (as a FlowBox)
    $fb    = GTK::FlowBox.new-vbox;

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

    $pb.clicked.tap( -> *@a {
      saveRegion;
    });

    $bb.pack_start($pb);
    $bb.pack_end($st, True, True);

    $grid.attach($hr, 1, 0);
    $grid.attach($vr, 0, 1);
    $grid.attach($da, 1, 1);
    $grid.attach($fb, 2, 1);
    $grid.attach($bb, 1, 2);

    $a.window.key-press-event.tap( -> *@a ($, $e, $) {
      my $event = cast(GdkEventKey, $e);

      given $event.keyval {

        # Read keys
        #   - Left: Move box left
        #     - With SHIFT shrink box width
        #   - Right: Move box right
        #     - With SHIFT increase box width
        #   - Up: Move box up
        #     - With SHIFT shrink box height
        #   - Down: Move box down
        #     - With SHIFT increase box height
        #   - Home: Move to x = 0
        #   - End: Move to x = <image width>
        #   - Return: Copy rectangle under box and save to next serial image name
        #   - ESC: End program
        when GDK_KEY_w | GDK_KEY_Left   { --$x }
        when GDK_KEY_a | GDK_KEY_Up     { --$y }
        when GDK_KEY_d | GDK_KEY_Right  { ++$x }
        when GDK_KEY_s | GDK_KEY_Down   { ++$y }

        when GDK_KEY_W                  { --$w }
        when GDK_KEY_A                  { --$h }
        when GDK_KEY_D                  { ++$w }
        when GDK_KEY_S                  { ++$h }

        when $event.state +& GDK_SHIFT_MASK {
          when GDK_KEY_Left  { --$w }
          when GDK_KEY_Up    { --$h }
          when GDK_KEY_Right { ++$w }
          when GDK_KEY_Down  { ++$h }
        }

        when GTK_KEY_Enter { saveRegion }

        when GDK_KEY_Home  { $x = 0 }
        when GDK_KEY_Left  { --$x   }
        when GDK_KEY_Up    { --$y   }
        when GDK_KEY_Right { ++$x   }
        when GDK_KEY_Down  { ++$y   }
        when GDK_KEY_End   { $x = E }
      }
    });

    $a.window.add($grid);
    $a.window.show-all;
  });

  $a.run;
}
