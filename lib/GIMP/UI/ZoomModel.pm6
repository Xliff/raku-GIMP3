use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::ZoomModel;

use GTK::Button;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GimpZoomModelAncestry is export of Mu
  where GimpZoomModel | GObject;

class GIMP::UI::ZoomModel {
  also does GLib::Roles::Object;

  has GimpZoomModel $!g-zm is implementor;

  submethod BUILD ( :$gimp-zoom-model ) {
    self.setGimpZoomModel($gimp-zoom-model) if $gimp-zoom-model
  }

  method setGimpZoomModel (GimpZoomModelAncestry $_) {
    my $to-parent;

    $!g-zm = do {
      when GimpZoomModel {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpZoomModel, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GIMP::Raw::Definitions::GimpZoomModel
    is also<GimpZoomModel>
  { $!g-zm }

  multi method new (
     $gimp-zoom-model where * ~~ GimpZoomModelAncestry,

    :$ref = True
  ) {
    return unless $gimp-zoom-model;

    my $o = self.bless( :$gimp-zoom-model );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gimp-zoom-model = gimp_zoom_model_new();

    $gimp-zoom-model ?? self.bless( :$gimp-zoom-model ) !! Nil;
  }

  # Type: string
  method fraction is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('fraction', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'fraction does not allow writing'
      }
    );
  }

  # Type: double
  method maximum is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('maximum', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('maximum', $gv);
      }
    );
  }

  # Type: double
  method minimum is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('minimum', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('minimum', $gv);
      }
    );
  }

  # Type: string
  method percentage is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('percentage', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'percentage does not allow writing'
      }
    );
  }

  # Type: double
  method value is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('value', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('value', $gv);
      }
    );
  }

  method zoomed {
    self.connect-numnum($!g-zm, 'zoomed');
  }

  method get_factor is also<get-factor> {
    gimp_zoom_model_get_factor($!g-zm);
  }

  proto method get_fraction (|)
    is also<get-fraction>
  { * }

  multi method get_fraction {
    samewith($, $);
  }
  multi method get_fraction (
     $numerator   is rw,
     $denominator is rw,
    :$rat                = True
  ) {
    my gint ($n, $d) = 0 xx 2;

    gimp_zoom_model_get_fraction($!g-zm, $n, $d);
    ($numerator, $denominator) = ($n, $d);
    return ($n, $d) unless $rat;
    $numerator / $denominator;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_zoom_model_get_type, $n, $t );
  }

  method set_range (Num() $min, Num() $max) is also<set-range> {
    my gdouble ($n, $x) = ($min, $max);

    gimp_zoom_model_set_range($!g-zm, $n, $x);
  }

  method zoom (Int() $zoom_type, Num() $scale) {
    my GimpZoomType  $z = $zoom_type;
    my gdouble       $s = $scale;

    gimp_zoom_model_zoom($!g-zm, $z, $s);
  }

  method zoom_step (Num() $scale, Num() $delta) is also<zoom-step> {
    my gdouble ($s, $d) = ($scale, $delta);

    gimp_zoom_model_zoom_step($!g-zm, $s, $d);
  }

}

class GIMP::Zoom::Button is GTK::Button {

  method new (GimpZoomModel() $model, Int() $zoom_type, Int() $icon_size) {
    my GimpZoomType $z = $zoom_type;
    my GtkIconSize  $i = $icon_size;

    my $gimp-zoom-button = gimp_zoom_button_new($model, $z, $i);

    $gimp-zoom-button ?? self.bless( :$gimp-zoom-button ) !! Nil;
  }

}
