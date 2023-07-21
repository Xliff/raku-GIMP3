use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::Ruler;

use GTK::Widget;
use GIMP::Unit;

use GLib::Roles::Implementor;

our subset GimpRulerAncestry is export of Mu
  where GimpRuler | GtkWidgetAncestry;

class GIMP::UI::Ruler is GTK::Widget {
  has GimpRuler $!g-r is implementor;

  submethod BUILD ( :$gimp-ruler ) {
    self.setGimpRuler($gimp-ruler) if $gimp-ruler
  }

  method setGimpRuler (GimpRulerAncestry $_) {
    my $to-parent;

    $!g-r = do {
      when GimpRuler {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpRuler, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GIMP::Raw::Structs::GimpRuler
    is also<GimpRuler>
  { $!g-r }

  multi method new (
     $gimp-ruler where * ~~ GimpRulerAncestry,

    :$ref = True
  ) {
    return unless $gimp-ruler;

    my $o = self.bless( :$gimp-ruler );
    $o.ref if $ref;
    $o;
  }
  multi method new ( :horizontal(:hr(:$h)) is required )  {
    self.new(GTK_ORIENTATION_HORIZONTAL);
  }
  multi method new ( :vertical(:vr(:$v)) is required )  {
    self.new(GTK_ORIENTATION_VERTICAL);
  }
  multi method new (Int() $orientation) {
    my GtkOrientation $o = $orientation;

    my $gimp-ruler = gimp_ruler_new($o);

    $gimp-ruler ?? self.bless( :$gimp-ruler ) !! Nil;
  }

  # Type: double
  method lower is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('lower', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('lower', $gv);
      }
    );
  }

  # Type: double
  method max-size is rw  is g-property is also<max_size> {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-size', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('max-size', $gv);
      }
    );
  }

  # Type: GimpOrientation
  method orientation ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new(
      GLib::Value.typeFromEnum(GimpOrientationType)
    );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('orientation', $gv);
        my $o = $gv.enum;
        return $o unless $enum;
        GimpOrientationTypeEnum($o);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GimpOrientationType) = $val;
        self.prop_set('orientation', $gv);
      }
    );
  }

  # Type: double
  method position is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('position', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('position', $gv);
      }
    );
  }

  # Type: double
  method upper is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('upper', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('upper', $gv);
      }
    );
  }

  method add_track_widget (GtkWidget() $widget) is also<add-track-widget> {
    gimp_ruler_add_track_widget($!g-r, $widget);
  }

  method get_position is also<get-position> {
    gimp_ruler_get_position($!g-r);
  }

  proto method get_range (|)
    is also<get-range>
  { * }

  multi method get_range {
    samewith($, $, $);
  }
  multi method get_range (
    $lower    is rw,
    $upper    is rw,
    $max_size is rw
  ) {
    my gdouble ($l, $u, $m) = 0e0 xx 3;

    gimp_ruler_get_range($!g-r, $lower, $upper, $max_size);
    ($lower, $upper, $max_size) = ($l, $u, $m);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_ruler_get_type, $n, $t );
  }

  method get_unit ( :$raw = False ) is also<get-unit> {
    propReturnObject(
      gimp_ruler_get_unit($!g-r),
      $raw,
      |GIMP::Unit.getTypePair
    );
  }

  method remove_track_widget (GtkWidget() $widget) is also<remove-track-widget> {
    gimp_ruler_remove_track_widget($!g-r, $widget);
  }

  method set_position (Num() $position) is also<set-position> {
    my gdouble $p = $position;

    gimp_ruler_set_position($!g-r, $p);
  }

  method set_range (Num() $lower, Num() $upper, Num() $max_size) is also<set-range> {
    my gdouble ($l, $u, $m) = ($lower, $upper, $max_size);

    gimp_ruler_set_range($!g-r, $l, $u, $m);
  }

  method set_unit (GimpUnit() $unit) is also<set-unit> {
    gimp_ruler_set_unit($!g-r, $unit);
  }

}
