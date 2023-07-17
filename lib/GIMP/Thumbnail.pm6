use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::Thumbnail;

use GDK::Pixbuf;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GimpThumbnailAncestry is export of Mu
  where GimpThumbnail | GObject;

class GIMP::Thumbnail {
  also does GLib::Roles::Object;

  has GimpThumbnail $!g-t is implementor;

  submethod BUILD ( :$gimp-thumbnail ) {
    self.setGimpThumbnail($gimp-thumbnail) if $gimp-thumbnail
  }

  method setGimpThumbnail (GimpThumbnailAncestry $_) {
    my $to-parent;

    $!g-t = do {
      when GimpThumbnail {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpThumbnail, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GIMP::Raw::Definitions::GimpThumbnail
    is also<GimpThumbnail>
  { $!g-t }

  multi method new (
     $gimp-thumbnail where * ~~ GimpThumbnailAncestry,

    :$ref = True
  ) {
    return unless $gimp-thumbnail;

    my $o = self.bless( :$gimp-thumbnail );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gimp-thumbnail = gimp_thumbnail_new();

    $gimp-thumbnail ?? self.bless( :$gimp-thumbnail ) !! Nil;
  }

  # Type: int64
  method image-filesize is rw  is g-property is also<image_filesize> {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('image-filesize', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int64 = $val;
        self.prop_set('image-filesize', $gv);
      }
    );
  }

  # Type: int
  method image-height is rw  is g-property is also<image_height> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('image-height', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('image-height', $gv);
      }
    );
  }

  # Type: string
  method image-mimetype is rw  is g-property is also<image_mimetype> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('image-mimetype', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('image-mimetype', $gv);
      }
    );
  }

  # Type: int64
  method image-mtime is rw  is g-property is also<image_mtime> {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('image-mtime', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int64 = $val;
        self.prop_set('image-mtime', $gv);
      }
    );
  }

  # Type: int
  method image-num-layers is rw  is g-property is also<image_num_layers> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('image-num-layers', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        self.prop_set('image-num-layers', $gv);
      }
    );
  }

  # Type: GimpThumbState
  method image-state ( :$enum = True)
    is rw
    is g-property
    is also<image_state>
  {
    my $gv = GLib::Value.new( GIMP::Raw::Enums::ThumbState.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('image-state', $gv);
        my $e = $gv.enum;
        return $e unless $enum;
        GimpThumbStateEnum($e);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GimpThumbState) = $val;
        self.prop_set('image-state', $gv);
      }
    );
  }

  # Type: string
  method image-type is rw  is g-property is also<image_type> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('image-type', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('image-type', $gv);
      }
    );
  }

  # Type: string
  method image-uri
    is rw
    is g-property
    is also<
      image_uri
      uri
    >
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('image-uri', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('image-uri', $gv);
      }
    );
  }

  # Type: GimpThumbState
  method thumb-state ( :$enum = True)
    is rw
    is g-property
    is also<thumb_state>
  {
    my $gv = GLib::Value.new( GIMP::Raw::Enums::ThumbState.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('thumb-state', $gv);
        my $e = $gv.enum;
        return $e unless $enum;
        GimpThumbStateEnum($e);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GimpThumbState) = $val;
        self.prop_set('thumb-state', $gv);
      }
    );
  }

  method check_thumb (Int() $size) is also<check-thumb> {
    my GimpThumbSize $s = $size;

    gimp_thumbnail_check_thumb($!g-t, $s);
  }

  method delete_failure is also<delete-failure> {
    gimp_thumbnail_delete_failure($!g-t);
  }

  method delete_others (Int() $size) is also<delete-others> {
    my GimpThumbSize $s = $size;

    gimp_thumbnail_delete_others($!g-t, $size);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_thumbnail_get_type, $n, $t );
  }

  method has_failed is also<has-failed> {
    so gimp_thumbnail_has_failed($!g-t);
  }

  method load_thumb (
    Int()                    $size,
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False
  )
    is also<load-thumb>
  {
    my GimpThumbSize $s = $size;

    propReturnObject(
      ( my $t = gimp_thumbnail_load_thumb($!g-t, $size, $error) ),
      $raw,
      |GDK::Pixbuf.getTypePair
    );

    $t.gist.say;
    $t;
  }

  method peek_image ( :$enum = True ) is also<peek-image> {
    my $e = gimp_thumbnail_peek_image($!g-t);
    return $e unless $enum;
    GimpThumbStateEnum($e)
  }

  method peek_thumb (Int() $size, :$enum = True) is also<peek-thumb> {
    my GimpThumbSize $s = $size;

    my $e = gimp_thumbnail_peek_thumb($!g-t, $size);
    return $e unless $enum;
    GimpThumbStateEnum($e)
  }

  method save_failure (
    Str()                   $software,
    CArray[Pointer[GError]] $error
  )
    is also<save-failure>
  {
    clear_error;
    my $rv = so gimp_thumbnail_save_failure($!g-t, $software, $error);
    set_error($error);
    $rv;
  }

  method save_thumb (
    GdkPixbuf()             $pixbuf,
    Str()                   $software,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<save-thumb>
  {
    clear_error;
    my $rv = so gimp_thumbnail_save_thumb($!g-t, $pixbuf, $software, $error);
    set_error($error);
    $rv;
  }

  method save_thumb_local (
    GdkPixbuf()             $pixbuf,
    Str()                   $software,
    CArray[Pointer[GError]] $error      = gerror
  )
    is also<save-thumb-local>
  {
    clear_error;
    my $rv = so gimp_thumbnail_save_thumb_local(
      $!g-t,
      $pixbuf,
      $software,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_filename (
    Str()                   $filename,
    CArray[Pointer[GError]] $error      = gerror
  )
    is also<set-filename>
  {
    clear_error;
    my $rv = so gimp_thumbnail_set_filename($!g-t, $filename, $error);
    set_error($error);
    $rv;
  }

  method set_from_thumb (
    Str()                   $filename,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<set-from-thumb>
  {
    clear_error;
    my $rv = so gimp_thumbnail_set_from_thumb($!g-t, $filename, $error);
    set_error($error);
    $rv;
  }

  method set_uri (Str() $uri) is also<set-uri> {
    so gimp_thumbnail_set_uri($!g-t, $uri);
  }

  method debug {
    $!g-t.debug;
  }

}
