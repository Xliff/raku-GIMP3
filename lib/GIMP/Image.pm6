use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::Image;

use GLib::GList;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GimpImageAncestry is export of Mu
  where GimpImage | GObject;

class GIMP::Image {
  also does GLib::Roles::Object;

  has GimpImage $!g-i is implementor;

  class Convert {
    has $!this is built;

    method grayscale {
      gimp_image_convert_grayscale($!this);
    }

    # cw: Assumptions made:
    #     - Dither Type: Floyd-Steindberg is the defacto standard in dithering,
    #                    however reduced bleeding should make for a better image.
    multi method indexed (
                     @palette,
      Int()         :diter(:dither-type(:$dither_type))      = 2,
      Int()         :palette(:palette-type(:$palette_type))  = 0,
      Int()         :colors(:num-cols(:$num_cols))           = @palette.elems,
      Int()         :alpha(:alpha-dither(:$alpha_dither))    = False,
      Int()         :remove(:remove-unused(:$remove_unused)) = True,
    ) {
      samewith(
        $dither_type,
        $palette_type,
        $num_cols,
        $alpha_dither,
        $remove_unused,
        ArrayToCArray(uint8, @palette)
      );
    }
    multi method indexed (
      Int()         $dither_type,
      Int()         $palette_type,
      Int()         $num_cols,
      Int()         $alpha_dither,
      Int()         $remove_unused,
      CArray[uint8] $palette
    ) {
      my GimpConvertDitherType  $d = $dither_type;
      my GimpConvertPaletteType $p = $palette_type;
      my gint                   $n = $num_cols;

      my gboolean ($a, $r) = ($alpha_dither, $remove_unused).map( *.so.Int );

      if $palette_type = GIMP_CONVERT_PALETTE_GENERATE.Int {
        X::GLib::InvalidArgument.throw(
          message => "Number of colors must be specified when using the  {
                       '' }GIMP_CONVERT_PALETTE_GENERATE type"
        ).throw unless $num_cols;
      }

      if $palette_type == GIMP_CONVERT_PALETTE_CUSTOM.Int {
        X::GLib::InvalidArgument.throw(
          message => "The name of the palette to use must be given when {
                       '' }using the GIMP_CONVERT_PALETTE_CUSTOM type"
        ).throw unless $palette;
      }

      gimp_image_convert_indexed($!this, $d, $p, $n, $a, $r, $palette);
    }

    method precision (Int() $precision) {
      my GimpPrecision $p = $precision;

      gimp_image_convert_precision($!this, $precision);
    }

    method rgb {
      gimp_image_convert_rgb($!this);
    }

    proto method set_dither_matrix (|)
    { * }

    multi method set_dither_matrix (Int() $width, Int() $height, @matrix) {
      samewith( $width, $height, GLib::Bytes.new(@matrix) );
    }
    multi method set_dither_matrix (
      Int()    $width,
      Int()    $height,
      GBytes() $matrix
    )
      is static
    {
      gimp_image_convert_set_dither_matrix($!this, $height, $matrix);
    }

  }

  class Grid {
    has $!this is built;

    proto method get_background_color (|)
    { * }

    multi method get_background_color ( :$raw = False ) {
      samewith( GimpRGB.new, :$raw );
    }
    multi method get_background_color (GimpRGB() $bgcolor, :$raw = False) {
      propReturnObject(
        gimp_image_grid_get_background_color($!this, $bgcolor),
        $raw,
        |GIMP::RGB.getTypePair
      );
    }

    proto method get_foreground_color (|)
    { * }

    multi method get_foreground_color ( :$raw = False ) {
      samewith( GimpRGB.new, :$raw );
    }
    multi method get_foreground_color (GimpRGB() $fgcolor, :$raw = False) {
      propReturnObject(
        gimp_image_grid_get_foreground_color($!this, $fgcolor),
        $raw,
        |GIMP::RGB.getTypePair
      );
    }

    proto method get_offset (|)
    { * }

    multi method get_offset {
      samewith($, $);
    }
    multi method get_offset ($xoffset is rw, $yoffset is rw) {
      my gdouble ($x, $y) = 0e0 xx 2;

      gimp_image_grid_get_offset($!this, $x, $y);
      ($xoffset, $yoffset) = ($x, $y);
    }

    proto method get_spacing (|)
    { * }

    multi method get_spacing {
      samewith($, $);
    }
    multi method get_spacing ($xspacing is rw, $yspacing is rw) {
      my gdouble ($x, $y) = 0e0 xx 2;

      gimp_image_grid_get_spacing($!this, $x, $y);
    }

    method get_style ( :$enum = True ) {
      my $s = gimp_image_grid_get_style($!this);
      return $s unless $enum;
      GimpGridStyleEnum($s);
    }

    method set_background_color (GimpRGB() $bgcolor) {
      gimp_image_grid_set_background_color($!this, $bgcolor);
    }

    method set_foreground_color (GimpRGB() $fgcolor) {
      gimp_image_grid_set_foreground_color($!this, $fgcolor);
    }

    method set_offset (Num() $xoffset, Num() $yoffset) {
      my gdouble ($x, $y) = ($xoffset, $yoffset);

      gimp_image_grid_set_offset($!this, $xoffset, $yoffset);
    }

    method set_spacing (Num() $xspacing, Num() $yspacing) {
      my gdouble ($x, $y) = ($xspacing, $yspacing);

      gimp_image_grid_set_spacing($!this, $xspacing, $yspacing);
    }

    method set_style (Int() $style) {
      my GimpGridStyle $s = $style;

      gimp_image_grid_set_style($!this, $s);
    }

  }

  class Metadata {
    has $!this is built;

    method load_finish (
      Str()          $mime_type,
      GimpMetadata() $metadata,
      Int()          $flags
    ) {
      my GimpMetadataLoadFlags $f = $flags;

      gimp_image_metadata_load_finish($!this, $mime_type, $metadata, $f);
    }

    method load_prepare (
      Str()                   $mime_type,
      GFile()                 $file,
      CArray[Pointer[GError]] $error = gerror
    ) {
      clear_error;
      my $rv = so gimp_image_metadata_load_prepare(
        $!this,
        $mime_type,
        $file,
        $error
      );
      set_error($error);
      $rv;
    }

    method load_thumbnail (
      CArray[Pointer[GError]]  $error = gerror,
                              :$raw   = False
    ) {
      clear_error;
      my $t = propReturnObject(
        gimp_image_metadata_load_thumbnail($!this, $error),
        $raw,
        |GIMP::Thumbnail.getTypePair
      );
      set_error($error);
      $t;
    }

    method save_filter (
      Str()                   $mime_type,
      GimpMetadata()          $metadata,
      Int()                   $flags,
      GFile()                 $file,
      CArray[Pointer[GError]] $error       = gerror
    ) {
      my GimpMetadataSaveFlags $f = $flags;

      clear_error;
      my $rv = so gimp_image_metadata_save_filter(
        $!this,
        $mime_type,
        $metadata,
        $f,
        $file,
        $error
      );
      set_error($error);
      $rv;
    }

    method save_finish (
      Str()                   $mime_type,
      GimpMetadata()          $metadata,
      Int()                   $flags,
      GFile()                 $file,
      CArray[Pointer[GError]] $error       = gerror
    ) {
      my GimpMetadataSaveFlags $f = $flags;

      clear_error;
      my $rv = so gimp_image_metadata_save_finish(
        $!this,
        $mime_type,
        $metadata,
        $f,
        $file,
        $error
      );
      set_error($error);
      $rv;
    }

    method save_prepare (Str() $mime_type, Int() $suggested_flags) {
      my GimpMetadataSaveFlags $f = $suggested_flags;

      gimp_image_metadata_save_prepare($!this, $mime_type, $f);
    }
  }

  has Convert  $.convert;
  has Grid     $.grid;
  has Metadata $.metadata;

  submethod BUILD ( :$gimp-image ) {
    self.setGimpImage($gimp-image) if $gimp-image
  }

  method setGimpImage (GimpImageAncestry $_) {
    my $to-parent;

    $!g-i = do {
      when GimpImage {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpImage, $_);
      }
    }
    self!setObject($to-parent);

    $.convert  .= new( this => $!g-i );
    $.grid     .= new( this => $!g-i );
    $.metadata .= new( this => $!g-i );
  }

  method GIMP::Raw::Definitions::GimpImage
  { $!g-i }

  multi method new ($gimp-image where * ~~ GimpImageAncestry , :$ref = True) {
    return unless $gimp-image;

    my $o = self.bless( :$gimp-image );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $width, Int() $height, Int() $type) {
    my gint              ($w, $h) = ($width, $height);
    my GimpImageBaseType  $t      =  $type;

    my $gimp-image = gimp_image_new($w, $h, $t);

    $gimp-image ?? self.bless( :$gimp-image ) !! Nil;
  }

  method new_with_precision (
    Int() $width,
    Int() $height,
    Int() $type,
    Int() $precision
  ) {
    my gint              ($w, $h) = ($width, $height);
    my GimpImageBaseType  $t      =  $type;
    my GimpPrecision      $p      =  $precision;

    my $gimp-image = gimp_image_new_with_precision($w, $h, $t, $p);

    $gimp-image ?? self.bless( :$gimp-image ) !! Nil;
  }

  method add_hguide (Int() $yposition) {
    my gint $y = $yposition;

    gimp_image_add_hguide($!g-i, $y);
  }

  method add_sample_point (Int() $position_x, Int() $position_y) {
    my gint ($x, $y) = ($position_x, $position_y);

    gimp_image_add_sample_point($!g-i, $x, $y);
  }

  method add_vguide (Int() $xposition) {
    my gint $x = $xposition;

    gimp_image_add_vguide($!g-i, $x);
  }

  method attach_parasite (GimpParasite() $parasite) {
    gimp_image_attach_parasite($!g-i, $parasite);
  }

  method clean_all {
    gimp_image_clean_all($!g-i);
  }

  method convert_color_profile (
    GimpColorProfile() $profile,
    Int()              $intent,
    Int()              $bpc
  ) {
    my GimpColorRenderingIntent $i = $intent;
    my gboolean                 $b = $bpc.so.Int;

    gimp_image_convert_color_profile($!g-i, $profile, $i, $b);
  }

  method convert_color_profile_from_file (
    GFile() $file,
    Int()   $intent,
    Int()   $bpc
  ) {
    my GimpColorRenderingIntent $i = $intent;
    my gboolean                 $b = $bpc.so.Int;

    gimp_image_convert_color_profile_from_file($!g-i, $file, $i, $b);
  }

  method crop (
    Int() $new_width,
    Int() $new_height,
    Int() $offx,
    Int() $offy
  ) {
    my gint ($w, $h, $x, $y) = ($new_width, $new_height, $offx, $offy);

    gimp_image_crop($!g-i, $w, $h, $x, $y);
  }

  method delete {
    gimp_image_delete($!g-i);
  }

  method delete_guide (Int() $guide) {
    my guint $g = $guide;

    gimp_image_delete_guide($!g-i, $g);
  }

  method delete_sample_point (Int() $sample_point) {
    my guint $s = $sample_point;

    gimp_image_delete_sample_point($!g-i, $s);
  }

  method detach_parasite (Str() $name) {
    gimp_image_detach_parasite($!g-i, $name);
  }

  method duplicate ( :$raw = False ) {
    propReturnObject(
      gimp_image_duplicate($!g-i),
      $raw,
      |self.getTypePair
    );
  }

  method find_next_guide (Int() $guide) {
    my guint $g = $guide;

    gimp_image_find_next_guide($!g-i, $g);
  }

  method find_next_sample_point (Int() $sample_point) {
    my guint $s = $sample_point;

    gimp_image_find_next_sample_point($!g-i, $sample_point);
  }

  method flatten {
    gimp_image_flatten($!g-i);
  }

  method flip (Int() $flip_type) {
    my GimpOrientationType $f = $flip_type;

    gimp_image_flip($!g-i, $f);
  }

  method floating_sel_attached_to {
    gimp_image_floating_sel_attached_to($!g-i);
  }

  method freeze_channels {
    gimp_image_freeze_channels($!g-i);
  }

  method freeze_layers {
    gimp_image_freeze_layers($!g-i);
  }

  method freeze_vectors {
    gimp_image_freeze_vectors($!g-i);
  }

  method get_base_type {
    gimp_image_get_base_type($!g-i);
  }

  method get_by_id {
    gimp_image_get_by_id($!g-i);
  }

  method get_channel_by_name (Str() $name, :$raw = False) {
    propReturnObject(
      gimp_image_get_channel_by_name($!g-i, $name),
      $raw,
      |GIMP::Channel.getTypePair
    );
  }

  method get_channel_by_tattoo (Int() $tattoo, :$raw = False) {
    my guint $t = $tattoo;

    propReturnObject(
      gimp_image_get_channel_by_tattoo($!g-i, $t),
      $raw,
      |GIMP::Channel.getTypePair
    )
  }

  proto method get_channels (|)
  { * }

  multi method get_channels ( :$raw = False ,:gslist(:$glist) = False) {
    samewith($, :$raw, :$glist);
  }
  multi method get_channels (
     $num_channels is rw,
    :$raw                 = False,
    :gslist(:$glist)      = False
  ) {
    my gint $n = 0;

    my $l = gimp_image_get_channels($!g-i, $n);
    $num_channels = $n;
    returnGList($l, $raw, $glist, |GIMP::Channel.getTypePair)
  }

  method get_color_profile {
    gimp_image_get_color_profile($!g-i);
  }

  # cw: Defaults to FALSE because specifying :$array will provide
  #     a COPY, not live data.
  proto method get_colormap (|)
  { * }

  multi method get_colormap ( :$array = False ) {
    my ($c, $n);
    my  $a       = samewith($c, $n, :$array);

    ($a, $c, $n);
  }
  multi method get_colormap (
     $colormap_len is rw,
     $num_colors   is rw,
    :$array               = False
  ) {
    my gint ($c, $n) = 0 xx 2;

    my $a = gimp_image_get_colormap($!g-i, $c, $n);
    ($colormap_len, $num_colors) = ($c, $n);
    $a = CArrayToArray($a) if $array;
    $a;
  }

  method get_component_active (Int() $component) {
    my GimpChannelType $c = $component;

    so gimp_image_get_component_active($!g-i, $c);
  }

  method get_component_visible (Int() $component) {
    my GimpChannelType $c = $component;

    so gimp_image_get_component_visible($!g-i, $c);
  }

  method get_default_new_layer_mode ( :$enum = True ) {
    my $m = gimp_image_get_default_new_layer_mode($!g-i);
    return $m unless $enum;
    GimpLayerModeEnum($m);
  }

  method get_effective_color_profile ( :$raw = False ) {
    propReturnObject(
      gimp_image_get_effective_color_profile($!g-i),
      $raw,
      |GIMP::Color::Profile.getTypePair
    );
  }

  method get_exported_file ( :$raw = False ) {
    propReturnObject(
      gimp_image_get_exported_file($!g-i),
      $raw,
      |GIO::File.getTypePair
    );
  }

  method get_file ( :$raw = False ) {
    propReturnObject(
      gimp_image_get_file($!g-i),
      $raw,
      |GIO::File.getTypePair
    )
  }

  method get_floating_sel ( :$raw = False ) {
    propReturnObject(
      gimp_image_get_floating_sel($!g-i),
      $raw,
      |GIMP::Layer.getTypePair
    );
  }

  method get_guide_orientation (Int() $guide, :$enum = True) {
    my guint $g = $guide;

    my $o = gimp_image_get_guide_orientation($!g-i, $g);
    return $o unless $enum;
    GimpOrientationTypeEnum($o);
  }

  method get_guide_position (Int() $guide, :$enum = True) {
    my guint $g = $guide;

    my $o = gimp_image_get_guide_position($!g-i, $guide);
    return $o unless $enum;
    GimpOrientationTypeEnum($o);
  }

  method get_height {
    gimp_image_get_height($!g-i);
  }

  method get_id {
    gimp_image_get_id($!g-i);
  }

  method get_imported_file ( :$raw = False ) {
    propReturnObject(
      gimp_image_get_imported_file($!g-i),
      $raw,
      |GIO::File.getTypePair
    );
  }

  method get_item_position (GimpItem()  $item) {
    gimp_image_get_item_position($!g-i, $item);
  }

  method get_layer_by_name (Str() $name, :$raw = False) {
    propReturnObject(
      gimp_image_get_layer_by_name($!g-i, $name),
      $raw,
      |GIMP::Layer.getTypePair
    );
  }

  method get_layer_by_tattoo (Int() $tattoo, :$raw = False) {
    my guint $t = $tattoo;

    propReturnObject(
      gimp_image_get_layer_by_tattoo($!g-i, $t),
      $raw,
      |GIMP::Layer.getTypePair
    );
  }

  proto method get_layers (|)
  { * }

  multi method get_layers (:$raw = False, :gslist(:$glist) = False ) {
    samewith($, :$raw, :$glist);
  }
  multi method get_layers (
     $num_layers     is rw,
    :$raw                    = False,
    :gslist(:$glist)         = False
  ) {
    my gint $n = 0;

    my $ll = returnGList(
      gimp_image_get_layers($!g-i, $n),
      $raw,
      $glist,
      |GIMP::Layer.getTypePair
    );
    $num_layers = $n;
    $ll;
  }

  method get_metadata ( :$raw = False ) {
    propReturnObject(
      gimp_image_get_metadata($!g-i),
      $raw,
      |GIMP::Metadata.getTypePair
    );
  }

  method get_name {
    gimp_image_get_name($!g-i);
  }

  method get_parasite (Str() $name, :$raw = False) {
    propReturnObject(
      gimp_image_get_parasite($!g-i, $name),
      $raw,
      |GIMP::Parasite.getTypePair
    );
  }

  method get_parasite_list ( :$raw = False, :gslist(:$glist) ) {
    returnGList(
      gimp_image_get_parasite_list($!g-i),
      $raw,
      $glist,
      |GIMP::Parasite.getTypePair
    );
  }

  method get_precision ( :$enum = True ) {
    my $p = gimp_image_get_precision($!g-i);
    return $p unless $enum;
    GimpPrecisionEnum($p);
  }

  proto method get_resolution (|)
  { * }

  multi method get_resolution {
    samewith($, $);
  }
  multi method get_resolution (
    $xresolution is rw,
    $yresolution is rw
  ) {
    my gdouble ($x, $y) = 0e0 xx 2;
    gimp_image_get_resolution($!g-i, $x, $y);
    ($xresolution, $yresolution) = ($x, $y);
  }

  proto method get_sample_point_position (|)
  { * }

  multi method get_sample_point_position (Int() $sample_point) {
    samewith($sample_point, $);
  }
  multi method get_sample_point_position (
    Int() $sample_point,
          $position_y    is rw
  ) {
    my guint $s = $sample_point;
    my gint  $y = 0;

    gimp_image_get_sample_point_position($!g-i, $s, $y);
    $position_y = $y;
  }

  proto method get_selected_channels (|)
  { * }

  multi method get_selected_channels (
    :$raw            = False,
    :gslist(:$glist) = False
  ) {
    samewith($, :$raw, :$glist);
  }
  multi method get_selected_channels (
     $num_channels   is rw,
    :$raw                   = False,
    :gslist(:$glist)        = False
  ) {
    my gint $n  = 0;

    my $cl = returnGList(
      gimp_image_get_selected_channels($!g-i, $n),
      $raw,
      $glist,
      |GIMP::Channel.getTypePair
    );
    $num_channels = $n;
    $cl;
  }

  proto method get_selected_drawables (|)
  { * }

  multi method get_selected_drawables (
    :$raw            = False,
    :gslist(:$glist) = False
  ) {
    samewith($);
  }
  multi method get_selected_drawables (
     $num_drawables  is rw,
    :$raw                   = False,
    :gslist(:$glist)        = False
  ) {
    my gint $n  = 0;

    my $cl = returnGList(
      gimp_image_get_selected_drawables($!g-i, $n),
      $raw,
      $glist,
      |GIMP::Drawable.getTypePair
    );
    $num_drawables = $n;
    $cl;
  }

  proto method get_selected_layers (|)
  { * }

  multi method get_selected_layers (
    :$raw            = False,
    :gslist(:$glist) = False
  ) {
    samewith($);
  }
  multi method get_selected_layers (
     $num_layers  is rw,
    :$raw                   = False,
    :gslist(:$glist)        = False
  ) {
    my gint $n  = 0;

    my $cl = returnGList(
      gimp_image_get_selected_layers($!g-i, $n),
      $raw,
      $glist,
      |GIMP::Layers.getTypePair
    );
    $num_layers = $n;
    $cl;
  }

  proto method get_selected_vectors (|)
  { * }

  multi method get_selected_vectors (
    :$raw            = False,
    :gslist(:$glist) = False
  ) {
    samewith($);
  }
  multi method get_selected_vectors (
     $num_vectors   is rw,
    :$raw                   = False,
    :gslist(:$glist)        = False
  ) {
    my gint $n  = 0;

    my $cl = returnGList(
      gimp_image_get_selected_vectors($!g-i, $n),
      $raw,
      $glist,
      |GIMP::Vector.getTypePair
    );
    $num_vectors = $n;
    $cl;
  }

  method get_selection ( :$raw = False ) {
    propReturnObject(
      gimp_image_get_selection($!g-i),
      $raw,
      |GIMP::Selection.getTypePair
    );
  }

  method get_simulation_bpc {
    so gimp_image_get_simulation_bpc($!g-i);
  }

  method get_simulation_intent ( :$enum = True ) {
    my $i = gimp_image_get_simulation_intent($!g-i);
    return $i unless $enum;
    GimpColorRenderingIntentEnum($i);
  }

  method get_simulation_profile ( :$raw = False ) {
    propReturnObject(
      gimp_image_get_simulation_profile($!g-i),
      $raw,
      |GIMP::Color::Profile.getTypePair
    );
  }

  method get_tattoo_state {
    gimp_image_get_tattoo_state($!g-i);
  }

  method get_thumbnail (
    Int()  $width,
    Int()  $height,
    Int()  $alpha,
          :$raw      = False
  ) {
    my gint                   ($w, $h) = ($width, $height);
    my GimpPixbufTransparency  $a      =  $alpha;

    propReturnObject(
      gimp_image_get_thumbnail($!g-i, $w, $h, $a),
      $raw,
      |GIMP::Thumbnail.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_image_get_type, $n, $t );
  }

  proto method get_thumbnail_data (|)
  { * }

  multi method get_thumbnail_data ( :$buf = False ) {
    samewith($, $, $, :$buf)
  }
  multi method get_thumbnail_data (
     $width  is rw,
     $height is rw,
     $bpp    is rw,
    :$buf           = False
  ) {
    my gint ($w, $h, $b) = 0 xx 3;

    my $d = gimp_image_get_thumbnail_data($!g-i, $w, $h, $b);
    ($width, $height, $bpp) = ($w, $h, $b);
    return $d unless $buf;
    Buf.new($d)
  }

  method get_unit ( :$raw = False ) {
    propReturnObject(
      gimp_image_get_unit($!g-i),
      $raw,
      |GIMP::Unit.getTypePair
    );
  }

  proto method get_vectors (|)
  { * }

  multi method get_vectors (
    :$raw                   = False,
    :gslist(:$glist)        = False
  ) {
    samewith($, :$raw, :$glist);
  }
  multi method get_vectors (
     $num_vectors    is rw,
    :$raw                   = False,
  ) {
    my gint $n = 0;

    my $va = gimp_image_get_vectors($!g-i, $n),
    $num_vectors = $n;
    return $va if $raw;
    CArrayToArray($va).map({ GIMP::Vector.new($_) });
  }

  method get_vectors_by_name (Str() $name, :$raw = False) {
    propReturnObject(
      gimp_image_get_vectors_by_name($!g-i, $name),
      $raw,
      |GIMP::Vector.getTypePair
    );
  }

  method get_vectors_by_tattoo (Int() $tattoo, :$raw = False) {
    my guint $t = $tattoo;

    propReturnObject(
      gimp_image_get_vectors_by_tattoo($!g-i, $tattoo),
      $raw,
      |GIMP::Vector.getTypePair
    );
  }

  method get_width {
    gimp_image_get_width($!g-i);
  }

  method get_xcf_file ( :$raw = False ) {
    propReturnObject(
      gimp_image_get_xcf_file($!g-i),
      $raw,
      |GIO::File.getTypePair
    );
  }

  method get_images ( :$raw = False ) {
    my $ia = CArrayToArray( gimp_get_images($!g-i) );
    return $ia if $raw;
    CArrayToArray($ia).map({ ::?CLASS.new($_) });
  }

  method list_images ( :$raw = False, :gslist(:$glist) = False )
    is static
  {
    returnGList(
      gimp_list_images(),
      $raw,
      $glist,
      |self.getTypePair
    );
  }

  method id_is_valid {
    so gimp_image_id_is_valid($!g-i);
  }

  proto method insert_channel (|)
  { * }

  multi method insert_channel (
    GimpChannel()  $channel,
    Int()          $position,
    GimpChannel() :$parent    = GimpChannel
  ) {
    samewith($channel, $parent, $position);
  }
  multi method insert_channel (
    GimpChannel() $channel,
    GimpChannel() $parent,
    Int()         $position,
  ) {
    my gint $p = $position;

    gimp_image_insert_channel($!g-i, $channel, $parent, $p);
  }

  proto method insert_layer (|)
  { * }

  multi method insert_layer (
    GimpLayer()  $layer,
    Int()        $position,
    GimpLayer() :$parent    = GimpLayer
  ) {
    samewith($layer, $parent, $position);
  }
  multi method insert_layer (
    GimpLayer() $layer,
    GimpLayer() $parent,
    Int()       $position
  ) {
    my gint $p = $position;

    gimp_image_insert_layer($!g-i, $layer, $parent, $p);
  }

  proto method insert_vectors (|)
  { * }

  multi method insert_vectors (
    GimpVectors()  $vectors,
    Int()          $position,
    GimpVectors() :$parent    = GimpVectors
  ) {
    samewith($vectors, $parent, $position);
  }
  multi method insert_vectors (
    GimpVectors() $vectors,
    GimpVectors() $parent,
    Int()         $position
  ) {
    my gint $p = $position;

    gimp_image_insert_vectors($!g-i, $vectors, $parent, $p);
  }

  method is_dirty {
    so gimp_image_is_dirty($!g-i);
  }

  method is_valid {
    so gimp_image_is_valid($!g-i);
  }

  method list_channels ( :$raw = False, :$glist = False ) {
    returnGList(
      gimp_image_list_channels($!g-i),
      $raw,
      $glist,
      |GIMP::Channel.getTypePair
    );
  }

  method list_layers ( :$raw = False, :$glist = False ) {
    returnGList(
      gimp_image_list_layers($!g-i),
      $raw,
      $glist,
      |GIMP::Layer.getTypePair
    );
  }

  method list_selected_channels ( :$raw = False, :$glist = False ) {
    returnGList(
      gimp_image_list_selected_channels($!g-i),
      $raw,
      $glist,
      |GIMP::Channel.getTypePair
    );
  }

  method list_selected_drawables ( :$raw = False, :$glist = False ) {
    returnGList(
      gimp_image_list_selected_drawables($!g-i),
      $raw,
      $glist,
      |GIMP::Drawable.getTypePair
    );
  }

  method list_selected_layers ( :$raw = False, :$glist = False ) {
    returnGList(
      gimp_image_list_selected_layers($!g-i),
      $raw,
      $glist,
      |GIMP::Layer.getTypePair
    );
  }

  method list_selected_vectors ( :$raw = False, :$glist = False ) {
    returnGList(
      gimp_image_list_selected_vectors($!g-i),
      $raw,
      $glist
      |GIMP::Vectors.getTypePair
    );
  }

  method list_vectors ( :$raw = False, :$glist = False ) {
    returnGList(
      gimp_image_list_vectors($!g-i),
      $raw,
      $glist,
      |GIMP::Vector.getTypePair
    );
  }

  method lower_item (GimpItem() $item) {
    gimp_image_lower_item($!g-i, $item);
  }

  method lower_item_to_bottom (GimpItem() $item) {
    gimp_image_lower_item_to_bottom($!g-i, $item);
  }

  method merge_down (
    GimpLayer() $merge_layer,
    Int()       $merge_type
  ) {
    my GimpMergeType $m = $merge_type;

    gimp_image_merge_down($!g-i, $merge_layer, $m);
  }

  method merge_layer_group (GimpLayer() $layer_group) {
    gimp_image_merge_layer_group($!g-i, $layer_group);
  }

  method merge_visible_layers (Int() $merge_type) {
    my GimpMergeType $m = $merge_type;

    gimp_image_merge_visible_layers($!g-i, $m);
  }

  proto method pick_color (|)
  { * }

  multi method pick_color (
                      @drawables,
    Num()             $x,
    Num()             $y,
    Num()             $average_radius,
    GimpRGB()         $color,
    Int()            :merged(:sample-merged(:$sample_merged))
                       = False,
    Int()            :avg(:sample-average(:$sample_average))
                       = False,
                     :num(:num-drawables(:$num_drawables))
                       = @drawables.elems
  ) {
    samewith(
      $num_drawables,
      ArrayToCArray(GimpItem, @drawables),
      $x,
      $y,
      $sample_merged,
      $sample_average,
      $average_radius,
      $color
    );
  }
  multi method pick_color (
    Int()            $num_drawables,
    CArray[GimpItem] $drawables,
    Num()            $x,
    Num()            $y,
    Int()            $sample_merged,
    Int()            $sample_average,
    Num()            $average_radius,
    GimpRGB()        $color
  ) {
    my gint      $n        =  $num_drawables;
    my gdouble  ($xx, $yy) = ($x, $y);
    my gboolean ($a, $m)   = ($sample_merged, $sample_average).map( *.so.Int );

    gimp_image_pick_color(
      $!g-i,
      $n,
      $drawables,
      $x,
      $y,
      $m,
      $a,
      $average_radius,
      $color
    );
  }

  method pick_correlate_layer (Int() $x, Int() $y) {
    my gint ($xx, $yy) = ($x, $y);

    gimp_image_pick_correlate_layer($!g-i, $xx, $yy);
  }

  method policy_color_profile (Int() $interactive) {
    my gboolean  $i = $interactive.so.Int;

    gimp_image_policy_color_profile($!g-i, $i);
  }

  method policy_rotate (Int() $interactive) {
    my gboolean  $i = $interactive.so.Int;

    gimp_image_policy_rotate($!g-i, $i);
  }

  method raise_item (GimpItem() $item) {
    gimp_image_raise_item($!g-i, $item);
  }

  method raise_item_to_top (GimpItem() $item) {
    gimp_image_raise_item_to_top($!g-i, $item);
  }

  method remove_channel (GimpChannel() $channel) {
    gimp_image_remove_channel($!g-i, $channel);
  }

  method remove_layer (GimpLayer() $layer) {
    gimp_image_remove_layer($!g-i, $layer);
  }

  method remove_vectors (GimpVectors() $vectors) {
    gimp_image_remove_vectors($!g-i, $vectors);
  }

  method reorder_item (
    GimpItem()  $item,
    GimpItem()  $parent,
    Int()       $position
  ) {
    my gint $p = $position;

    gimp_image_reorder_item($!g-i, $item, $parent, $p);
  }

  method resize (
    Int() $new_width,
    Int() $new_height,
    Int() $offx,
    Int() $offy
  ) {
    my gint ($w, $h, $x, $y) = ($new_width, $new_height, $offx, $offy);

    gimp_image_resize($!g-i, $w, $h, $x, $y);
  }

  method resize_to_layers {
    gimp_image_resize_to_layers($!g-i);
  }

  method rotate (Int() $rotate_type) {
    my GimpRotationType $r = $rotate_type;

    gimp_image_rotate($!g-i, $r);
  }

  method scale (Int() $new_width, Int() $new_height) {
    my gint ($w, $h) = ($new_width, $new_height);

    gimp_image_scale($!g-i, $w, $h);
  }

  method select_color (
    Int()          $operation,
    GimpDrawable() $drawable,
    GimpRGB()      $color
  ) {
    my GimpChannelOps $o = $operation;

    so gimp_image_select_color($!g-i, $o, $drawable, $color);
  }

  method select_contiguous_color (
    Int()          $operation,
    GimpDrawable() $drawable,
    Num()          $x,
    Num()          $y
  ) {
    my GimpChannelOps  $o        =  $operation;
    my gdouble        ($xx, $yy) = ($x, $y);

    gimp_image_select_contiguous_color($!g-i, $o, $drawable, $xx, $yy);
  }

  method select_ellipse (
    GimpDrawable() $drawable,
    Num()          $x,
    Num()          $y,
    Num()          $width,
    Num()          $height
  ) {
    my gdouble        ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    gimp_image_select_ellipse($!g-i, $drawable, $xx, $yy, $w, $h);
  }

  method select_item (
    Int()      $operation,
    GimpItem() $item
  ) {
    my GimpChannelOps  $o =  $operation;

    gimp_image_select_item($!g-i, $operation, $item);
  }

  proto method select_polygon (|)
  { * }

  multi method select_polygon (
    Int()            $operation,
                     @segs,
                    :$num_segs = @segs.elems
  ) {
    samewith( $operation, $num_segs, ArrayToCArray(gdouble, @segs) );
  }
  multi method select_polygon (
    Int()           $operation,
    Int()           $num_segs,
    CArray[gdouble] $segs
  ) {
    my guint           $n = $num_segs;
    my GimpChannelOps  $o = $operation;

    gimp_image_select_polygon($!g-i, $operation, $num_segs, $segs);
  }

  proto method select_rectangle (|)
  { * }

  multi method select_rectangle (
    Int() $operation,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my GimpChannelOps  $o                =  $operation;
    my gdouble        ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    gimp_image_select_rectangle($!g-i, $o, $xx, $yy, $w, $h);
  }
  multi method select_rectangle (
    Int() $operation,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height,
    Num() $corner_radius_x,
    Num() $corner_radius_y
  ) {
    my GimpChannelOps  $o =  $operation;

    my gdouble ($xx, $yy, $w, $h, $cx, $cy) =
      ($x, $y, $width, $height, $corner_radius_x, $corner_radius_y);

    gimp_image_select_round_rectangle($!g-i, $o, $xx, $yy, $w, $h, $cx, $cy);
  }

  method set_color_profile (GimpColorProfile() $profile) {
    gimp_image_set_color_profile($!g-i, $profile);
  }

  method set_color_profile_from_file (GFile() $file) {
    gimp_image_set_color_profile_from_file($!g-i, $file);
  }

  proto method set_colormap (|)
  { * }

  multi method set_colormap (
           @colormap,
    Int() :$num_colors = @colormap.elems
  ) {
    samewith( ArrayToCArray(uint8, @colormap), @colormap.elems );
  }
  multi method set_colormap (
    CArray[uint8] $colormap,
    Int()         $num_colors
  ) {
    my gint $n = $num_colors;

    gimp_image_set_colormap($!g-i, $colormap, $n);
  }

  method set_component_active (
    Int() $component,
    Int() $active
  ) {
    my GimpChannelType $c = $component;
    my gboolean        $a = $active.so.Int;

    gimp_image_set_component_active($!g-i, $component, $a);
  }

  method set_component_visible (
    Int() $component,
    Int() $visible
  ) {
    my GimpChannelType $c = $component;
    my gboolean        $v = $visible.so.Int;

    gimp_image_set_component_visible($!g-i, $component, $v);
  }

  method set_file (GFile() $file) {
    gimp_image_set_file($!g-i, $file);
  }

  method set_metadata (GimpMetadata() $metadata) {
    gimp_image_set_metadata($!g-i, $metadata);
  }

  method set_resolution (Num() $xresolution, Num() $yresolution) {
    my gdouble ($x, $y)  = ($xresolution, $yresolution);

    so gimp_image_set_resolution($!g-i, $x, $y);
  }

  proto method set_selected_channels (|)
  { * }

  multi method set_selected_channels (@channels) {
    samewith( ArrayToCArray(GimpChannel, @channels) );
  }
  multi method set_selected_channels (
    Num()               $num,
    CArray[GimpChannel] $channels
  ) {
    my gint $n = $num;
    gimp_image_set_selected_channels($!g-i, $num, $channels);
  }

  proto method set_selected_layers (|)
  { * }

  multi method set_selected_layers (@layers) {
    samewith( ArrayToCArray(GimpLayer, @layers) );
  }
  multi method set_selected_layers (
    Num()             $num,
    CArray[GimpLayer] $layers
  ) {
    my gint $n = $num;
    gimp_image_set_selected_layers($!g-i, $num, $layers);
  }

  proto method set_selected_vectors (|)
  { * }

  multi method set_selected_vectors (@vectors) {
    samewith( ArrayToCArray(@vectors) );
  }
  multi method set_selected_vectors (
    Num()               $num,
    CArray[GimpVectors] $vectors
  ) {
    my gint $n = $num;
    gimp_image_set_selected_vectors($!g-i, $num, $vectors);
  }

  method set_simulation_bpc (Int() $bpc) {
    my gboolean $b = $bpc.so.Int;

    gimp_image_set_simulation_bpc($!g-i, $bpc);
  }

  method set_simulation_intent (Int() $intent) {
    my GimpColorRenderingIntent $i = $intent;

    gimp_image_set_simulation_intent($!g-i, $i);
  }

  method set_simulation_profile (GimpColorProfile() $profile) {
    gimp_image_set_simulation_profile($!g-i, $profile);
  }

  method set_simulation_profile_from_file (GFile() $file) {
    gimp_image_set_simulation_profile_from_file($!g-i, $file);
  }

  method set_tattoo_state (Int() $tattoo_state) {
    my guint $t = $tattoo_state;

    gimp_image_set_tattoo_state($!g-i, $t);
  }

  method set_unit (GimpUnit() $unit) {
    gimp_image_set_unit($!g-i, $unit);
  }

  method take_selected_channels (
    GList()  $channels,
            :$raw       = False,
            :$glist     = False
  ) {
    returnGList(
      gimp_image_take_selected_channels($!g-i, $channels),
      $raw,
      $glist,
      |GIMP::Channel.getTypePair
    );
  }

  method take_selected_layers (
    GList()  $layers,
            :$raw      = False,
            :$glist    = False
  ) {
    returnGList(
      gimp_image_take_selected_layers($!g-i, $layers),
      $raw,
      $glist,
      |GIMP::Layer.getTypePair
    );
  }

  method take_selected_vectors (
    GList()  $vectors,
            :$raw      = False,
            :$glist    = False
  ) {
    returnGList(
      gimp_image_take_selected_vectors($!g-i, $vectors),
      $raw,
      $glist,
      |GIMP::Vector.getTypePair
    );
  }

  method thaw_channels {
    gimp_image_thaw_channels($!g-i);
  }

  method thaw_layers {
    gimp_image_thaw_layers($!g-i);
  }

  method thaw_vectors {
    gimp_image_thaw_vectors($!g-i);
  }

  method undo_disable {
    gimp_image_undo_disable($!g-i);
  }

  method undo_enable {
    gimp_image_undo_enable($!g-i);
  }

  method undo_freeze {
    gimp_image_undo_freeze($!g-i);
  }

  method undo_group_end {
    gimp_image_undo_group_end($!g-i);
  }

  method undo_group_start {
    gimp_image_undo_group_start($!g-i);
  }

  method undo_is_enabled {
    gimp_image_undo_is_enabled($!g-i);
  }

  method undo_thaw {
    gimp_image_undo_thaw($!g-i);
  }

  method unset_active_channel {
    gimp_image_unset_active_channel($!g-i);
  }

}
