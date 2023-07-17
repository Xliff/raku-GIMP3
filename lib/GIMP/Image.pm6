
  class Convert {

    method grayscale {
      gimp_image_convert_grayscale($!g-i);
    }

    method indexed (
      GimpImage              $image,
      GimpConvertDitherType  $dither_type,
      GimpConvertPaletteType $palette_type,
      gint                   $num_cols,
      gboolean               $alpha_dither,
      gboolean               $remove_unused,
      Str                    $palette
    ) {
      gimp_image_convert_indexed($!g-i, $dither_type, $palette_type, $num_cols, $alpha_dither, $remove_unused, $palette);
    }

    method precision (
      GimpImage     $image,
      GimpPrecision $precision
    ) {
      gimp_image_convert_precision($!g-i, $precision);
    }

    method rgb {
      gimp_image_convert_rgb($!g-i);
    }

    method set_dither_matrix (
      gint   $height,
      GBytes $matrix
    ) {
      gimp_image_convert_set_dither_matrix($!g-i, $height, $matrix);
    }

  }

  class Grid {

    method get_background_color (GimpRGB   $bgcolor) {
      gimp_image_grid_get_background_color($!g-i, $bgcolor);
    }

    method get_foreground_color (GimpRGB   $fgcolor) {
      gimp_image_grid_get_foreground_color($!g-i, $fgcolor);
    }

    method get_offset (
      gdouble   $xoffset is rw,
      gdouble   $yoffset is rw
    ) {
      gimp_image_grid_get_offset($!g-i, $xoffset, $yoffset);
    }

    method get_spacing (
      gdouble   $xspacing is rw,
      gdouble   $yspacing is rw
    ) {
      gimp_image_grid_get_spacing($!g-i, $xspacing, $yspacing);
    }

    method get_style {
      gimp_image_grid_get_style($!g-i);
    }

    method set_background_color (GimpRGB   $bgcolor) {
      gimp_image_grid_set_background_color($!g-i, $bgcolor);
    }

    method set_foreground_color (GimpRGB   $fgcolor) {
      gimp_image_grid_set_foreground_color($!g-i, $fgcolor);
    }

    method set_offset (
      gdouble   $xoffset,
      gdouble   $yoffset
    ) {
      gimp_image_grid_set_offset($!g-i, $xoffset, $yoffset);
    }

    method set_spacing (
      gdouble   $xspacing,
      gdouble   $yspacing
    ) {
      gimp_image_grid_set_spacing($!g-i, $xspacing, $yspacing);
    }

    method set_style (GimpGridStyle $style) {
      gimp_image_grid_set_style($!g-i, $style);
    }

  }

  class Metadata {
    method load_finish (
      GimpImage             $image,
      Str                   $mime_type,
      GimpMetadata          $metadata,
      GimpMetadataLoadFlags $flags
    ) {
      gimp_image_metadata_load_finish($!g-i, $mime_type, $metadata, $flags);
    }

    method load_prepare (
      GimpImage               $image,
      Str                     $mime_type,
      GFile                   $file,
      CArray[Pointer[GError]] $error
    ) {
      gimp_image_metadata_load_prepare($!g-i, $mime_type, $file, $error);
    }

    method load_thumbnail (CArray[Pointer[GError]] $error) {
      gimp_image_metadata_load_thumbnail($!g-i, $error);
    }

    method save_filter (
      GimpImage               $image,
      Str                     $mime_type,
      GimpMetadata            $metadata,
      GimpMetadataSaveFlags   $flags,
      GFile                   $file,
      CArray[Pointer[GError]] $error
    ) {
      gimp_image_metadata_save_filter($!g-i, $mime_type, $metadata, $flags, $file, $error);
    }

    method save_finish (
      GimpImage               $image,
      Str                     $mime_type,
      GimpMetadata            $metadata,
      GimpMetadataSaveFlags   $flags,
      GFile                   $file,
      CArray[Pointer[GError]] $error
    ) {
      gimp_image_metadata_save_finish($!g-i, $mime_type, $metadata, $flags, $file, $error);
    }

    method save_prepare (
      GimpImage             $image,
      Str                   $mime_type,
      GimpMetadataSaveFlags $suggested_flags
    ) {
      gimp_image_metadata_save_prepare($!g-i, $mime_type, $suggested_flags);
    }
  }

  method get_by_id {
    gimp_image_get_by_id($!g-i);
  }

  method get_colormap (
    GimpImage $image,
    gint      $colormap_len is rw,
    gint      $num_colors is rw
  ) {
    gimp_image_get_colormap($!g-i, $colormap_len, $num_colors);
  }

  method get_id {
    gimp_image_get_id($!g-i);
  }

  method get_metadata {
    gimp_image_get_metadata($!g-i);
  }

  method get_thumbnail (
    GimpImage              $image,
    gint                   $width,
    gint                   $height,
    GimpPixbufTransparency $alpha
  ) {
    gimp_image_get_thumbnail($!g-i, $width, $height, $alpha);
  }

  method get_thumbnail_data (
    GimpImage $image,
    gint      $width is rw,
    gint      $height is rw,
    gint      $bpp is rw
  ) {
    gimp_image_get_thumbnail_data($!g-i, $width, $height, $bpp);
  }

  method gimp_list_images {
    gimp_list_images($!g-i);
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

  method set_colormap (
    GimpImage $image,
    Str       $colormap,
    gint      $num_colors
  ) {
    gimp_image_set_colormap($!g-i, $colormap, $num_colors);
  }

  method set_metadata (
    GimpImage    $image,
    GimpMetadata $metadata
  ) {
    gimp_image_set_metadata($!g-i, $metadata);
  }

  method take_selected_channels (
    GimpImage $image,
    GList     $channels
  ) {
    gimp_image_take_selected_channels($!g-i, $channels);
  }

  method take_selected_layers (
    GimpImage $image,
    GList     $layers
  ) {
    gimp_image_take_selected_layers($!g-i, $layers);
  }

  method take_selected_vectors (
    GimpImage $image,
    GList     $vectors
  ) {
    gimp_image_take_selected_vectors($!g-i, $vectors);
  }

  method attach_parasite (
    GimpImage    $image,
    GimpParasite $parasite
  ) {
    gimp_image_attach_parasite($!g-i, $parasite);
  }

  method clean_all {
    gimp_image_clean_all($!g-i);
  }

  method delete {
    gimp_image_delete($!g-i);
  }

  method detach_parasite (
    GimpImage $image,
    Str       $name
  ) {
    gimp_image_detach_parasite($!g-i, $name);
  }

  method duplicate {
    gimp_image_duplicate($!g-i);
  }

  method flatten {
    gimp_image_flatten($!g-i);
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

  method get_channel_by_name (
    GimpImage $image,
    Str       $name
  ) {
    gimp_image_get_channel_by_name($!g-i, $name);
  }

  method get_channel_by_tattoo (
    GimpImage $image,
    guint     $tattoo
  ) {
    gimp_image_get_channel_by_tattoo($!g-i, $tattoo);
  }

  method get_channels (
    GimpImage $image,
    gint      $num_channels is rw
  ) {
    gimp_image_get_channels($!g-i, $num_channels);
  }

  method get_component_active (
    GimpImage       $image,
    GimpChannelType $component
  ) {
    gimp_image_get_component_active($!g-i, $component);
  }

  method get_component_visible (
    GimpImage       $image,
    GimpChannelType $component
  ) {
    gimp_image_get_component_visible($!g-i, $component);
  }

  method get_default_new_layer_mode {
    gimp_image_get_default_new_layer_mode($!g-i);
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

  method get_height {
    gimp_image_get_height($!g-i);
  }

  method get_imported_file {
    gimp_image_get_imported_file($!g-i);
  }

  method get_item_position (
    GimpImage $image,
    GimpItem  $item
  ) {
    gimp_image_get_item_position($!g-i, $item);
  }

  method get_layer_by_name (
    GimpImage $image,
    Str       $name
  ) {
    gimp_image_get_layer_by_name($!g-i, $name);
  }

  method get_layer_by_tattoo (
    GimpImage $image,
    guint     $tattoo
  ) {
    gimp_image_get_layer_by_tattoo($!g-i, $tattoo);
  }

  method get_layers (
    GimpImage $image,
    gint      $num_layers is rw
  ) {
    gimp_image_get_layers($!g-i, $num_layers);
  }

  method get_name {
    gimp_image_get_name($!g-i);
  }

  method get_parasite (
    GimpImage $image,
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
    GimpImage $image,
    gdouble   $xresolution is rw,
    gdouble   $yresolution is rw
  ) {
    gimp_image_get_resolution($!g-i, $xresolution, $yresolution);
  }

  method get_selected_channels (
    GimpImage $image,
    gint      $num_channels is rw
  ) {
    gimp_image_get_selected_channels($!g-i, $num_channels);
  }

  method get_selected_drawables (
    GimpImage $image,
    gint      $num_drawables is rw
  ) {
    gimp_image_get_selected_drawables($!g-i, $num_drawables);
  }

  method get_selected_layers (
    GimpImage $image,
    gint      $num_layers is rw
  ) {
    gimp_image_get_selected_layers($!g-i, $num_layers);
  }

  method get_selected_vectors (
    GimpImage $image,
    gint      $num_vectors is rw
  ) {
    gimp_image_get_selected_vectors($!g-i, $num_vectors);
  }

  method get_selection {
    gimp_image_get_selection($!g-i);
  }

  method get_tattoo_state {
    gimp_image_get_tattoo_state($!g-i);
  }

  method get_unit {
    gimp_image_get_unit($!g-i);
  }

  method get_vectors (
    GimpImage $image,
    gint      $num_vectors is rw
  ) {
    gimp_image_get_vectors($!g-i, $num_vectors);
  }

  method get_vectors_by_name (
    GimpImage $image,
    Str       $name
  ) {
    gimp_image_get_vectors_by_name($!g-i, $name);
  }

  method get_vectors_by_tattoo (
    GimpImage $image,
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

  method id_is_valid {
    gimp_image_id_is_valid($!g-i);
  }

  method insert_channel (
    GimpImage   $image,
    GimpChannel $channel,
    GimpChannel $parent,
    gint        $position
  ) {
    gimp_image_insert_channel($!g-i, $channel, $parent, $position);
  }

  method insert_layer (
    GimpImage $image,
    GimpLayer $layer,
    GimpLayer $parent,
    gint      $position
  ) {
    gimp_image_insert_layer($!g-i, $layer, $parent, $position);
  }

  method insert_vectors (
    GimpImage   $image,
    GimpVectors $vectors,
    GimpVectors $parent,
    gint        $position
  ) {
    gimp_image_insert_vectors($!g-i, $vectors, $parent, $position);
  }

  method is_dirty {
    gimp_image_is_dirty($!g-i);
  }

  method lower_item (
    GimpImage $image,
    GimpItem  $item
  ) {
    gimp_image_lower_item($!g-i, $item);
  }

  method lower_item_to_bottom (
    GimpImage $image,
    GimpItem  $item
  ) {
    gimp_image_lower_item_to_bottom($!g-i, $item);
  }

  method merge_down (
    GimpImage     $image,
    GimpLayer     $merge_layer,
    GimpMergeType $merge_type
  ) {
    gimp_image_merge_down($!g-i, $merge_layer, $merge_type);
  }

  method merge_layer_group (
    GimpImage $image,
    GimpLayer $layer_group
  ) {
    gimp_image_merge_layer_group($!g-i, $layer_group);
  }

  method merge_visible_layers (
    GimpImage     $image,
    GimpMergeType $merge_type
  ) {
    gimp_image_merge_visible_layers($!g-i, $merge_type);
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

  method pick_color (
    GimpImage        $image,
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
    GimpImage $image,
    gint      $x,
    gint      $y
  ) {
    gimp_image_pick_correlate_layer($!g-i, $x, $y);
  }

  method policy_color_profile (
    GimpImage $image,
    gboolean  $interactive
  ) {
    gimp_image_policy_color_profile($!g-i, $interactive);
  }

  method policy_rotate (
    GimpImage $image,
    gboolean  $interactive
  ) {
    gimp_image_policy_rotate($!g-i, $interactive);
  }

  method raise_item (
    GimpImage $image,
    GimpItem  $item
  ) {
    gimp_image_raise_item($!g-i, $item);
  }

  method raise_item_to_top (
    GimpImage $image,
    GimpItem  $item
  ) {
    gimp_image_raise_item_to_top($!g-i, $item);
  }

  method remove_channel (
    GimpImage   $image,
    GimpChannel $channel
  ) {
    gimp_image_remove_channel($!g-i, $channel);
  }

  method remove_layer (
    GimpImage $image,
    GimpLayer $layer
  ) {
    gimp_image_remove_layer($!g-i, $layer);
  }

  method remove_vectors (
    GimpImage   $image,
    GimpVectors $vectors
  ) {
    gimp_image_remove_vectors($!g-i, $vectors);
  }

  method reorder_item (
    GimpImage $image,
    GimpItem  $item,
    GimpItem  $parent,
    gint      $position
  ) {
    gimp_image_reorder_item($!g-i, $item, $parent, $position);
  }

  method set_component_active (
    GimpImage       $image,
    GimpChannelType $component,
    gboolean        $active
  ) {
    gimp_image_set_component_active($!g-i, $component, $active);
  }

  method set_component_visible (
    GimpImage       $image,
    GimpChannelType $component,
    gboolean        $visible
  ) {
    gimp_image_set_component_visible($!g-i, $component, $visible);
  }

  method set_file (
    GimpImage $image,
    GFile     $file
  ) {
    gimp_image_set_file($!g-i, $file);
  }

  method set_resolution (
    GimpImage $image,
    gdouble   $xresolution,
    gdouble   $yresolution
  ) {
    gimp_image_set_resolution($!g-i, $xresolution, $yresolution);
  }

  method set_selected_channels (
    GimpImage           $image,
    gint                $num_channels,
    CArray[GimpChannel] $channels
  ) {
    gimp_image_set_selected_channels($!g-i, $num_channels, $channels);
  }

  method set_selected_layers (
    GimpImage         $image,
    gint              $num_layers,
    CArray[GimpLayer] $layers
  ) {
    gimp_image_set_selected_layers($!g-i, $num_layers, $layers);
  }

  method set_selected_vectors (
    GimpImage           $image,
    gint                $num_vectors,
    CArray[GimpVectors] $vectors
  ) {
    gimp_image_set_selected_vectors($!g-i, $num_vectors, $vectors);
  }

  method set_tattoo_state (
    GimpImage $image,
    guint     $tattoo_state
  ) {
    gimp_image_set_tattoo_state($!g-i, $tattoo_state);
  }

  method set_unit (
    GimpImage $image,
    GimpUnit  $unit
  ) {
    gimp_image_set_unit($!g-i, $unit);
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

  method unset_active_channel {
    gimp_image_unset_active_channel($!g-i);
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

  method _convert_color_profile (
    GBytes                   $color_profile,
    GimpColorRenderingIntent $intent,
    gboolean                 $bpc
  ) {
    _gimp_image_convert_color_profile($!g-i, $color_profile, $intent, $bpc);
  }



  method convert_color_profile_from_file (
    GFile                    $file,
    GimpColorRenderingIntent $intent,
    gboolean                 $bpc
  ) {
    gimp_image_convert_color_profile_from_file($!g-i, $file, $intent, $bpc);
  }

  method get_simulation_bpc {
    gimp_image_get_simulation_bpc($!g-i);
  }

  method get_simulation_intent {
    gimp_image_get_simulation_intent($!g-i);
  }

  method set_color_profile_from_file (GFile     $file) {
    gimp_image_set_color_profile_from_file($!g-i, $file);
  }

  method set_simulation_bpc (gboolean  $bpc) {
    gimp_image_set_simulation_bpc($!g-i, $bpc);
  }

  method set_simulation_intent (GimpColorRenderingIntent $intent) {
    gimp_image_set_simulation_intent($!g-i, $intent);
  }

  method set_simulation_profile_from_file (GFile     $file) {
    gimp_image_set_simulation_profile_from_file($!g-i, $file);
  }

  method crop (
    gint      $new_width,
    gint      $new_height,
    gint      $offx,
    gint      $offy
  ) {
    gimp_image_crop($!g-i, $new_width, $new_height, $offx, $offy);
  }

  method flip (GimpOrientationType $flip_type) {
    gimp_image_flip($!g-i, $flip_type);
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

  method convert_color_profile (
    GimpColorProfile         $profile,
    GimpColorRenderingIntent $intent,
    gboolean                 $bpc
  ) {
    gimp_image_convert_color_profile($!g-i, $profile, $intent, $bpc);
  }

  method get_color_profile {
    gimp_image_get_color_profile($!g-i);
  }

  method get_effective_color_profile {
    gimp_image_get_effective_color_profile($!g-i);
  }

  method get_simulation_profile {
    gimp_image_get_simulation_profile($!g-i);
  }

  method set_color_profile (GimpColorProfile $profile) {
    gimp_image_set_color_profile($!g-i, $profile);
  }

  method set_simulation_profile (GimpColorProfile $profile) {
    gimp_image_set_simulation_profile($!g-i, $profile);
  }

  method add_hguide (gint      $yposition) {
    gimp_image_add_hguide($!g-i, $yposition);
  }

  method add_vguide (gint      $xposition) {
    gimp_image_add_vguide($!g-i, $xposition);
  }

  method delete_guide (guint     $guide) {
    gimp_image_delete_guide($!g-i, $guide);
  }

  method find_next_guide (guint     $guide) {
    gimp_image_find_next_guide($!g-i, $guide);
  }

  method get_guide_orientation (guint     $guide) {
    gimp_image_get_guide_orientation($!g-i, $guide);
  }

  method get_guide_position (guint     $guide) {
    gimp_image_get_guide_position($!g-i, $guide);
  }

  method add_sample_point (
    gint      $position_x,
    gint      $position_y
  ) {
    gimp_image_add_sample_point($!g-i, $position_x, $position_y);
  }

  method delete_sample_point (guint     $sample_point) {
    gimp_image_delete_sample_point($!g-i, $sample_point);
  }

  method find_next_sample_point (guint     $sample_point) {
    gimp_image_find_next_sample_point($!g-i, $sample_point);
  }

  method get_sample_point_position (
    guint     $sample_point,
    gint      $position_y is rw
  ) {
    gimp_image_get_sample_point_position($!g-i, $sample_point, $position_y);
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
