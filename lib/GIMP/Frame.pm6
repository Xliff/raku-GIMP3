use v6.c;

use Method::Also;

use NativeCall;

use GIMP::Raw::Types;

use GTK::Frame;

use GLib::Roles::Implementor;

our subset GimpFrameAncestry is export of Mu
  where GimpFrame | GtkFrameAncestry;

class GIMP::Frame is GTK::Frame {
  has GimpFrame $!g-f is implementor;

  submethod BUILD ( :$gimp-frame ) {
    self.setGimpFrame($gimp-frame) if $gimp-frame
  }

  method setGimpFrame (GimpFrameAncestry $_) {
    my $to-parent;

    $!g-f = do {
      when GimpFrame {
        $to-parent = cast(GtkFrame, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpFrame, $_);
      }
    }
    self.setGtkFrame($to-parent);
  }

  method GIMP::Raw::Definitions::GimpFrame
    is also<GtkFrame>
  { $!g-f }

  multi method new (
     $gimp-frame where * ~~ GimpFrameAncestry,

    :$ref = True
  ) {
    return unless $gimp-frame;

    my $o = self.bless( :$gimp-frame );
    $o.ref if $ref;
    $o;
  }

  multi method new (Str() $label) {
    my $gimp-frame = gimp_frame_new($label);

    $gimp-frame ?? self.bless( :$gimp-frame ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_frame_get_type, $n, $t );
  }

}


### /usr/src/gimp/libgimpwidgets/gimpframe.h

sub gimp_frame_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_frame_new (Str $label)
  returns GimpFrame
  is      native(gimpwidgets)
  is      export
{ * }
