use v6.c;

use GIMP::Raw::Types;

use Babl;
use GEGL::Buffer;

role GIMP::Roles::Color::Pixbuf {

  # if ::?CLASS !=:= Any {
  #   die X::GLib::InvalidType.new(
  #     message => "GIMP::Roles::Color::Pixbuf cab only be applied` to a {
  #                 '' }GDK::Pixbuf-compatible object!"
  #   }
  # }

  method GdkPixbuf { ... }

  method create_buffer {
    propReturnObject(
      gimp_pixbuf_create_buffer(self.GdkPixbuf),
      $raw,
      |GEGL::Buffer.getTypePair
    );
  }

  method get_format ( :$raw = False ) {
    propReturnObject(
      gimp_pixbuf_get_format(self.GdkPixbuf),
      $raw,
      |Babl.getTypePair
    )
  }

  method get_icc_profile (Int() $length) {
    my gsize $l = $length;

    gimp_pixbuf_get_icc_profile(self.GdkPixbuf, $l);
  }

}

### /usr/src/gimp/libgimpcolor/gimppixbuf.h

sub gimp_pixbuf_create_buffer (GdkPixbuf $pixbuf)
  returns GeglBuffer
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_pixbuf_get_format (GdkPixbuf $pixbuf)
  returns Babl
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_pixbuf_get_icc_profile (
  GdkPixbuf $pixbuf,
  gsize     $length
)
  returns guint8
  is      native(gimpcolor)
  is      export
{ * }
