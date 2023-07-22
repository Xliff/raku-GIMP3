use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Browser;

### /usr/src/gimp/libgimpwidgets/gimpbrowser.h

sub gimp_browser_add_search_types (
  GimpBrowser    $browser,
  CArray[uint64] $nt-args
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_browser_get_left_vbox (GimpBrowser $browser)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_browser_get_right_vbox (GimpBrowser $browser)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_browser_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_browser_new
  returns GimpBrowser
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_browser_set_search_summary (
  GimpBrowser $browser,
  Str         $summary
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_browser_set_widget (
  GimpBrowser $browser,
  GtkWidget   $widget
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_browser_show_message (
  GimpBrowser $browser,
  Str         $message
)
  is      native(gimpwidgets)
  is      export
{ * }
