use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::PageSelector;

### /usr/src/gimp/libgimpwidgets/gimppageselector.h

sub gimp_page_selector_get_n_pages (GimpPageSelector $selector)
  returns gint
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_get_page_label (
  GimpPageSelector $selector,
  gint             $page_no
)
  returns Str
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_get_page_thumbnail (
  GimpPageSelector $selector,
  gint             $page_no
)
  returns GdkPixbuf
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_get_selected_pages (
  GimpPageSelector $selector,
  gint             $n_selected_pages is rw
)
  returns gint
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_get_selected_range (GimpPageSelector $selector)
  returns Str
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_get_target (GimpPageSelector $selector)
  returns GimpPageSelectorTarget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_new
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_page_is_selected (
  GimpPageSelector $selector,
  gint             $page_no
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_select_all (GimpPageSelector $selector)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_select_page (
  GimpPageSelector $selector,
  gint             $page_no
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_select_range (
  GimpPageSelector $selector,
  Str              $range
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_set_n_pages (
  GimpPageSelector $selector,
  gint             $n_pages
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_set_page_label (
  GimpPageSelector $selector,
  gint             $page_no,
  Str              $label
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_set_page_thumbnail (
  GimpPageSelector $selector,
  gint             $page_no,
  GdkPixbuf        $thumbnail
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_set_target (
  GimpPageSelector       $selector,
  GimpPageSelectorTarget $target
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_unselect_all (GimpPageSelector $selector)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_page_selector_unselect_page (
  GimpPageSelector $selector,
  gint             $page_no
)
  is      native(gimpwidgets)
  is      export
{ * }
