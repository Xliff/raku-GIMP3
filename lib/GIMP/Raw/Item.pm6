use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::Item;

### /usr/src/gimp/libgimp/gimpitem.h

sub gimp_item_get_by_id (gint32 $item_id)
  returns GimpItem
  is      native(gimp)
  is      export
{ * }

sub gimp_item_get_id (GimpItem $item)
  returns gint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_is_channel (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_is_drawable (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_is_layer (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_is_layer_mask (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_is_selection (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_is_text_layer (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_is_valid (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_is_vectors (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_list_children (GimpItem $item)
  returns GList
  is      native(gimp)
  is      export
{ * }



### /usr/src/gimp/libgimp/gimpitem_pdb.h

sub gimp_item_attach_parasite (
  GimpItem     $item,
  GimpParasite $parasite
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_delete (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_detach_parasite (
  GimpItem $item,
  Str      $name
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_get_children (
  GimpItem $item,
  gint     $num_children is rw
)
  returns CArray[CArray[GimpItem]]
  is      native(gimp)
  is      export
{ * }

sub gimp_item_get_color_tag (GimpItem $item)
  returns GimpColorTag
  is      native(gimp)
  is      export
{ * }

sub gimp_item_get_expanded (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_get_image (GimpItem $item)
  returns GimpImage
  is      native(gimp)
  is      export
{ * }

sub gimp_item_get_lock_content (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_get_lock_position (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_get_lock_visibility (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_get_name (GimpItem $item)
  returns Str
  is      native(gimp)
  is      export
{ * }

sub gimp_item_get_parasite (
  GimpItem $item,
  Str      $name
)
  returns GimpParasite
  is      native(gimp)
  is      export
{ * }

sub gimp_item_get_parasite_list (GimpItem $item)
  returns Str
  is      native(gimp)
  is      export
{ * }

sub gimp_item_get_parent (GimpItem $item)
  returns GimpItem
  is      native(gimp)
  is      export
{ * }

sub gimp_item_get_tattoo (GimpItem $item)
  returns guint
  is      native(gimp)
  is      export
{ * }

sub gimp_item_get_visible (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_id_is_channel (gint $item_id)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_id_is_drawable (gint $item_id)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_id_is_layer (gint $item_id)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_id_is_layer_mask (gint $item_id)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_id_is_selection (gint $item_id)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_id_is_text_layer (gint $item_id)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_id_is_valid (gint $item_id)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_id_is_vectors (gint $item_id)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_is_group (GimpItem $item)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_set_color_tag (
  GimpItem     $item,
  GimpColorTag $color_tag
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_set_expanded (
  GimpItem $item,
  gboolean $expanded
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_set_lock_content (
  GimpItem $item,
  gboolean $lock_content
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_set_lock_position (
  GimpItem $item,
  gboolean $lock_position
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_set_lock_visibility (
  GimpItem $item,
  gboolean $lock_visibility
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_set_name (
  GimpItem $item,
  Str      $name
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_set_tattoo (
  GimpItem $item,
  guint    $tattoo
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_item_set_visible (
  GimpItem $item,
  gboolean $visible
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

### Manual addition

sub gimp_item_get_type
  returns GType
  is      native(gimp)
  is      export
{ * }
