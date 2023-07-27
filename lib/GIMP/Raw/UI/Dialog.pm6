use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GTK::Raw::Enums;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Dialog;

### /usr/src/gimp/libgimpwidgets/gimpdialog.h

sub gimp_dialog_add_button (
  GimpDialog $dialog,
  Str        $button_text,
  gint       $response_id
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_dialog_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_dialogs_show_help_button (gboolean $show)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_dialog_new (
  Str            $title,
  Str            $role,
  GtkWidget      $parent,
  GtkDialogFlags $flags,
                 &help_func (Str, gpointer),
  Str            $help_id,
  Str
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_dialog_run (GimpDialog $dialog)
  returns gint
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_dialog_set_alternative_button_order_from_array (
  GimpDialog   $dialog,
  gint         $n_buttons,
  CArray[gint] $order
)
  is      native(gimpwidgets)
  is      export
{ * }
