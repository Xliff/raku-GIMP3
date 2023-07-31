use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::PreviewArea;

use GTK::DrawingArea;

our subset GimpPreviewAreaAncestry is export of Mu
  where GimpPreviewArea | GtkDrawingAreaAncestry;

class GIMP::PreviewArea is GTK::DrawingArea {
  has GimpPreviewArea $!g-pa is implementor;

  submethod BUILD ( :$gimp-preview-area ) {
    self.setGimpPreviewArea($gimp-preview-area) if $gimp-preview-area
  }

  method setGimpPreviewArea (GimpPreviewAreaAncestry $_) {
    my $to-parent;

    $!g-pa = do {
      when GimpPreviewArea {
        $to-parent = cast(GtkDrawingArea, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpPreviewArea, $_);
      }
    }
    self.setGtkDrawingArea($to-parent);
  }

  method GIMP::Raw::Definitions::GimpPreviewArea
    is also<GimpPreviewArea>
  { $!g-pa }

  multi method new (
     $gimp-preview-area where * ~~ GimpPreviewAreaAncestry,

    :$ref = True
  ) {
    return unless $gimp-preview-area;

    my $o = self.bless( :$gimp-preview-area );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gimp-preview-area = gimp_preview_area_new();

    $gimp-preview-area ?? self.bless( :$gimp-preview-area ) !! Nil;
  }

  method !bppForType ($_) {
    do {
      when GIMP_RGB_IMAGE      { 3 }
      when GIMP_RGBA_IMAGE     { 4 }
      when GIMP_GRAY_IMAGE     { 1 }
      when GIMP_GRAYA_IMAGE    { 2 }
      when GIMP_INDEXED_IMAGE  { 1 }
      when GIMP_INDEXEDA_IMAGE { 2 }

      default {
        X::GLib::UnknownType.new(
          message => "Unknown image type ({ $_ })!"
        ).throw
      }
    }
  }

  # Type: GimpRgb
  method check-custom-color1 ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIMP::RGB.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('check-custom-color1', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIMP::RGB.getTypePair
        );
      },
      STORE => -> $, GimpRGB() $val is copy {
        $gv.object = $val;
        self.prop_set('check-custom-color1', $gv);
      }
    );
  }

  # Type: GimpRgb
  method check-custom-color2 ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIMP::RGB.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('check-custom-color2', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIMP::RGB.getTypePair
        );
      },
      STORE => -> $, GimpRGB() $val is copy {
        $gv.object = $val;
        self.prop_set('check-custom-color1', $gv);
      }
    );
  }

  # Type: GimpCheckSize
  method check-size ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GimpCheckSize) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('check-size', $gv);
        my $s = $gv.enum;
        return $s unless $enum;
        GimpCheckSizeEnum($s);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GimpCheckSize) = $val;
        self.prop_set('check-size', $gv);
      }
    );
  }

  # Type: GimpCheckType
  method check-type ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GimpCheckType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('check-type', $gv);
        my $t = $gv.GimpCheckType;
        return $t unless $enum;
        GimpCheckTypeEnum($t);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GimpCheckType) = $val;
        self.prop_set('check-type', $gv);
      }
    );
  }

  multi method blend (
    Int()  $x,
    Int()  $y,
    Int()  $width,
    Int()  $height,
    Int()  $type,
           $buf1,
           $buf2,
    Int() :$opacity    = 255,
    Int() :$rowstride1 = $width * self!bppForType($type),
    Int() :$rowstride2 = $width * self!bppForType($type),
  ) {
    samewith(
      $x,
      $y,
      $width,
      $height,
      $type,
      resolveBuffer($buf1),
      $rowstride1,
      resolveBuffer($buf2),
      $rowstride2,
      $opacity
    );
  }
  multi method blend (
    Int()         $x,
    Int()         $y,
    Int()         $width,
    Int()         $height,
    Int()         $type,
    CArray[uint8] $buf1,
    Int()         $rowstride1,
    CArray[uint8] $buf2,
    Int()         $rowstride2,
    Int()         $opacity
  ) {
    my gint ($xx, $yy, $w, $h, $r1, $r2) =
      ($x, $y, $width, $height, $rowstride1, $rowstride2);

    my GimpImageType $t = $type;
    my uint8         $o = $opacity;

    gimp_preview_area_blend(
      $!g-pa,
      $xx,
      $yy,
      $w,
      $h,
      $t,
      $buf1,
      $r1,
      $buf2,
      $r2,
      $o
    );
  }

  multi method draw (
    Int()  $x,
    Int()  $y,
    Int()  $width,
    Int()  $height,
    Int()  $type,
           $buf,
    Int() :$rowstride = $width * self!bppForType($type)
  ) {
    samewith(
      $x,
      $y,
      $width,
      $height,
      $type,
      resolveBuffer($buf),
      $rowstride
    );
  }
  multi method draw (
    Int()         $x,
    Int()         $y,
    Int()         $width,
    Int()         $height,
    Int()         $type,
    CArray[uint8] $buf,
    Int()         $rowstride
  ) {
    my gint ($xx, $yy, $w, $h, $r) = ($x, $y, $width, $height, $rowstride);

    my GimpImageType $t = $type;

    gimp_preview_area_draw($!g-pa, $xx, $yy, $w, $h, $t, $buf, $r);
  }

  method fill (
    Int() $x,
    Int() $y,
    Int() $width,
    Int() $height,
    Int() $red,
    Int() $green,
    Int() $blue
  ) {
    my gint  ($xx, $yy, $w, $h) = ($x, $y, $width, $height);
    my uint8 ($r, $g, $b)       = ($red, $green, $blue);

    gimp_preview_area_fill($!g-pa, $xx, $yy, $w, $h, $r, $g, $b);
  }

  proto method get_size (|)
    is also<get-size>
  { * }

  multi method get_size {
    samewith($, $);
  }
  multi method get_size ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    gimp_preview_area_get_size($!g-pa, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_preview_area_get_type, $n, $t );
  }

  proto method mask (|)
  { * }

  multi method mask (
    Int()  $x,
    Int()  $y,
    Int()  $width,
    Int()  $height,
    Int()  $type,
           $buf1,
           $buf2,
           $mask,
    Int() :$rowstride1                      = $width * self!bppForType($type),
    Int() :$rowstride2                      = $width * self!bppForType($type),
    Int() :rowstride-mask(:$rowstride_mask) = $width * self!bppForType($type)
  ) {
    samewith(
      $x,
      $y,
      $width,
      $height,
      $type,
      resolveBuffer($buf1),
      $rowstride1,
      resolveBuffer($buf2),
      $rowstride2,
      resolveBuffer($mask),
      $rowstride_mask
    );
  }
  multi method mask (
    Int()           $x,
    Int()           $y,
    Int()           $width,
    Int()           $height,
    Int()           $type,
    CArray[uint8]   $buf1,
    Int()           $rowstride1,
    CArray[uint8]   $buf2,
    Int()           $rowstride2,
    CArray[uint8]   $mask,
    Int()           $rowstride_mask
  ) {
    my gint ($xx, $yy, $w, $h, $r1, $r2, $rm) =
      ($x, $y, $width, $height, $rowstride1, $rowstride2, $rowstride_mask);

    my GimpImageType $t = $type;
    gimp_preview_area_mask(
      $!g-pa,
      $xx,
      $yy,
      $w,
      $h,
      $t,
      $buf1,
      $r1,
      $buf2,
      $r2,
      $mask,
      $rm
    );
  }

  method menu_popup (GdkEventButton() $event) is also<menu-popup> {
    gimp_preview_area_menu_popup($!g-pa, $event);
  }

  method set_color_config (GimpColorConfig() $config) is also<set-color-config> {
    gimp_preview_area_set_color_config($!g-pa, $config);
  }

  proto method set_colormap (|)
    is also<set-colormap>
  { * }

  multi method set_colormap ($colormap) {
    my $rb = resolveBuffer($colormap);

    samewith($rb, $rb.elems);
  }
  multi method set_colormap (
    CArray[uint8] $colormap,
    Int()         $num_colors
  ) {
    my gint $n = $num_colors;

    gimp_preview_area_set_colormap($!g-pa, $colormap, $n);
  }

  method set_max_size (Int() $width, Int() $height) is also<set-max-size> {
    my gint ($w, $h) = ($width, $height);

    gimp_preview_area_set_max_size($!g-pa, $w, $h);
  }

  method set_offsets (Int() $x, Int() $y) is also<set-offsets> {
    my gint ($xx, $yy);

    gimp_preview_area_set_offsets($!g-pa, $xx, $yy);
  }

}
