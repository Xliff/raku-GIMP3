use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;
use GTK::Raw::Definitions;
use GTK::Raw::Structs;

unit package GIMP::Raw::UI::Int::Store;

### /usr/src/gimp/libgimpwidgets/gimpintstore.h

sub gimp_int_store_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_store_lookup_by_user_data (
  GtkTreeModel $model,
  gpointer     $user_data,
  GtkTreeIter  $iter
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_store_lookup_by_value (
  GtkTreeModel $model,
  gint         $value,
  GtkTreeIter  $iter
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_store_new (
  Str  $first_label,
  gint $first_value,
  Str
)
  returns GtkListStore
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_store_new_array (
  gint        $n_values,
  CArray[Str] $labels
)
  returns GtkListStore
  is      native(gimpwidgets)
  is      export
{ * }

# sub gimp_int_store_new_valist (
#   Str     $first_label,
#   gint    $first_value,
#   va_list $values
# )
#   returns GtkListStore
#   is      native(gimpwidgets)
#   is      export
# { * }
