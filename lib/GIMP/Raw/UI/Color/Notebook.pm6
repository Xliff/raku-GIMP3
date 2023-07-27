use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Color::Notebook;

### /usr/src/gimp/libgimpwidgets/gimpcolornotebook.h

sub gimp_color_notebook_get_current_selector (GimpColorNotebook $notebook)
  returns GimpColorSelector
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_notebook_get_notebook (GimpColorNotebook $notebook)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_notebook_get_selectors (GimpColorNotebook $notebook)
  returns GList
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_notebook_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_notebook_set_has_page (
  GimpColorNotebook $notebook,
  GType             $page_type,
  gboolean          $has_page
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_notebook_set_simulation (
  GimpColorNotebook        $notebook,
  GimpColorProfile         $profile,
  GimpColorRenderingIntent $intent,
  gboolean                 $bpc
)
  is      native(gimpwidgets)
  is      export
{ * }
