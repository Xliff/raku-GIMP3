use v6.c;

use Method::Also;
use NativeCall;

use GIMP::Raw::Types;
use GIMP::Raw::UI::Unit::Store;

use GLib::Roles::Object;
use GLib::Roles::Implementor;

our subset GimpUnitStoreAncestry is export of Mu
  where GimpUnitStore | GObject;

class GIMP::UI::Unit::Store {
  also does GLib::Roles::Object;

  has GimpUnitStore $!gus is implementor;

  submethod BUILD ( :$gimp-unit-store ) {
    self.setGimpUnitStore($gimp-unit-store) if $gimp-unit-store;
  }

  method setGimpUnitStore (GimpUnitStoreAncestry $_) {
    my $to-parent;

    $!gus = do {
      when GimpUnitStore {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpUnitStore, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GIMP::Raw::Definitions::GimpUnitStore
    is also<GimpUnitStore>
  { $!gus }

  multi method new (
     $gimp-unit-store where * ~~ GimpUnitStoreAncestry,

    :$ref = True
  ) {
    return unless $gimp-unit-store;

    my $o = self.bless( :$gimp-unit-store );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $num-values = 1) {
    my gint $n = $num-values;

    my $gimp-unit-store = gimp_unit_store_new($num-values);

    $gimp-unit-store ?? self.bless( :$gimp-unit-store ) !! Nil;
  }

  # Type: boolean
  method has-percent is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-percent', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-percent', $gv);
      }
    );
  }

  # Type: boolean
  method has-pixels is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-pixels', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-pixels', $gv);
      }
    );
  }

  # Type: string
  method long-format is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('long-format', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('long-format', $gv);
      }
    );
  }

  # Type: int
  method num-values is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('num-values', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('num-values', $gv);
      }
    );
  }

  # Type: string
  method short-format is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('short-format', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('short-format', $gv);
      }
    );
  }

  method get_has_percent is also<get-has-percent> {
    so gimp_unit_store_get_has_percent($!gus);
  }

  method get_has_pixels is also<get-has-pixels> {
    so gimp_unit_store_get_has_pixels($!gus);
  }

  method get_values (:$unit) is also<get-values> {
    do for ^self.num-values {
      self.get_nth_value($unit, $_);
    }
  }

  method Array {
    self.get_values.Array;
  }

  method get_nth_value (Int() $unit, Int() $index) is also<get-nth-value> {
    my GimpUnit $u = $unit;
    my gint     $i = $index;

    gimp_unit_store_get_nth_value($!gus, $u, $i);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_unit_store_get_type, $n, $t );
  }

  method set_has_percent (Int() $has_percent) is also<set-has-percent> {
    my gboolean $h = $has_percent.so.Int;

    gimp_unit_store_set_has_percent($!gus, $h);
  }

  method set_has_pixels (Int() $has_pixels) is also<set-has-pixels> {
    my gboolean $h = $has_pixels.so.Int;

    gimp_unit_store_set_has_pixels($!gus, $h);
  }

  method set_pixel_value (Int() $index, Num() $value)
    is also<set-pixel-value>
  {
    my gint    $i = $index;
    my gdouble $v = $value;

    gimp_unit_store_set_pixel_value($!gus, $i, $v);
  }

  proto method set_pixel_values (|)
    is also<set-pixel-values>
  { * }

  multi method set_pixel_values (*@v) {
    samewith(@v);
  }
  multi method set_pixel_values (CArray[num64] $v) {
    samewith( $v[^self.num-values].Array );
  }
  multi method set_pixel_values (@v) {
    $*ERR.say: "Can't set more than { self.num-values } pixel values!"
      if @v.elems > self.num-values;

    for @v.kv -> $k, $v {
      self.set_pixel_value($k, $v);
    }
  }

  method set_resolution (Int() $index, Num() $resolution)
    is also<set-resolution>
  {
    my gint    $i = $index;
    my gdouble $r = $resolution;

    gimp_unit_store_set_resolution($!gus, $i, $r);
  }

  proto method set_resolutions (|)
    is also<set-resolutions>
  { * }

  multi method set_resolutions (*@v) {
    samewith(@v);
  }
  multi method set_resolutions (CArray[num64] $v) {
    samewith( $v[^self.num-values].Array );
  }
  multi method set_resolutions (@v) {
    $*ERR.say: "Can't set more than { self.num-values } resolutions!"
      if @v.elems > self.num-values;

    for @v.kv -> $k, $v {
      self.set_resolution($k, $v);
    }
  }

}
