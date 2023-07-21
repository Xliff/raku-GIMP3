use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::Drawable;

use GLib::Bytes;
use BABL;
use GEGL::Buffer;
use GDK::Pixbuf;
use GIMP::Item;

our subset GimpDrawableAncestry is export of Mu
  where GimpDrawable | GimpItemAncestry;

class GIMP::Drawable is GIMP::Item {
  has GimpDrawable $!g-d is implementor;

  submethod BUILD ( :$gimp-drawable ) {
    self.setGimpDrawable($gimp-drawable) if $gimp-drawable
  }

  method setGimpDrawable (GimpDrawableAncestry $_) {
    my $to-parent;

    $!g-d = do {
      when GimpDrawable {
        $to-parent = cast(GimpItem, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpDrawable, $_);
      }
    }
    self.setGimpItem($to-parent);
  }

  method GIMP::Raw::Definitions::GimpDrawable
    is also<GimpDrawable>
  { $!g-d }

  multi method new (
     $gimp-drawable where * ~~ GimpDrawableAncestry,

    :$ref = True
  ) {
    return unless $gimp-drawable;

    my $o = self.bless( :$gimp-drawable );
    $o.ref if $ref;
    $o;
  }

  method brightness_contrast (Num() $brightness, Num() $contrast)
    is also<brightness-contrast>
  {
    my gdouble ($b, $c) = ($brightness, $contrast);

    gimp_drawable_brightness_contrast($!g-d, $b, $c);
  }

  method color_balance (
    Int() $transfer_mode,
    Int() $preserve_lum,
    Num() $cyan_red,
    Num() $magenta_green,
    Num() $yellow_blue
  )
    is also<color-balance>
  {
    my GimpTransferMode $t = $transfer_mode;
    my gboolean         $p = $preserve_lum.so.Int;

    my gdouble ($c, $m, $y) = ($cyan_red, $magenta_green, $yellow_blue);

    so gimp_drawable_color_balance($!g-d, $t, $p, $c, $m, $y);
  }

  method colorize_hsl (Num() $hue, Num() $saturation, Num() $lightness)
    is also<colorize-hsl>
  {
    my gdouble ($h, $s, $l) = ($hue, $saturation, $lightness);

    gimp_drawable_colorize_hsl($!g-d, $h, $s, $l);
  }

  proto method curves_explicit (|)
    is also<curves-explicit>
  { * }

  multi method curves_explicit (
    Int()  $channel,
           @values,
    Int() :num(:num-values(:$num_values)) = @values.elems
  ) {
    samewith( $channel, $num_values, ArrayToCArray(gdouble, @values) );
  }
  multi method curves_explicit (
    Int()           $channel,
    Int()           $num_values,
    CArray[gdouble] $values
  ) {
    my GimpHistogramChannel $c = $channel;
    my gint                 $n = $num_values;

    so gimp_drawable_curves_explicit($!g-d, $c, $n, $values);
  }

  proto method curves_spline (|)
    is also<curves-spline>
  { * }

  multi method curves_spline (
    Int()  $channel,
           @points,
    Int() :num(:num-points(:$num_points)) = @points.elems
  ) {
    samewith( $channel, $num_points, ArrayToCArray(gdouble, @points) );
  }
  multi method curves_spline (
    Int()           $channel,
    Int()           $num_points,
    CArray[gdouble] $points
  ) {
    my GimpHistogramChannel $c = $channel;
    my gint                 $n = $num_points;

    gimp_drawable_curves_spline($!g-d, $c, $n, $points);
  }

  method desaturate (Int() $desaturate_mode) {
    my GimpDesaturateMode $d = $desaturate_mode;

    so gimp_drawable_desaturate($!g-d, $d);
  }

  method edit_bucket_fill (Int() $fill_type, Num() $x, Num() $y)
    is also<edit-bucket-fill>
  {
    my GimpFillType  $f        =  $fill_type;
    my gdouble      ($xx, $yy) = ($x, $y);

    so gimp_drawable_edit_bucket_fill($!g-d, $f, $xx, $yy);
  }

  method edit_clear is also<edit-clear> {
    gimp_drawable_edit_clear($!g-d);
  }

  method edit_fill (Int() $fill_type) is also<edit-fill> {
    my GimpFillType  $f =  $fill_type;

    gimp_drawable_edit_fill($!g-d, $f);
  }

  # cw: If someone can suggest salient defaults, we can eliminate more of these
  #     as a QoL improvement.
  method edit_gradient_fill (
    Int() $gradient_type,
    Num() $offset,
    Int() $supersample,
    Int() $supersample_max_depth,
    Num() $supersample_threshold,
    Int() $dither,
    Num() $x1,
    Num() $y1,
    Num() $x2,
    Num() $y2
  )
    is also<edit-gradient-fill>
  {
    my GimpGradientType  $g      =  $gradient_type;
    my gboolean         ($s, $d) = ($supersample, $dither).map( *.so.Int );
    my gint              $max    =  $supersample_max_depth;

    my gdouble ($o, $xx1, $yy1, $xx2, $yy2) = ($offset, $x1, $y1, $x2, $y2);
    my gdouble  $t                          =  $supersample_threshold;

    so gimp_drawable_edit_gradient_fill(
      $!g-d,
      $g,
      $o,
      $s,
      $max,
      $t,
      $d,
      $xx1,
      $yy1,
      $xx2,
      $yy2
    );
  }

  method edit_stroke_item (GimpItem() $item) is also<edit-stroke-item> {
    so gimp_drawable_edit_stroke_item($!g-d, $item);
  }

  method edit_stroke_selection is also<edit-stroke-selection> {
    so gimp_drawable_edit_stroke_selection($!g-d);
  }

  method equalize (Int() $mask_only) {
    my gboolean $m = $mask_only.so.Int;

    so gimp_drawable_equalize($!g-d, $m);
  }

  # cw:
  #| Component breakdown:
  #|   RGB Red (0),
  #|   RGB Green (1),
  #|   RGB Blue (2),
  #|   Hue (3),
  #|   HSV Saturation (4),
  #|   HSV Value (5),
  #|   HSL Saturation (6),
  #|   HSL Lightness (7),
  #|   CMYK Cyan (8),
  #|   CMYK Magenta (9),
  #|   CMYK Yellow (10),
  #|   CMYK Key (11),
  #|   Y'CbCr Y' (12),
  #|   Y'CbCr Cb (13),
  #|   Y'CbCr Cr (14),
  #|   LAB L (15),
  #|   LAB A (16),
  #|   LAB B (17),
  #|   LCH C(ab) (18),
  #|   LCH H(ab) (19),
  #|   Alpha (20)
  method extract_component (Int() $component, Int() $invert, Int() $linear)
    is also<extract-component>
  {
    my gint      $c      =  $component;
    my gboolean ($i, $l) = ($invert, $linear).map( *.so.Int );

    gimp_drawable_extract_component($!g-d, $c, $i, $l);
  }

  method fill (Int() $fill_type) {
    my GimpFillType $f = $fill_type;

    so gimp_drawable_fill($!g-d, $f);
  }

  method foreground_extract (
    Int()          $mode,
    GimpDrawable() $mask
  )
    is also<foreground-extract>
  {
    my GimpForegroundExtractMode $m = $mode;

    gimp_drawable_foreground_extract($!g-d, $m, $mask);
  }

  method free_shadow is also<free-shadow> {
    gimp_drawable_free_shadow($!g-d);
  }

  method get_bpp is also<get-bpp> {
    gimp_drawable_get_bpp($!g-d);
  }

  method get_buffer ( :$raw = False ) is also<get-buffer> {
    propReturnObject(
      gimp_drawable_get_buffer($!g-d),
      $raw,
      |GEGL::Buffer.getTypePair
    );
  }

  method get_by_id (Int() $id, :$raw = False) is static is also<get-by-id> {
    my gint $i = $id;

    propReturnObject(
      gimp_drawable_get_by_id($id),
      $raw,
      |self.getTypePair
    );
  }

  method get_format ( :$raw = False ) is also<get-format> {
    propReturnObject(
      gimp_drawable_get_format($!g-d),
      $raw,
      |Babl.getTypePair
    );
  }

  method get_height is also<get-height> {
    gimp_drawable_get_height($!g-d);
  }

  proto method get_offsets (|)
    is also<get-offsets>
  { * }

  multi method get_offsets {
    samewith($, $);
  }
  multi method get_offsets ($offset_x is rw, $offset_y is rw) {
    my gint ($x, $y) = 0 xx 2;

    my $rv = gimp_drawable_get_offsets($!g-d, $x, $y);
    return Nil unless $rv;
    ($offset_x, $offset_y) = ($x, $y);
  }

  method get_shadow_buffer ( :$raw = False ) is also<get-shadow-buffer> {
    propReturnObject(
      gimp_drawable_get_shadow_buffer($!g-d),
      $raw,
      |GEGL::Buffer.getTypePair
    );
  }

  method get_sub_thumbnail (
    Int()  $src_x,
    Int()  $src_y,
    Int()  $src_width,
    Int()  $src_height,
    Int()  $dest_width,
    Int()  $dest_height,
    Int()  $alpha,
          :$raw          = False
  )
    is also<get-sub-thumbnail>
  {
    my GimpPixbufTransparency $a = $alpha;

    my gint ($x, $y, $w, $h, $dw, $dh) =
      ($src_x, $src_y, $src_width, $src_height, $dest_width, $dest_height);

    propReturnObject(
      gimp_drawable_get_sub_thumbnail($!g-d, $x, $y, $w, $h, $dw, $dh, $a),
      $raw,
      |GDK::Pixbuf.getTypePair
    );
  }

  proto method get_sub_thumbnail_data (|)
    is also<get-sub-thumbnail-data>
  { * }

  multi method get_sub_thumbnail_data (
    Int()  $src_x,
    Int()  $src_y,
    Int()  $src_width,
    Int()  $src_height,
    Int()  $dest_width,
    Int()  $dest_height,
          :$raw          = False
  ) {
    samewith(
       $src_x,
       $src_y,
       $src_width,
       $src_height,
       $dest_width,
       $dest_height,
       $,
       $,
       $,
      :$raw
    );
  }
  multi method get_sub_thumbnail_data (
    Int()  $src_x,
    Int()  $src_y,
    Int()  $src_width,
    Int()  $src_height,
    Int()  $dest_width,
    Int()  $dest_height,
           $actual_width  is rw,
           $actual_height is rw,
           $bpp           is rw,
          :$raw                  = False
  ) {
    my gint ($x, $y, $w, $h, $dw, $dh) =
      ($src_x, $src_y, $src_width, $src_height, $dest_width, $dest_height);

    my gint ($aw, $ah, $b) = 0 xx 3;

    my $d = gimp_drawable_get_sub_thumbnail_data(
      $!g-d,
      $x,
      $y,
      $w,
      $h,
      $dw,
      $dh,
      $aw,
      $ah,
      $b
    );
    ($actual_width, $actual_height, $bpp) = ($aw, $ah, $b);

    $d = propReturnObject($d, $raw, |GLib::Bytes.getTypePair);
    ($d, $actual_width, $actual_height, $bpp);
  }

  method get_thumbnail (
    Int()  $width,
    Int()  $height,
    Int()  $alpha,
          :$raw     = False
  )
    is also<get-thumbnail>
  {
    my gint ($w, $h) = ($width, $height);

    my GimpPixbufTransparency $a = $alpha;

    propReturnObject(
      gimp_drawable_get_thumbnail($!g-d, $w, $h, $a),
      $raw,
      |GDK::Pixbuf.getTypePair
    );
  }

  proto method get_thumbnail_data (|)
    is also<get-thumbnail-data>
  { * }

  multi method get_thumbnail_data (
    Int()  $width,
    Int()  $height,
          :$raw     = False
  ) {
    samewith($width, $height, $, $, $, :all);
  }
  multi method get_thumbnail_data (
    Int()  $width,
    Int()  $height,
           $actual_width  is rw,
           $actual_height is rw,
           $bpp           is rw,
          :$all                  = False,
          :$raw                  = False
  ) {
    my gint ($w, $h, $aw, $ah, $b) = ($width, $height, 0, 0, 0);

    my $d = propReturnObject(
      gimp_drawable_get_thumbnail_data($!g-d, $w, $h, $aw, $ah, $b),
      $raw,
      |GLib::Bytes.getTypePair
    );
    ($actual_width, $actual_height, $bpp) = ($aw, $ah, $b);
    $all.not ?? $d !! ($d, $actual_width, $actual_height, $bpp)
  }

  method get_thumbnail_format ( :$raw = False ) is also<get-thumbnail-format> {
    propReturnObject(
      gimp_drawable_get_thumbnail_format($!g-d),
      $raw
      |Babl.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_drawable_get_type, $n, $t );
  }

  method get_width is also<get-width> {
    gimp_drawable_get_width($!g-d);
  }

  method has_alpha is also<has-alpha> {
    so gimp_drawable_has_alpha($!g-d);
  }

  multi method histogram (
    Int() $channel,
    Num() $start_range,
    Num() $end_range
  ) {
    samewith($channel, $start_range, $end_range, $, $, $, $, $, $);
  }
  multi method histogram (
    Int() $channel,
    Num() $start_range,
    Num() $end_range,
          $mean         is rw,
          $std_dev      is rw,
          $median       is rw,
          $pixels       is rw,
          $count        is rw,
          $percentile   is rw
  ) {
    my gdouble ($s, $e) = ($start_range, $end_range);

    my GimpHistogramChannel $ch = $channel;

    my gdouble ($m, $d, $med, $pix, $c, $per) = 0e0 xx 6;

    my $rv = so gimp_drawable_histogram(
      $!g-d,
      $ch,
      $s,
      $e,
      $m,
      $d,
      $med,
      $pix,
      $c,
      $per
    );
    return Nil unless $rv;
    ($mean, $std_dev, $median, $pixels, $count, $percentile) =
      ($m, $d, $med, $pix, $c, $per)
  }

  method hue_saturation (
    Int() $hue_range,
    Num() $hue_offset,
    Num() $lightness,
    Num() $saturation,
    Num() $overlap
  )
    is also<hue-saturation>
  {
    my GimpHueRange $r = $hue_range;

    my gdouble ($o, $l, $s, $p) =
      ($hue_offset, $lightness, $saturation, $overlap);

    so gimp_drawable_hue_saturation($!g-d, $r, $o, $l, $s, $p);
  }

  method invert (Int() $linear) {
    my gboolean $l = $linear.so.Int;

    so gimp_drawable_invert($!g-d, $l);
  }

  method is_gray is also<is-gray> {
    so gimp_drawable_is_gray($!g-d);
  }

  method is_indexed is also<is-indexed> {
    so gimp_drawable_is_indexed($!g-d);
  }

  method is_rgb is also<is-rgb> {
    so gimp_drawable_is_rgb($!g-d);
  }

  method levels (
    Int() $channel,
    Num() $low_input,
    Num() $high_input,
    Int() $clamp_input,
    Num() $gamma,
    Num() $low_output,
    Num() $high_output,
    Int() $clamp_output
  ) {
    my GimpHistogramChannel $c = $channel;

    my gdouble ($li, $hi, $g, $lo, $ho) =
      ($low_input, $high_input, $gamma, $low_output, $high_output);

    my gboolean ($i, $o) = ($clamp_input, $clamp_output).map( *.so.Int );

    gimp_drawable_levels($!g-d, $c, $li, $hi, $i, $g, $lo, $ho, $o);
  }

  method levels_stretch is also<levels-stretch> {
    gimp_drawable_levels_stretch($!g-d);
  }

  proto method mask_bounds (|)
    is also<mask-bounds>
  { * }

  multi method mask_bounds {
    samewith($, $, $, $);
  }
  multi method mask_bounds ($x1 is rw, $y1 is rw, $x2 is rw, $y2 is rw) {
    my gint ($xx1, $yy1, $xx2, $yy2) = 0 xx 4;

    gimp_drawable_mask_bounds($!g-d, $xx1, $yy1, $xx2, $yy2);
    ($x1, $y1, $x2, $y2) = ($xx1, $yy1, $xx2, $yy2);
  }

  proto method mask_intersect (|)
    is also<mask-intersect>
  { * }

  multi method mask_intersect {
    samewith($, $, $, $);
  }
  multi method mask_intersect (
    $x      is rw,
    $y      is rw,
    $width  is rw,
    $height is rw
  ) {
    my gint ($xx, $yy, $w, $h) = 0 xx 4;

    my $rv = gimp_drawable_mask_intersect($!g-d, $xx, $yy, $w, $h);
    return Nil unless $rv;
    ($x, $y, $width, $height) = ($xx, $yy, $w, $h);
  }

  method merge_shadow (Int() $undo) is also<merge-shadow> {
    my gboolean $u = $undo.so.Int;

    so gimp_drawable_merge_shadow($!g-d, $u);
  }

  method offset (
    Int() $wrap_around,
    Int() $fill_type,
    Int() $offset_x,
    Int() $offset_y
  ) {
    my gboolean       $w       =  $wrap_around.so.Int;
    my GimpOffsetType $f       =  $fill_type;
    my gint           ($x, $y) = ($offset_x, $offset_y);

    gimp_drawable_offset($!g-d, $w, $f, $x, $y);
  }

  method posterize (Int() $levels) {
    my gint $l = $levels;

    gimp_drawable_posterize($!g-d, $l);
  }

  method shadows_highlights (
    Num() $shadows,
    Num() $highlights,
    Num() $whitepoint,
    Num() $radius,
    Num() $compress,
    Num() $shadows_ccorrect,
    Num() $highlights_ccorrect
  )
    is also<shadows-highlights>
  {
    my gdouble ($s, $h, $w, $r, $c, $sc, $hc) = (
      $shadows,
      $highlights,
      $whitepoint,
      $radius,
      $compress,
      $shadows_ccorrect,
      $highlights_ccorrect
    );

    so gimp_drawable_shadows_highlights($!g-d, $s, $h, $w, $r, $c, $sc, $hc);
  }

  method threshold (
    Int() $channel,
    Num() $low_threshold,
    Num() $high_threshold
  ) {
    my GimpHistogramChannel  $c      =  $channel;
    my gdouble              ($l, $h) = ($low_threshold, $high_threshold);

    gimp_drawable_threshold($!g-d, $c, $l, $h);
  }

  method type ( :$enum = True ) {
    my $t = gimp_drawable_type($!g-d);
    return $t unless $enum;
    GimpImageTypeEnum($t);
  }

  method type_with_alpha ( :$enum = True ) is also<type-with-alpha> {
    my $t = gimp_drawable_type_with_alpha($!g-d);
    return $t unless $enum;
    GimpImageTypeEnum($t);
  }

  method update (Int() $x, Int() $y, Int() $width, Int() $height) {
    my gint ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    so gimp_drawable_update($!g-d, $xx, $yy, $w, $h);
  }

}
