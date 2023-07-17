use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GDK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

### /usr/src/gimp/libgimp/gimpimage.h

sub gimp_image_get_by_id (gint32 $image_id)
  returns GimpImage
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_colormap (
  GimpImage $image,
  gint      $colormap_len is rw,
  gint      $num_colors is rw
)
  returns Str
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_id (GimpImage $image)
  returns gint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_metadata (GimpImage $image)
  returns GimpMetadata
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_thumbnail (
  GimpImage              $image,
  gint                   $width,
  gint                   $height,
  GimpPixbufTransparency $alpha
)
  returns GdkPixbuf
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_thumbnail_data (
  GimpImage $image,
  gint      $width is rw,
  gint      $height is rw,
  gint      $bpp is rw
)
  returns Str
  is      native(gimp)
  is      export
{ * }

sub gimp_list_images
  returns GList
  is      native(gimp)
  is      export
{ * }

sub gimp_image_is_valid (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_list_channels (GimpImage $image)
  returns GList
  is      native(gimp)
  is      export
{ * }

sub gimp_image_list_layers (GimpImage $image)
  returns GList
  is      native(gimp)
  is      export
{ * }

sub gimp_image_list_selected_channels (GimpImage $image)
  returns GList
  is      native(gimp)
  is      export
{ * }

sub gimp_image_list_selected_drawables (GimpImage $image)
  returns GList
  is      native(gimp)
  is      export
{ * }

sub gimp_image_list_selected_layers (GimpImage $image)
  returns GList
  is      native(gimp)
  is      export
{ * }

sub gimp_image_list_selected_vectors (GimpImage $image)
  returns GList
  is      native(gimp)
  is      export
{ * }

sub gimp_image_list_vectors (GimpImage $image)
  returns GList
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_colormap (
  GimpImage $image,
  Str       $colormap,
  gint      $num_colors
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_metadata (
  GimpImage    $image,
  GimpMetadata $metadata
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_take_selected_channels (
  GimpImage $image,
  GList     $channels
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_take_selected_layers (
  GimpImage $image,
  GList     $layers
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_take_selected_vectors (
  GimpImage $image,
  GList     $vectors
)
  returns uint32
  is      native(gimp)
  is      export
{ * }



### /usr/src/gimp/libgimp/gimpimage_pdb.h

sub _gimp_image_get_colormap (GimpImage $image)
  returns GBytes
  is      native(gimp)
  is      export
{ * }

sub _gimp_image_get_metadata (GimpImage $image)
  returns Str
  is      native(gimp)
  is      export
{ * }

sub _gimp_image_set_colormap (
  GimpImage $image,
  GBytes    $colormap
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub _gimp_image_set_metadata (
  GimpImage $image,
  Str       $metadata_string
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub _gimp_image_thumbnail (
  GimpImage      $image,
  gint           $width,
  gint           $height,
  gint           $actual_width is rw,
  gint           $actual_height is rw,
  gint           $bpp is rw,
  CArray[GBytes] $thumbnail_data
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_attach_parasite (
  GimpImage    $image,
  GimpParasite $parasite
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_clean_all (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_delete (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_detach_parasite (
  GimpImage $image,
  Str       $name
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_duplicate (GimpImage $image)
  returns GimpImage
  is      native(gimp)
  is      export
{ * }

sub gimp_image_flatten (GimpImage $image)
  returns GimpLayer
  is      native(gimp)
  is      export
{ * }

sub gimp_image_floating_sel_attached_to (GimpImage $image)
  returns GimpDrawable
  is      native(gimp)
  is      export
{ * }

sub gimp_image_freeze_channels (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_freeze_layers (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_freeze_vectors (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_base_type (GimpImage $image)
  returns GimpImageBaseType
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_channel_by_name (
  GimpImage $image,
  Str       $name
)
  returns GimpChannel
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_channel_by_tattoo (
  GimpImage $image,
  guint     $tattoo
)
  returns GimpChannel
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_channels (
  GimpImage $image,
  gint      $num_channels is rw
)
  returns CArray[CArray[GimpChannel]]
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_component_active (
  GimpImage       $image,
  GimpChannelType $component
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_component_visible (
  GimpImage       $image,
  GimpChannelType $component
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_default_new_layer_mode (GimpImage $image)
  returns GimpLayerMode
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_exported_file (GimpImage $image)
  returns GFile
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_file (GimpImage $image)
  returns GFile
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_floating_sel (GimpImage $image)
  returns GimpLayer
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_height (GimpImage $image)
  returns gint
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_imported_file (GimpImage $image)
  returns GFile
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_item_position (
  GimpImage $image,
  GimpItem  $item
)
  returns gint
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_layer_by_name (
  GimpImage $image,
  Str       $name
)
  returns GimpLayer
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_layer_by_tattoo (
  GimpImage $image,
  guint     $tattoo
)
  returns GimpLayer
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_layers (
  GimpImage $image,
  gint      $num_layers is rw
)
  returns CArray[CArray[GimpLayer]]
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_name (GimpImage $image)
  returns Str
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_parasite (
  GimpImage $image,
  Str       $name
)
  returns GimpParasite
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_parasite_list (GimpImage $image)
  returns Str
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_precision (GimpImage $image)
  returns GimpPrecision
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_resolution (
  GimpImage $image,
  gdouble   $xresolution is rw,
  gdouble   $yresolution is rw
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_selected_channels (
  GimpImage $image,
  gint      $num_channels is rw
)
  returns CArray[CArray[GimpChannel]]
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_selected_drawables (
  GimpImage $image,
  gint      $num_drawables is rw
)
  returns CArray[CArray[GimpItem]]
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_selected_layers (
  GimpImage $image,
  gint      $num_layers is rw
)
  returns CArray[CArray[GimpLayer]]
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_selected_vectors (
  GimpImage $image,
  gint      $num_vectors is rw
)
  returns CArray[CArray[GimpVectors]]
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_selection (GimpImage $image)
  returns GimpSelection
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_tattoo_state (GimpImage $image)
  returns guint
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_unit (GimpImage $image)
  returns GimpUnit
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_vectors (
  GimpImage $image,
  gint      $num_vectors is rw
)
  returns CArray[CArray[GimpVectors]]
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_vectors_by_name (
  GimpImage $image,
  Str       $name
)
  returns GimpVectors
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_vectors_by_tattoo (
  GimpImage $image,
  guint     $tattoo
)
  returns GimpVectors
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_width (GimpImage $image)
  returns gint
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_xcf_file (GimpImage $image)
  returns GFile
  is      native(gimp)
  is      export
{ * }

sub gimp_get_images (gint $num_images is rw)
  returns CArray[CArray[GimpImage]]
  is      native(gimp)
  is      export
{ * }

sub gimp_image_id_is_valid (gint $image_id)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_insert_channel (
  GimpImage   $image,
  GimpChannel $channel,
  GimpChannel $parent,
  gint        $position
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_insert_layer (
  GimpImage $image,
  GimpLayer $layer,
  GimpLayer $parent,
  gint      $position
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_insert_vectors (
  GimpImage   $image,
  GimpVectors $vectors,
  GimpVectors $parent,
  gint        $position
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_is_dirty (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_lower_item (
  GimpImage $image,
  GimpItem  $item
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_lower_item_to_bottom (
  GimpImage $image,
  GimpItem  $item
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_merge_down (
  GimpImage     $image,
  GimpLayer     $merge_layer,
  GimpMergeType $merge_type
)
  returns GimpLayer
  is      native(gimp)
  is      export
{ * }

sub gimp_image_merge_layer_group (
  GimpImage $image,
  GimpLayer $layer_group
)
  returns GimpLayer
  is      native(gimp)
  is      export
{ * }

sub gimp_image_merge_visible_layers (
  GimpImage     $image,
  GimpMergeType $merge_type
)
  returns GimpLayer
  is      native(gimp)
  is      export
{ * }

sub gimp_image_new (
  gint              $width,
  gint              $height,
  GimpImageBaseType $type
)
  returns GimpImage
  is      native(gimp)
  is      export
{ * }

sub gimp_image_new_with_precision (
  gint              $width,
  gint              $height,
  GimpImageBaseType $type,
  GimpPrecision     $precision
)
  returns GimpImage
  is      native(gimp)
  is      export
{ * }

sub gimp_image_pick_color (
  GimpImage        $image,
  gint             $num_drawables,
  CArray[GimpItem] $drawables,
  gdouble          $x,
  gdouble          $y,
  gboolean         $sample_merged,
  gboolean         $sample_average,
  gdouble          $average_radius,
  GimpRGB          $color
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_pick_correlate_layer (
  GimpImage $image,
  gint      $x,
  gint      $y
)
  returns GimpLayer
  is      native(gimp)
  is      export
{ * }

sub gimp_image_policy_color_profile (
  GimpImage $image,
  gboolean  $interactive
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_policy_rotate (
  GimpImage $image,
  gboolean  $interactive
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_raise_item (
  GimpImage $image,
  GimpItem  $item
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_raise_item_to_top (
  GimpImage $image,
  GimpItem  $item
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_remove_channel (
  GimpImage   $image,
  GimpChannel $channel
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_remove_layer (
  GimpImage $image,
  GimpLayer $layer
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_remove_vectors (
  GimpImage   $image,
  GimpVectors $vectors
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_reorder_item (
  GimpImage $image,
  GimpItem  $item,
  GimpItem  $parent,
  gint      $position
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_component_active (
  GimpImage       $image,
  GimpChannelType $component,
  gboolean        $active
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_component_visible (
  GimpImage       $image,
  GimpChannelType $component,
  gboolean        $visible
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_file (
  GimpImage $image,
  GFile     $file
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_resolution (
  GimpImage $image,
  gdouble   $xresolution,
  gdouble   $yresolution
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_selected_channels (
  GimpImage           $image,
  gint                $num_channels,
  CArray[GimpChannel] $channels
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_selected_layers (
  GimpImage         $image,
  gint              $num_layers,
  CArray[GimpLayer] $layers
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_selected_vectors (
  GimpImage           $image,
  gint                $num_vectors,
  CArray[GimpVectors] $vectors
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_tattoo_state (
  GimpImage $image,
  guint     $tattoo_state
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_unit (
  GimpImage $image,
  GimpUnit  $unit
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_thaw_channels (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_thaw_layers (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_thaw_vectors (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_unset_active_channel (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

### /usr/src/gimp/libgimp/gimpimageselect_pdb.h

sub gimp_image_select_color (
  GimpImage      $image,
  GimpChannelOps $operation,
  GimpDrawable   $drawable,
  GimpRGB        $color
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_select_contiguous_color (
  GimpImage      $image,
  GimpChannelOps $operation,
  GimpDrawable   $drawable,
  gdouble        $x,
  gdouble        $y
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_select_ellipse (
  GimpImage      $image,
  GimpChannelOps $operation,
  gdouble        $x,
  gdouble        $y,
  gdouble        $width,
  gdouble        $height
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_select_item (
  GimpImage      $image,
  GimpChannelOps $operation,
  GimpItem       $item
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_select_polygon (
  GimpImage      $image,
  GimpChannelOps $operation,
  gint           $num_segs,
  gdouble        $segs is rw
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_select_rectangle (
  GimpImage      $image,
  GimpChannelOps $operation,
  gdouble        $x,
  gdouble        $y,
  gdouble        $width,
  gdouble        $height
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_select_round_rectangle (
  GimpImage      $image,
  GimpChannelOps $operation,
  gdouble        $x,
  gdouble        $y,
  gdouble        $width,
  gdouble        $height,
  gdouble        $corner_radius_x,
  gdouble        $corner_radius_y
)
  returns uint32
  is      native(gimp)
  is      export
{ * }



### /usr/src/gimp/libgimp/gimpimagecolorprofile_pdb.h

sub _gimp_image_convert_color_profile (
  GimpImage                $image,
  GBytes                   $color_profile,
  GimpColorRenderingIntent $intent,
  gboolean                 $bpc
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub _gimp_image_get_color_profile (GimpImage $image)
  returns GBytes
  is      native(gimp)
  is      export
{ * }

sub _gimp_image_get_effective_color_profile (GimpImage $image)
  returns GBytes
  is      native(gimp)
  is      export
{ * }

sub _gimp_image_get_simulation_profile (GimpImage $image)
  returns GBytes
  is      native(gimp)
  is      export
{ * }

sub _gimp_image_set_color_profile (
  GimpImage $image,
  GBytes    $color_profile
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub _gimp_image_set_simulation_profile (
  GimpImage $image,
  GBytes    $color_profile
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_convert_color_profile_from_file (
  GimpImage                $image,
  GFile                    $file,
  GimpColorRenderingIntent $intent,
  gboolean                 $bpc
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_simulation_bpc (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_simulation_intent (GimpImage $image)
  returns GimpColorRenderingIntent
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_color_profile_from_file (
  GimpImage $image,
  GFile     $file
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_simulation_bpc (
  GimpImage $image,
  gboolean  $bpc
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_simulation_intent (
  GimpImage                $image,
  GimpColorRenderingIntent $intent
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_simulation_profile_from_file (
  GimpImage $image,
  GFile     $file
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

### /usr/src/gimp/libgimp/gimpimagetransform_pdb.h

sub gimp_image_crop (
  GimpImage $image,
  gint      $new_width,
  gint      $new_height,
  gint      $offx,
  gint      $offy
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_flip (
  GimpImage           $image,
  GimpOrientationType $flip_type
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_resize (
  GimpImage $image,
  gint      $new_width,
  gint      $new_height,
  gint      $offx,
  gint      $offy
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_resize_to_layers (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_rotate (
  GimpImage        $image,
  GimpRotationType $rotate_type
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_scale (
  GimpImage $image,
  gint      $new_width,
  gint      $new_height
)
  returns uint32
  is      native(gimp)
  is      export
{ * }



### /usr/src/gimp/libgimp/gimpimagecolorprofile.h

sub gimp_image_convert_color_profile (
  GimpImage                $image,
  GimpColorProfile         $profile,
  GimpColorRenderingIntent $intent,
  gboolean                 $bpc
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_color_profile (GimpImage $image)
  returns GimpColorProfile
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_effective_color_profile (GimpImage $image)
  returns GimpColorProfile
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_simulation_profile (GimpImage $image)
  returns GimpColorProfile
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_color_profile (
  GimpImage        $image,
  GimpColorProfile $profile
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_set_simulation_profile (
  GimpImage        $image,
  GimpColorProfile $profile
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

### /usr/src/gimp/libgimp/gimpimagemetadata.h

sub gimp_image_metadata_load_finish (
  GimpImage             $image,
  Str                   $mime_type,
  GimpMetadata          $metadata,
  GimpMetadataLoadFlags $flags
)
  is      native(gimp)
  is      export
{ * }

sub gimp_image_metadata_load_prepare (
  GimpImage               $image,
  Str                     $mime_type,
  GFile                   $file,
  CArray[Pointer[GError]] $error
)
  returns GimpMetadata
  is      native(gimp)
  is      export
{ * }

sub gimp_image_metadata_load_thumbnail (
  GFile                   $file,
  CArray[Pointer[GError]] $error
)
  returns GimpImage
  is      native(gimp)
  is      export
{ * }

sub gimp_image_metadata_save_filter (
  GimpImage               $image,
  Str                     $mime_type,
  GimpMetadata            $metadata,
  GimpMetadataSaveFlags   $flags,
  GFile                   $file,
  CArray[Pointer[GError]] $error
)
  returns GimpMetadata
  is      native(gimp)
  is      export
{ * }

sub gimp_image_metadata_save_finish (
  GimpImage               $image,
  Str                     $mime_type,
  GimpMetadata            $metadata,
  GimpMetadataSaveFlags   $flags,
  GFile                   $file,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_metadata_save_prepare (
  GimpImage             $image,
  Str                   $mime_type,
  GimpMetadataSaveFlags $suggested_flags
)
  returns GimpMetadata
  is      native(gimp)
  is      export
{ * }

### /usr/src/gimp/libgimp/gimpimagegrid_pdb.h

sub gimp_image_grid_get_background_color (
  GimpImage $image,
  GimpRGB   $bgcolor
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_grid_get_foreground_color (
  GimpImage $image,
  GimpRGB   $fgcolor
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_grid_get_offset (
  GimpImage $image,
  gdouble   $xoffset is rw,
  gdouble   $yoffset is rw
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_grid_get_spacing (
  GimpImage $image,
  gdouble   $xspacing is rw,
  gdouble   $yspacing is rw
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_grid_get_style (GimpImage $image)
  returns GimpGridStyle
  is      native(gimp)
  is      export
{ * }

sub gimp_image_grid_set_background_color (
  GimpImage $image,
  GimpRGB   $bgcolor
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_grid_set_foreground_color (
  GimpImage $image,
  GimpRGB   $fgcolor
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_grid_set_offset (
  GimpImage $image,
  gdouble   $xoffset,
  gdouble   $yoffset
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_grid_set_spacing (
  GimpImage $image,
  gdouble   $xspacing,
  gdouble   $yspacing
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_grid_set_style (
  GimpImage     $image,
  GimpGridStyle $style
)
  returns uint32
  is      native(gimp)
  is      export
{ * }



### /usr/src/gimp/libgimp/gimpimageconvert_pdb.h

sub gimp_image_convert_grayscale (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_convert_indexed (
  GimpImage              $image,
  GimpConvertDitherType  $dither_type,
  GimpConvertPaletteType $palette_type,
  gint                   $num_cols,
  gboolean               $alpha_dither,
  gboolean               $remove_unused,
  Str                    $palette
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_convert_precision (
  GimpImage     $image,
  GimpPrecision $precision
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_convert_rgb (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_convert_set_dither_matrix (
  gint   $width,
  gint   $height,
  GBytes $matrix
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

### /usr/src/gimp/libgimp/gimpimageguides_pdb.h

sub gimp_image_add_hguide (
  GimpImage $image,
  gint      $yposition
)
  returns guint
  is      native(gimp)
  is      export
{ * }

sub gimp_image_add_vguide (
  GimpImage $image,
  gint      $xposition
)
  returns guint
  is      native(gimp)
  is      export
{ * }

sub gimp_image_delete_guide (
  GimpImage $image,
  guint     $guide
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_find_next_guide (
  GimpImage $image,
  guint     $guide
)
  returns guint
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_guide_orientation (
  GimpImage $image,
  guint     $guide
)
  returns GimpOrientationType
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_guide_position (
  GimpImage $image,
  guint     $guide
)
  returns gint
  is      native(gimp)
  is      export
{ * }



### /usr/src/gimp/libgimp/gimpimageundo_pdb.h

sub gimp_image_undo_disable (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_undo_enable (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_undo_freeze (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_undo_group_end (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_undo_group_start (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_undo_is_enabled (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_undo_thaw (GimpImage $image)
  returns uint32
  is      native(gimp)
  is      export
{ * }



### /usr/src/gimp/libgimp/gimpimagesamplepoints_pdb.h

sub gimp_image_add_sample_point (
  GimpImage $image,
  gint      $position_x,
  gint      $position_y
)
  returns guint
  is      native(gimp)
  is      export
{ * }

sub gimp_image_delete_sample_point (
  GimpImage $image,
  guint     $sample_point
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_image_find_next_sample_point (
  GimpImage $image,
  guint     $sample_point
)
  returns guint
  is      native(gimp)
  is      export
{ * }

sub gimp_image_get_sample_point_position (
  GimpImage $image,
  guint     $sample_point,
  gint      $position_y    is rw
)
  returns gint
  is      native(gimp)
  is      export
{ * }
