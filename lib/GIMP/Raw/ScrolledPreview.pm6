use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GTK::Raw::Enums;
use GDK::Raw::Structs;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::ScrolledPreview;

### /usr/src/gimp/libgimpwidgets/gimpscrolledpreview.h

sub gimp_scrolled_preview_freeze (GimpScrolledPreview $preview)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_scrolled_preview_get_adjustments (
  GimpScrolledPreview   $preview,
  GtkAdjustment         $hadj     is rw,
  GtkAdjustment         $vadj     is rw
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_scrolled_preview_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_scroll_adjustment_values (
  GdkEventScroll $sevent,
  GtkAdjustment  $hadj,
  GtkAdjustment  $vadj,
  gdouble        $hvalue is rw,
  gdouble        $vvalue is rw
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_scrolled_preview_set_policy (
  GimpScrolledPreview $preview,
  GtkPolicyType       $hscrollbar_policy,
  GtkPolicyType       $vscrollbar_policy
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_scrolled_preview_set_position (
  GimpScrolledPreview $preview,
  gint                $x,
  gint                $y
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_scrolled_preview_thaw (GimpScrolledPreview $preview)
  is      native(gimpwidgets)
  is      export
{ * }
