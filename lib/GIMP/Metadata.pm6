use v6.c;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::Metadata;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GIMP::Metadata {
  also does GLib::Roles::Object;

  method new {
    my $gimp-metadata = gimp_metadata_new();

    $gimp-metadata ?? self.bless( :$gimp-metadata ) !! Nil
  }

  method deserialize is static {
    my $gimp-metadata = gimp_metadata_deserialize($!g-m);

    $gimp-metadata ?? self.bless( :$gimp-metadata ) !! Nil
  }

  method load_from_file (
    GFile()                 $file,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $gimp-metadata = gimp_metadata_load_from_file($!g-m, $error);
    set_error($error);

    $gimp-metadata ?? self.bless( :$gimp-metadata ) !! Nil
  }

  method add_xmp_history (Str() $state_status) {
    gimp_metadata_add_xmp_history($!g-m, $state_status);
  }

  method duplicate ( :$raw = False ) {
    propReturnObject(
      gimp_metadata_duplicate($!g-m),
      $raw
      |self.getTypePair
    );
  }

  method get_colorspace ( :$enum = False ) {
    my $e = gimp_metadata_get_colorspace($!g-m);
    return $e unless $enum;
    GimpMetadataColorspaceEnum($e);
  }

  method get_guid {
    gimp_metadata_get_guid($!g-m);
  }

  proto method get_resolution (|)

  multi method get_resolution (Int() $unit = GIMP_UNIT_PIXEL) {
    samewith($, $, $unit);
  }
  multi method get_resolution (
          $xres is rw,
          $yres is rw,
    Int() $unit
  ) {
    my gdouble ($x, $y) = 0e0 xx 2;
    my GimpUnit $u      = $unit;

    gimp_metadata_get_resolution($!g-m, $x, $y, $unit);
    ($xres, $yres) = ($x, $y);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_metadata_get_type, $n, $t );
  }

  method is_tag_supported (Str() $tag, Str() $mime_type) is static {
    gimp_metadata_is_tag_supported($tag, $mime_type);
  }

  method save_to_file (
    GimpMetadata            $metadata,
    GFile                   $file,
    CArray[Pointer[GError]] $error
  ) {
    gimp_metadata_save_to_file($!g-m, $file, $error);
  }

  method serialize {
    gimp_metadata_serialize($!g-m);
  }

  method set_bits_per_sample (Int() $bits_per_sample) {
    my gint $b = $bits_per_sample;

    gimp_metadata_set_bits_per_sample($!g-m, $b);
  }

  method set_colorspace (Int() $colorspace) {
    my GimpMetadataColorspace $c = $colorspace;

    gimp_metadata_set_colorspace($!g-m, $c);
  }

  proto method set_from_exif (|)
  { * }

  multi method set_from_exif (
                            @exif_data,
    CArray[Pointer[GError]] $error      = gerror
  ) {
    samewith( Buf.new(@exif_data), @exif_data.elems, $error);
  }
  multi method set_from_exif (
    Buf                     $exif_data,
    CArray[Pointer[GError]] $error      = gerror
  ) {
    samewith( CArray[uint8].new($exif_data), $exif_data.bytes, $error);
  }
  multi method set_from_exif (
    CArray[uint8]           $exif_data,
    Int()                   $exif_data_length,
    CArray[Pointer[GError]] $error
  ) {
    samewith( cast(gpointer, $exif_data), $exit_data_length, $error);
  }
  multi method set_from_exif (
    gpointer                $exif_data,
    Int()                   $exif_data_length,
    CArray[Pointer[GError]] $error
  ) {
    my gint $e = $exif_data_length;

    clear_error;
    my $rv = so gimp_metadata_set_from_exif($!g-m, $exif_data, $e, $error);
    set_error($error);
    $rv;
  }

  # cw: FINISH MULTIS, SEE ABOVE!
  method set_from_iptc (
    Str                     $iptc_data,
    gint                    $iptc_data_length,
    CArray[Pointer[GError]] $error
  ) {
    gimp_metadata_set_from_iptc($!g-m, $iptc_data, $iptc_data_length, $error);
  }

  # cw: FINISH MULTIS, SEE ABOVE!
  method set_from_xmp (
    Str                     $xmp_data,
    gint                    $xmp_data_length,
    CArray[Pointer[GError]] $error
  ) {
    gimp_metadata_set_from_xmp($!g-m, $xmp_data, $xmp_data_length, $error);
  }

  method set_pixel_size (Int() $width, Int() $height) {
    my gint ($w, $h) = ($width, $height);

    gimp_metadata_set_pixel_size($!g-m, $w, $h);
  }

  method set_resolution (
    Num() $xres,
    Num() $yres,
    Int() $unit = GIMP_UNIT_PIXEL
  ) {
    my gdouble  ($x, $y) = ($xres, $yres);
    my GimpUnit  $u      =  $unit;

    gimp_metadata_set_resolution($!g-m, $x, $y, $u);
  }

}
