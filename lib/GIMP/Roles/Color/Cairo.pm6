use v6.c;

use NativeCall;

use GIMP::Raw::Types;

role GIMP::Roles::Color::Cairo::Context {

  method context { ... }

  method checkerboard_create (
    Int()      $size,
    GimpRGB()  $light,
    GimpRGB()  $dark
              :$raw    = False
  ) {
    my gint $s = $size;

    # cw: May need to use :$create for this.
    propReturnObject(
      gimp_cairo_checkerboard_create(self.context, $s, $light, $dark),
      $raw,
      Cairo::Pattern,
      cairo_pattern_t
    );
  }

  multi method set_source_rgb (GimpRGB() $color) {
    gimp_cairo_set_source_rgb(self.context, $color);
  }

  multi method set_source_rgba (GimpRGB() $color) {
    gimp_cairo_set_source_rgba(self.context, $color);
  }

}

role GIMP::Roles::Color::Cairo::Suface {

  method surface { ... }

  method create_buffer ( :$raw = False ) {
    propReturnObject(
      gimp_cairo_surface_create_buffer(self.surface),
      $raw,
      |GEGL::Buffer.getTypePair
    );
  }

  method get_format ( :$raw = False ) {
    propReturnObject(
      gimp_cairo_surface_get_format(self.surface),
      $raw,
      |Babl.getTypePair
    );
  }

}

### /usr/src/gimp/libgimpcolor/gimpcairo.h

sub gimp_cairo_checkerboard_create (
  cairo_t $cr,
  gint    $size,
  GimpRGB $light,
  GimpRGB $dark
)
  returns cairo_pattern_t
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_cairo_set_source_rgb (
  cairo_t $cr,
  GimpRGB $color
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_cairo_set_source_rgba (
  cairo_t $cr,
  GimpRGB $color
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_cairo_surface_create_buffer (cairo_surface_t $surface)
  returns GeglBuffer
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_cairo_surface_get_format (cairo_surface_t $surface)
  returns Babl
  is      native(gimpcolor)
  is      export
{ * }
