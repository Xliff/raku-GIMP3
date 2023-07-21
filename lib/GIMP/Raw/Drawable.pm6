use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use BABL;
use GEGL::Raw::Definitions;
use GDK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::Drawable;

### /usr/src/gimp/libgimp/gimpdrawable_pdb.h

sub _gimp_drawable_get_format (GimpDrawable $drawable)
  returns Str
  is      native(gimp)
  is      export
{ * }

sub _gimp_drawable_get_thumbnail_format (GimpDrawable $drawable)
  returns Str
  is      native(gimp)
  is      export
{ * }

sub _gimp_drawable_sub_thumbnail (
  GimpDrawable   $drawable,
  gint           $src_x,
  gint           $src_y,
  gint           $src_width,
  gint           $src_height,
  gint           $dest_width,
  gint           $dest_height,
  gint           $width          is rw,
  gint           $height         is rw,
  gint           $bpp            is rw,
  CArray[GBytes] $thumbnail_data
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub _gimp_drawable_thumbnail (
  GimpDrawable   $drawable,
  gint           $width,
  gint           $height,
  gint           $actual_width   is rw,
  gint           $actual_height  is rw,
  gint           $bpp            is rw,
  CArray[GBytes] $thumbnail_data
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_fill (
  GimpDrawable $drawable,
  GimpFillType $fill_type
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_foreground_extract (
  GimpDrawable              $drawable,
  GimpForegroundExtractMode $mode,
  GimpDrawable              $mask
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_free_shadow (GimpDrawable $drawable)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_get_bpp (GimpDrawable $drawable)
  returns gint
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_get_height (GimpDrawable $drawable)
  returns gint
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_get_offsets (
  GimpDrawable $drawable,
  gint         $offset_x is rw,
  gint         $offset_y is rw
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_get_width (GimpDrawable $drawable)
  returns gint
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_has_alpha (GimpDrawable $drawable)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_is_gray (GimpDrawable $drawable)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_is_indexed (GimpDrawable $drawable)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_is_rgb (GimpDrawable $drawable)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_mask_bounds (
  GimpDrawable $drawable,
  gint         $x1        is rw,
  gint         $y1        is rw,
  gint         $x2        is rw,
  gint         $y2        is rw
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_mask_intersect (
  GimpDrawable $drawable,
  gint         $x         is rw,
  gint         $y         is rw,
  gint         $width     is rw,
  gint         $height    is rw
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_merge_shadow (
  GimpDrawable $drawable,
  gboolean     $undo
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_offset (
  GimpDrawable   $drawable,
  gboolean       $wrap_around,
  GimpOffsetType $fill_type,
  gint           $offset_x,
  gint           $offset_y
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_type (GimpDrawable $drawable)
  returns GimpImageType
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_type_with_alpha (GimpDrawable $drawable)
  returns GimpImageType
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_update (
  GimpDrawable $drawable,
  gint         $x,
  gint         $y,
  gint         $width,
  gint         $height
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

### /usr/src/gimp/libgimp/gimpdrawable.h

sub gimp_drawable_get_buffer (GimpDrawable $drawable)
  returns GeglBuffer
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_get_by_id (gint32 $drawable_id)
  returns GimpDrawable
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_get_format (GimpDrawable $drawable)
  returns Babl
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_get_shadow_buffer (GimpDrawable $drawable)
  returns GeglBuffer
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_get_sub_thumbnail (
  GimpDrawable           $drawable,
  gint                   $src_x,
  gint                   $src_y,
  gint                   $src_width,
  gint                   $src_height,
  gint                   $dest_width,
  gint                   $dest_height,
  GimpPixbufTransparency $alpha
)
  returns GdkPixbuf
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_get_sub_thumbnail_data (
  GimpDrawable $drawable,
  gint         $src_x,
  gint         $src_y,
  gint         $src_width,
  gint         $src_height,
  gint         $dest_width,
  gint         $dest_height,
  gint         $actual_width  is rw,
  gint         $actual_height is rw,
  gint         $bpp           is rw
)
  returns GBytes
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_get_thumbnail (
  GimpDrawable           $drawable,
  gint                   $width,
  gint                   $height,
  GimpPixbufTransparency $alpha
)
  returns GdkPixbuf
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_get_thumbnail_data (
  GimpDrawable $drawable,
  gint         $width,
  gint         $height,
  gint         $actual_width  is rw,
  gint         $actual_height is rw,
  gint         $bpp           is rw
)
  returns GBytes
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_get_thumbnail_format (GimpDrawable $drawable)
  returns Babl
  is      native(gimp)
  is      export
{ * }

### /usr/src/gimp/libgimp/gimpdrawablecolor_pdb.h

sub gimp_drawable_brightness_contrast (
  GimpDrawable $drawable,
  gdouble      $brightness,
  gdouble      $contrast
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_color_balance (
  GimpDrawable     $drawable,
  GimpTransferMode $transfer_mode,
  gboolean         $preserve_lum,
  gdouble          $cyan_red,
  gdouble          $magenta_green,
  gdouble          $yellow_blue
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_colorize_hsl (
  GimpDrawable $drawable,
  gdouble      $hue,
  gdouble      $saturation,
  gdouble      $lightness
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_curves_explicit (
  GimpDrawable         $drawable,
  GimpHistogramChannel $channel,
  gint                 $num_values,
  CArray[gdouble]      $values
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_curves_spline (
  GimpDrawable         $drawable,
  GimpHistogramChannel $channel,
  gint                 $num_points,
  CArray[gdouble]      $points
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_desaturate (
  GimpDrawable       $drawable,
  GimpDesaturateMode $desaturate_mode
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_equalize (
  GimpDrawable $drawable,
  gboolean     $mask_only
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_extract_component (
  GimpDrawable $drawable,
  gint         $component,
  gboolean     $invert,
  gboolean     $linear
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_histogram (
  GimpDrawable         $drawable,
  GimpHistogramChannel $channel,
  gdouble              $start_range,
  gdouble              $end_range,
  gdouble              $mean         is rw,
  gdouble              $std_dev      is rw,
  gdouble              $median       is rw,
  gdouble              $pixels       is rw,
  gdouble              $count        is rw,
  gdouble              $percentile   is rw
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_hue_saturation (
  GimpDrawable $drawable,
  GimpHueRange $hue_range,
  gdouble      $hue_offset,
  gdouble      $lightness,
  gdouble      $saturation,
  gdouble      $overlap
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_invert (
  GimpDrawable $drawable,
  gboolean     $linear
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_levels (
  GimpDrawable         $drawable,
  GimpHistogramChannel $channel,
  gdouble              $low_input,
  gdouble              $high_input,
  gboolean             $clamp_input,
  gdouble              $gamma,
  gdouble              $low_output,
  gdouble              $high_output,
  gboolean             $clamp_output
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_levels_stretch (GimpDrawable $drawable)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_posterize (
  GimpDrawable $drawable,
  gint         $levels
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_shadows_highlights (
  GimpDrawable $drawable,
  gdouble      $shadows,
  gdouble      $highlights,
  gdouble      $whitepoint,
  gdouble      $radius,
  gdouble      $compress,
  gdouble      $shadows_ccorrect,
  gdouble      $highlights_ccorrect
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_threshold (
  GimpDrawable         $drawable,
  GimpHistogramChannel $channel,
  gdouble              $low_threshold,
  gdouble              $high_threshold
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

### /usr/src/gimp/libgimp/gimpdrawableedit_pdb.h

sub gimp_drawable_edit_bucket_fill (
  GimpDrawable $drawable,
  GimpFillType $fill_type,
  gdouble      $x,
  gdouble      $y
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_edit_clear (GimpDrawable $drawable)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_edit_fill (
  GimpDrawable $drawable,
  GimpFillType $fill_type
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_edit_gradient_fill (
  GimpDrawable     $drawable,
  GimpGradientType $gradient_type,
  gdouble          $offset,
  gboolean         $supersample,
  gint             $supersample_max_depth,
  gdouble          $supersample_threshold,
  gboolean         $dither,
  gdouble          $x1,
  gdouble          $y1,
  gdouble          $x2,
  gdouble          $y2
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_edit_stroke_item (
  GimpDrawable $drawable,
  GimpItem     $item
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_drawable_edit_stroke_selection (GimpDrawable $drawable)
  returns uint32
  is      native(gimp)
  is      export
{ * }

### Manual addition

sub gimp_drawable_get_type
  returns GType
  is      native(gimp)
  is      export
{ * }
