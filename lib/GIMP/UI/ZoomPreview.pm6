use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::ZoomPreview;

use GIMP::UI::Preview;

use GLib::Roles::Implementor;

our subset GimpZoomPreviewAncestry is export of Mu
  where GimpZoomPreview | GimpPreviewAncestry;

class GIMP::UI::ZoomPreview is GIMP::UI::Preview {
  has GimpZoomPreview $!g-zp is implementor;

  submethod BUILD ( :$gimp-zoom-preview ) {
    self.setGimpZoomPreview($gimp-zoom-preview)
      if $gimp-zoom-preview
  }

  method setGimpZoomPreview (GimpZoomPreviewAncestry $_) {
    my $to-parent;

    $!g-zp = do {
      when GimpZoomPreview {
        $to-parent = cast(GimpPreview, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpZoomPreview, $_);
      }
    }
    self.setGimpPreview($to-parent);
  }

  method GIMP::Raw::Definitions::GimpZoomPreview
    is also<GimpZoomPreview>
  { $!g-zp }

  multi method new (
     $gimp-zoom-preview where * ~~ GimpZoomPreviewAncestry,

    :$ref = True
  ) {
    return unless $gimp-zoom-preview;

    my $o = self.bless( :$gimp-zoom-preview );
    $o.ref if $ref;
    $o;
  }

  method new_from_drawable (GimpDrawable() $drawable) {
    my $gimp-zoom-preview = gimp_zoom_preview_new_from_drawable($drawable);

    $gimp-zoom-preview ?? self.bless( :$gimp-zoom-preview ) !! Nil;
  }

  method new_with_model_from_drawable (
    GimpDrawable()  $drawable,
    GimpZoomModel() $model
  )
    is also<new-from-drawable>
  {
    my $gimp-zoom-preview = gimp_zoom_preview_new_with_model_from_drawable(
      $drawable,
      $model
    );

    $gimp-zoom-preview ?? self.bless( :$gimp-zoom-preview ) !! Nil;
  }

  # Type: GimpDrawable
  method drawable ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIMP::Drawable.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('drawable', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIMP::Drawable.getTypePair
        );
      },
      STORE => -> $, GimpDrawable() $val is copy {
        $gv.object = $val;
        self.prop_set('drawable', $gv);
      }
    );
  }

  # Type: GimpZoomModel
  method model ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIMP::ZoomModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('model', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIMP::ZoomModel.getTypePair
        );
      },
      STORE => -> $, GimpZoomModel() $val is copy {
        $gv.object = $val;
        self.prop_set('model', $gv);
      }
    );
  }

  method get_drawable ( :$raw = False ) is also<get-drawable> {
    propReturnObject(
      gimp_zoom_preview_get_drawable($!g-zp),
      $raw,
      |GIMP::Drawable.getTypePair
    );
  }

  method get_factor is also<get-factor> {
    gimp_zoom_preview_get_factor($!g-zp);
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gimp_zoom_preview_get_model($!g-zp),
      $raw,
      |GIMP::ZoomModel.getTypePair
    )
  }

  proto method get_source (|)
    is also<get-source>
  { * }

  multi method get_source ( :$carray = False ) {
    samewith($, $, $, :all, :$carray);
  }
  multi method get_source (
     $width   is rw,
     $height  is rw,
     $bpp     is rw,
    :$carray         = False,
    :$all            = False
  ) {
    my gint ($w, $h, $b) = 0 xx 3;

    my $ca = gimp_zoom_preview_get_source($!g-zp, $w, $h, $b);
    ($width, $height, $bpp) = ($w, $h, $b);
    $ca = Buf.new($ca) unless $carray;
    $all.not ?? $ca !! ($ca, $w, $h, $b);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_zoom_preview_get_type, $n, $t );
  }

}
