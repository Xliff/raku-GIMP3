use v6.c;

use GTK::Raw::Types;
use GTK::Raw::Units;

# Registerable Enum

class GIMP::Unit {
  has GimpUnit $!g-u;

  submethod BUILD ( :$gimp-unit ) {
    $!g-u = $gimp-unit if $gimp-unit.defined;
  }

  method GIMP::Raw::Enums::GimpUnit
  { $!g-u }

  method new (
    Str() $identifier,
    Num() $factor,
    Int() $digits,
    Str() $symbol,
    Str() $abbreviation,
    Str() $singular,
    Str() $plural
  ) {
    my gdouble $f = $factor;
    my gint    $d = $digits;

    my $gimp-unit = gimp_unit_new(
      $identifier,
      $f,
      $d,
      $symbol,
      $abbreviation,
      $singular,
      $plural
    );
  }

  method format_string (Str() $format) {
    gimp_unit_format_string($format, $!g-u);
  }

  method get_abbreviation {
    gimp_unit_get_abbreviation($!g-u);
  }

  method get_deletion_flag {
    so gimp_unit_get_deletion_flag($!g-u);
  }

  method get_digits {
    gimp_unit_get_digits($!g-u);
  }

  method get_factor {
    gimp_unit_get_factor($!g-u);
  }

  method get_identifier {
    gimp_unit_get_identifier($!g-u);
  }

  method get_number_of_built_in_units {
    gimp_unit_get_number_of_built_in_units();
  }

  method get_number_of_units {
    gimp_unit_get_number_of_units();
  }

  method get_plural {
    gimp_unit_get_plural($!g-u);
  }

  method get_scaled_digits (Num() $resolution) {
    my gdouble $r = $resolution;

    gimp_unit_get_scaled_digits($!g-u, $r);
  }

  method get_singular {
    gimp_unit_get_singular($!g-u);
  }

  method get_symbol {
    gimp_unit_get_symbol($!g-u);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_unit_get_type, $n, $t );
  }

  method is_metric {
    so gimp_unit_is_metric($!g-u);
  }

  method set_deletion_flag (Int() $deletion_flag) {
    my gboolean $d = $deletion_flag.so.Int;

    gimp_unit_set_deletion_flag($!g-u, $d);
  }

  # cw: Note the unusual order to the parameters in the following methods.
  #     THIS IS DELIBERATE! Thanks.

  method gimp_pixels_to_units (Num() $pixels, Num() $resolution) {
    my gdouble ($p, $r) = ($pixels, $resolution);

    gimp_pixels_to_units($p, $!g-u, $r);
  }

  method to_pixels (Num() $pixels, Num() $resolution) {
    my gdouble ($p, $r) = ($pixels, $resolution);

    gimp_units_to_pixels($p, $!g-u, $r);
  }

  method to_points (Num() $pixels, Num() $resolution) {
    my gdouble ($p, $r) = ($pixels, $resolution);

    gimp_units_to_points($p, $!g-u, $r);
  }
}

our role GIMP::Roles::ParamSpec::Unit {

  method unit (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $allow_pixels,
    Int() $allow_percent,
    Int() $default_value,
    Int() $flags
  ) {
    my gboolean ($p1, $p2) = ($allow_pixels, $allow_percent).map( *.so.Int );

    my GimpUnit    $d = $default_value;
    my GParamFlags $f = $flag;

    my $glib-paramspec = gimp_param_spec_unit(
      $name,
      $nick,
      $blurb,
      $p1,
      $p,
      $d,
      $f
    );

    $glib-paramspec ?? self.bless( :$glib-paramspec ) !! Nil;
  }

  method unit_get_type {
    state ($n, $t);

    unstable_get_type( ::?ROLE.^name, gimp_param_unit_get_type, $n, $t );
  }

}
