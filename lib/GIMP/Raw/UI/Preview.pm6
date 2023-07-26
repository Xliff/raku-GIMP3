use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Preview;

### /usr/src/gimp/libgimpwidgets/gimppreview.h

sub gimp_preview_draw (GimpPreview $preview)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_draw_buffer (
  GimpPreview $preview,
  Str         $buffer,
  gint        $rowstride
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_get_area (GimpPreview $preview)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_get_bounds (
  GimpPreview $preview,
  gint        $xmin is rw,
  gint        $ymin is rw,
  gint        $xmax is rw,
  gint        $ymax is rw
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_get_controls (GimpPreview $preview)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_get_default_cursor (GimpPreview $preview)
  returns GdkCursor
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_get_frame (GimpPreview $preview)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_get_grid (GimpPreview $preview)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_get_offsets (
  GimpPreview $preview,
  gint        $xoff is rw,
  gint        $yoff is rw
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_get_position (
  GimpPreview $preview,
  gint        $x is rw,
  gint        $y is rw
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_get_size (
  GimpPreview $preview,
  gint        $width is rw,
  gint        $height is rw
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_get_update (GimpPreview $preview)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_invalidate (GimpPreview $preview)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_set_bounds (
  GimpPreview $preview,
  gint        $xmin,
  gint        $ymin,
  gint        $xmax,
  gint        $ymax
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_set_default_cursor (
  GimpPreview $preview,
  GdkCursor   $cursor
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_set_offsets (
  GimpPreview $preview,
  gint        $xoff,
  gint        $yoff
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_set_size (
  GimpPreview $preview,
  gint        $width,
  gint        $height
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_set_update (
  GimpPreview $preview,
  gboolean    $update
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_transform (
  GimpPreview $preview,
  gint        $src_x,
  gint        $src_y,
  gint        $dest_x is rw,
  gint        $dest_y is rw
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_untransform (
  GimpPreview $preview,
  gint        $src_x,
  gint        $src_y,
  gint        $dest_x is rw,
  gint        $dest_y is rw
)
  is      native(gimpwidgets)
  is      export
{ * }
