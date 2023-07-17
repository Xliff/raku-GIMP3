use v6.c;

use GIMP::Raw::Types;
use GIMP::Raw::Image;

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

    method indexed (
      GimpConvertDitherType  $dither_type,
      GimpConvertPaletteType $palette_type,
      gint                   $num_cols,
      gboolean               $alpha_dither,
      gboolean               $remove_unused,
      Str                    $palette
    ) {
      gimp_image_convert_indexed($!this, $dither_type, $palette_type, $num_cols, $alpha_dither, $remove_unused, $palette);
    }

    method precision (
      GimpPrecision $precision
    ) {
      gimp_image_convert_precision($!this, $precision);
    }

    method rgb {
      gimp_image_convert_rgb($!this);
    }

    method set_dither_matrix (
      gint   $height,
      GBytes $matrix
    ) {
      gimp_image_convert_set_dither_matrix($!this, $height, $matrix);
    }

  }

  class Grid {
    has $!this is built;

    method get_background_color (GimpRGB   $bgcolor) {
      gimp_image_grid_get_background_color($!this, $bgcolor);
    }

    method get_foreground_color (GimpRGB   $fgcolor) {
      gimp_image_grid_get_foreground_color($!this, $fgcolor);
    }

    method get_offset (
      gdouble   $xoffset is rw,
      gdouble   $yoffset is rw
    ) {
      gimp_image_grid_get_offset($!this, $xoffset, $yoffset);
    }

    method get_spacing (
      gdouble   $xspacing is rw,
      gdouble   $yspacing is rw
    ) {
      gimp_image_grid_get_spacing($!this, $xspacing, $yspacing);
    }

    method get_style {
      gimp_image_grid_get_style($!this);
    }

    method set_background_color (GimpRGB   $bgcolor) {
      gimp_image_grid_set_background_color($!this, $bgcolor);
    }

    method set_foreground_color (GimpRGB   $fgcolor) {
      gimp_image_grid_set_foreground_color($!this, $fgcolor);
    }

    method set_offset (
      gdouble   $xoffset,
      gdouble   $yoffset
    ) {
      gimp_image_grid_set_offset($!this, $xoffset, $yoffset);
    }

    method set_spacing (
      gdouble   $xspacing,
      gdouble   $yspacing
    ) {
      gimp_image_grid_set_spacing($!this, $xspacing, $yspacing);
    }

    method set_style (GimpGridStyle $style) {
      gimp_image_grid_set_style($!this, $style);
    }

  }

  class Metadata {
    has $!this is built;

    method load_finish (
      Str                   $mime_type,
      GimpMetadata          $metadata,
      GimpMetadataLoadFlags $flags
    ) {
      gimp_image_metadata_load_finish($!this, $mime_type, $metadata, $flags);
    }

    method load_prepare (
      Str                     $mime_type,
      GFile                   $file,
      CArray[Pointer[GError]] $error
    ) {
      gimp_image_metadata_load_prepare($!this, $mime_type, $file, $error);
    }

    method load_thumbnail (CArray[Pointer[GError]] $error) {
      gimp_image_metadata_load_thumbnail($!this, $error);
    }

    method save_filter (
      Str                     $mime_type,
      GimpMetadata            $metadata,
      GimpMetadataSaveFlags   $flags,
      GFile                   $file,
      CArray[Pointer[GError]] $error
    ) {
      gimp_image_metadata_save_filter($!this, $mime_type, $metadata, $flags, $file, $error);
    }

    method save_finish (
      Str                     $mime_type,
      GimpMetadata            $metadata,
      GimpMetadataSaveFlags   $flags,
      GFile                   $file,
      CArray[Pointer[GError]] $error
    ) {
      gimp_image_metadata_save_finish($!this, $mime_type, $metadata, $flags, $file, $error);
    }

    method save_prepare (
      Str                   $mime_type,
      GimpMetadataSaveFlags $suggested_flags
    ) {
      gimp_image_metadata_save_prepare($!this, $mime_type, $suggested_flags);
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

    $.convert  .= new( this => self );
    $.grid     .= new( this => self );
    $.metadata .= new( this => self );
  }

  method GIMP::Raw::Definitions::GimpImage
  { $!g-i }

  multi method new ($gimp-image where * ~~ GimpImageAncestry , :$ref = True) {
    return unless $gimp-image;

    my $o = self.bless( :$gimp-image );
    $o.ref if $ref;
    $o;
  }

  method new (
    gint              $height,
    GimpImageBaseType $type
  ) {
    gimp_image_new($!g-i, $height, $type);
  }

  method new_with_precision (
    gint              $height,
    GimpImageBaseType $type,
    GimpPrecision     $precision
  ) {
    gimp_image_new_with_precision($!g-i, $width, $height, $type, $precision);
  }

  method add_hguide (gint      $yposition) {
    gimp_image_add_hguide($!g-i, $yposition);
  }

  method add_sample_point (
    gint      $position_x,
    gint      $position_y
  ) {
    gimp_image_add_sample_point($!g-i, $position_x, $position_y);
  }

  method add_vguide (gint      $xposition) {
    gimp_image_add_vguide($!g-i, $xposition);
  }

  method attach_parasite (
    GimpParasite $parasite
  ) {
    gimp_image_attach_parasite($!g-i, $parasite);
  }

  method clean_all {
    gimp_image_clean_all($!g-i);
  }

  method convert_color_profile (
    GimpColorProfile         $profile,
    GimpColorRenderingIntent $intent,
    gboolean                 $bpc
  ) {
    gimp_image_convert_color_profile($!g-i, $profile, $intent, $bpc);
  }

  method convert_color_profile_from_file (
    GFile                    $file,
    GimpColorRenderingIntent $intent,
    gboolean                 $bpc
  ) {
    gimp_image_convert_color_profile_from_file($!g-i, $file, $intent, $bpc);
  }

  method crop (
    gint      $new_width,
    gint      $new_height,
    gint      $offx,
    gint      $offy
  ) {
    gimp_image_crop($!g-i, $new_width, $new_height, $offx, $offy);
  }

  method delete {
    gimp_image_delete($!g-i);
  }

  method delete_guide (guint     $guide) {
    gimp_image_delete_guide($!g-i, $guide);
  }

  method delete_sample_point (guint     $sample_point) {
    gimp_image_delete_sample_point($!g-i, $sample_point);
  }

  method detach_parasite (
    Str       $name
  ) {
    gimp_image_detach_parasite($!g-i, $name);
  }

  method duplicate {
    gimp_image_duplicate($!g-i);
  }

  method find_next_guide (guint     $guide) {
    gimp_image_find_next_guide($!g-i, $guide);
  }

  method find_next_sample_point (guint     $sample_point) {
    gimp_image_find_next_sample_point($!g-i, $sample_point);
  }

  method flatten {
    gimp_image_flatten($!g-i);
  }

  method flip (GimpOrientationType $flip_type) {
    gimp_image_flip($!g-i, $flip_type);
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

  method get_channel_by_name (
    Str       $name
  ) {
    gimp_image_get_channel_by_name($!g-i, $name);
  }

  method get_channel_by_tattoo (
    guint     $tattoo
  ) {
    gimp_image_get_channel_by_tattoo($!g-i, $tattoo);
  }

  method get_channels (
    gint      $num_channels is rw
  ) {
    gimp_image_get_channels($!g-i, $num_channels);
  }

  method get_color_profile {
    gimp_image_get_color_profile($!g-i);
  }

  method get_colormap (
    gint      $colormap_len is rw,
    gint      $num_colors is rw
  ) {
    gimp_image_get_colormap($!g-i, $colormap_len, $num_colors);
  }

  method get_component_active (
    GimpChannelType $component
  ) {
    gimp_image_get_component_active($!g-i, $component);
  }

  method get_component_visible (
    GimpChannelType $component
  ) {
    gimp_image_get_component_visible($!g-i, $component);
  }

  method get_default_new_layer_mode {
    gimp_image_get_default_new_layer_mode($!g-i);
  }

  method get_effective_color_profile {
    gimp_image_get_effective_color_profile($!g-i);
  }

  method get_exported_file {
    gimp_image_get_exported_file($!g-i);
  }

  method get_file {
    gimp_image_get_file($!g-i);
  }

  method get_floating_sel {
    gimp_image_get_floating_sel($!g-i);
  }

  method get_guide_orientation (guint     $guide) {
    gimp_image_get_guide_orientation($!g-i, $guide);
  }

  method get_guide_position (guint     $guide) {
    gimp_image_get_guide_position($!g-i, $guide);
  }

  method get_height {
    gimp_image_get_height($!g-i);
  }

  method get_id {
    gimp_image_get_id($!g-i);
  }

  method get_imported_file {
    gimp_image_get_imported_file($!g-i);
  }

  method get_item_position (
    GimpItem  $item
  ) {
    gimp_image_get_item_position($!g-i, $item);
  }

  method get_layer_by_name (
    Str       $name
  ) {
    gimp_image_get_layer_by_name($!g-i, $name);
  }

  method get_layer_by_tattoo (
    guint     $tattoo
  ) {
    gimp_image_get_layer_by_tattoo($!g-i, $tattoo);
  }

  method get_layers (
    gint      $num_layers is rw
  ) {
    gimp_image_get_layers($!g-i, $num_layers);
  }

  method get_metadata {
    gimp_image_get_metadata($!g-i);
  }

  method get_name {
    gimp_image_get_name($!g-i);
  }

  method get_parasite (
    Str       $name
  ) {
    gimp_image_get_parasite($!g-i, $name);
  }

  method get_parasite_list {
    gimp_image_get_parasite_list($!g-i);
  }

  method get_precision {
    gimp_image_get_precision($!g-i);
  }

  method get_resolution (
    gdouble   $xresolution is rw,
    gdouble   $yresolution is rw
  ) {
    gimp_image_get_resolution($!g-i, $xresolution, $yresolution);
  }

  method get_sample_point_position (
    guint     $sample_point,
    gint      $position_y is rw
  ) {
    gimp_image_get_sample_point_position($!g-i, $sample_point, $position_y);
  }

  method get_selected_channels (
    gint      $num_channels is rw
  ) {
    gimp_image_get_selected_channels($!g-i, $num_channels);
  }

  method get_selected_drawables (
    gint      $num_drawables is rw
  ) {
    gimp_image_get_selected_drawables($!g-i, $num_drawables);
  }

  method get_selected_layers (
    gint      $num_layers is rw
  ) {
    gimp_image_get_selected_layers($!g-i, $num_layers);
  }

  method get_selected_vectors (
    gint      $num_vectors is rw
  ) {
    gimp_image_get_selected_vectors($!g-i, $num_vectors);
  }

  method get_selection {
    gimp_image_get_selection($!g-i);
  }

  method get_simulation_bpc {
    gimp_image_get_simulation_bpc($!g-i);
  }

  method get_simulation_intent {
    gimp_image_get_simulation_intent($!g-i);
  }

  method get_simulation_profile {
    gimp_image_get_simulation_profile($!g-i);
  }

  method get_tattoo_state {
    gimp_image_get_tattoo_state($!g-i);
  }

  method get_thumbnail (
    gint                   $width,
    gint                   $height,
    GimpPixbufTransparency $alpha
  ) {
    gimp_image_get_thumbnail($!g-i, $width, $height, $alpha);
  }

  method get_thumbnail_data (
    gint      $width is rw,
    gint      $height is rw,
    gint      $bpp is rw
  ) {
    gimp_image_get_thumbnail_data($!g-i, $width, $height, $bpp);
  }

  method get_unit {
    gimp_image_get_unit($!g-i);
  }

  method get_vectors (
    gint      $num_vectors is rw
  ) {
    gimp_image_get_vectors($!g-i, $num_vectors);
  }

  method get_vectors_by_name (
    Str       $name
  ) {
    gimp_image_get_vectors_by_name($!g-i, $name);
  }

  method get_vectors_by_tattoo (
    guint     $tattoo
  ) {
    gimp_image_get_vectors_by_tattoo($!g-i, $tattoo);
  }

  method get_width {
    gimp_image_get_width($!g-i);
  }

  method get_xcf_file {
    gimp_image_get_xcf_file($!g-i);
  }

  method gimp_get_images {
    gimp_get_images($!g-i);
  }

  method gimp_list_images {
    gimp_list_images($!g-i);
  }

  method id_is_valid {
    gimp_image_id_is_valid($!g-i);
  }

  method insert_channel (
    GimpChannel $channel,
    GimpChannel $parent,
    gint        $position
  ) {
    gimp_image_insert_channel($!g-i, $channel, $parent, $position);
  }

  method insert_layer (
    GimpLayer $layer,
    GimpLayer $parent,
    gint      $position
  ) {
    gimp_image_insert_layer($!g-i, $layer, $parent, $position);
  }

  method insert_vectors (
    GimpVectors $vectors,
    GimpVectors $parent,
    gint        $position
  ) {
    gimp_image_insert_vectors($!g-i, $vectors, $parent, $position);
  }

  method is_dirty {
    gimp_image_is_dirty($!g-i);
  }

  method is_valid {
    gimp_image_is_valid($!g-i);
  }

  method list_channels {
    gimp_image_list_channels($!g-i);
  }

  method list_layers {
    gimp_image_list_layers($!g-i);
  }

  method list_selected_channels {
    gimp_image_list_selected_channels($!g-i);
  }

  method list_selected_drawables {
    gimp_image_list_selected_drawables($!g-i);
  }

  method list_selected_layers {
    gimp_image_list_selected_layers($!g-i);
  }

  method list_selected_vectors {
    gimp_image_list_selected_vectors($!g-i);
  }

  method list_vectors {
    gimp_image_list_vectors($!g-i);
  }

  method lower_item (
    GimpItem  $item
  ) {
    gimp_image_lower_item($!g-i, $item);
  }

  method lower_item_to_bottom (
    GimpItem  $item
  ) {
    gimp_image_lower_item_to_bottom($!g-i, $item);
  }

  method merge_down (
    GimpLayer     $merge_layer,
    GimpMergeType $merge_type
  ) {
    gimp_image_merge_down($!g-i, $merge_layer, $merge_type);
  }

  method merge_layer_group (
    GimpLayer $layer_group
  ) {
    gimp_image_merge_layer_group($!g-i, $layer_group);
  }

  method merge_visible_layers (
    GimpMergeType $merge_type
  ) {
    gimp_image_merge_visible_layers($!g-i, $merge_type);
  }

  method pick_color (
    gint             $num_drawables,
    CArray[GimpItem] $drawables,
    gdouble          $x,
    gdouble          $y,
    gboolean         $sample_merged,
    gboolean         $sample_average,
    gdouble          $average_radius,
    GimpRGB          $color
  ) {
    gimp_image_pick_color($!g-i, $num_drawables, $drawables, $x, $y, $sample_merged, $sample_average, $average_radius, $color);
  }

  method pick_correlate_layer (
    gint      $x,
    gint      $y
  ) {
    gimp_image_pick_correlate_layer($!g-i, $x, $y);
  }

  method policy_color_profile (
    gboolean  $interactive
  ) {
    gimp_image_policy_color_profile($!g-i, $interactive);
  }

  method policy_rotate (
    gboolean  $interactive
  ) {
    gimp_image_policy_rotate($!g-i, $interactive);
  }

  method raise_item (
    GimpItem  $item
  ) {
    gimp_image_raise_item($!g-i, $item);
  }

  method raise_item_to_top (
    GimpItem  $item
  ) {
    gimp_image_raise_item_to_top($!g-i, $item);
  }

  method remove_channel (
    GimpChannel $channel
  ) {
    gimp_image_remove_channel($!g-i, $channel);
  }

  method remove_layer (
    GimpLayer $layer
  ) {
    gimp_image_remove_layer($!g-i, $layer);
  }

  method remove_vectors (
    GimpVectors $vectors
  ) {
    gimp_image_remove_vectors($!g-i, $vectors);
  }

  method reorder_item (
    GimpItem  $item,
    GimpItem  $parent,
    gint      $position
  ) {
    gimp_image_reorder_item($!g-i, $item, $parent, $position);
  }

  method resize (
    gint      $new_width,
    gint      $new_height,
    gint      $offx,
    gint      $offy
  ) {
    gimp_image_resize($!g-i, $new_width, $new_height, $offx, $offy);
  }

  method resize_to_layers {
    gimp_image_resize_to_layers($!g-i);
  }

  method rotate (GimpRotationType $rotate_type) {
    gimp_image_rotate($!g-i, $rotate_type);
  }

  method scale (
    gint      $new_width,
    gint      $new_height
  ) {
    gimp_image_scale($!g-i, $new_width, $new_height);
  }

  method select_color (
    GimpChannelOps $operation,
    GimpDrawable   $drawable,
    GimpRGB        $color
  ) {
    gimp_image_select_color($!g-i, $operation, $drawable, $color);
  }

  method select_contiguous_color (
    GimpChannelOps $operation,
    GimpDrawable   $drawable,
    gdouble        $x,
    gdouble        $y
  ) {
    gimp_image_select_contiguous_color($!g-i, $operation, $drawable, $x, $y);
  }

  method select_ellipse (
    GimpChannelOps $operation,
    gdouble        $x,
    gdouble        $y,
    gdouble        $width,
    gdouble        $height
  ) {
    gimp_image_select_ellipse($!g-i, $operation, $x, $y, $width, $height);
  }

  method select_item (
    GimpChannelOps $operation,
    GimpItem       $item
  ) {
    gimp_image_select_item($!g-i, $operation, $item);
  }

  method select_polygon (
    GimpChannelOps $operation,
    gint           $num_segs,
    gdouble        $segs is rw
  ) {
    gimp_image_select_polygon($!g-i, $operation, $num_segs, $segs);
  }

  method select_rectangle (
    GimpChannelOps $operation,
    gdouble        $x,
    gdouble        $y,
    gdouble        $width,
    gdouble        $height
  ) {
    gimp_image_select_rectangle($!g-i, $operation, $x, $y, $width, $height);
  }

  method select_round_rectangle (
    GimpChannelOps $operation,
    gdouble        $x,
    gdouble        $y,
    gdouble        $width,
    gdouble        $height,
    gdouble        $corner_radius_x,
    gdouble        $corner_radius_y
  ) {
    gimp_image_select_round_rectangle($!g-i, $operation, $x, $y, $width, $height, $corner_radius_x, $corner_radius_y);
  }

  method set_color_profile (GimpColorProfile $profile) {
    gimp_image_set_color_profile($!g-i, $profile);
  }

  method set_color_profile_from_file (GFile     $file) {
    gimp_image_set_color_profile_from_file($!g-i, $file);
  }

  method set_colormap (
    Str       $colormap,
    gint      $num_colors
  ) {
    gimp_image_set_colormap($!g-i, $colormap, $num_colors);
  }

  method set_component_active (
    GimpChannelType $component,
    gboolean        $active
  ) {
    gimp_image_set_component_active($!g-i, $component, $active);
  }

  method set_component_visible (
    GimpChannelType $component,
    gboolean        $visible
  ) {
    gimp_image_set_component_visible($!g-i, $component, $visible);
  }

  method set_file (
    GFile     $file
  ) {
    gimp_image_set_file($!g-i, $file);
  }

  method set_metadata (
    GimpMetadata $metadata
  ) {
    gimp_image_set_metadata($!g-i, $metadata);
  }

  method set_resolution (
    gdouble   $xresolution,
    gdouble   $yresolution
  ) {
    gimp_image_set_resolution($!g-i, $xresolution, $yresolution);
  }

  method set_selected_channels (
    gint                $num_channels,
    CArray[GimpChannel] $channels
  ) {
    gimp_image_set_selected_channels($!g-i, $num_channels, $channels);
  }

  method set_selected_layers (
    gint              $num_layers,
    CArray[GimpLayer] $layers
  ) {
    gimp_image_set_selected_layers($!g-i, $num_layers, $layers);
  }

  method set_selected_vectors (
    gint                $num_vectors,
    CArray[GimpVectors] $vectors
  ) {
    gimp_image_set_selected_vectors($!g-i, $num_vectors, $vectors);
  }

  method set_simulation_bpc (gboolean  $bpc) {
    gimp_image_set_simulation_bpc($!g-i, $bpc);
  }

  method set_simulation_intent (GimpColorRenderingIntent $intent) {
    gimp_image_set_simulation_intent($!g-i, $intent);
  }

  method set_simulation_profile (GimpColorProfile $profile) {
    gimp_image_set_simulation_profile($!g-i, $profile);
  }

  method set_simulation_profile_from_file (GFile     $file) {
    gimp_image_set_simulation_profile_from_file($!g-i, $file);
  }

  method set_tattoo_state (
    guint     $tattoo_state
  ) {
    gimp_image_set_tattoo_state($!g-i, $tattoo_state);
  }

  method set_unit (
    GimpUnit  $unit
  ) {
    gimp_image_set_unit($!g-i, $unit);
  }

  method take_selected_channels (
    GList     $channels
  ) {
    gimp_image_take_selected_channels($!g-i, $channels);
  }

  method take_selected_layers (
    GList     $layers
  ) {
    gimp_image_take_selected_layers($!g-i, $layers);
  }

  method take_selected_vectors (
    GList     $vectors
  ) {
    gimp_image_take_selected_vectors($!g-i, $vectors);
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
