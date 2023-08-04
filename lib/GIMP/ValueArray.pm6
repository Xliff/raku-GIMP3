use v6.c;

use GIMP::Raw::Types;
use GIMP::Raw::ValueArray;

use GLib::Roles::Implementor;

# BOXED

class GIMP::ValueArray {
  has GimpValueArray $!g-va is implementor;

  submethod BUILD ( :$gimp-value-array ) {
    $!g-va = $gimp-value-array if $gimp-value-array;
  }

  method GIMP::Raw::Definitions::GimpValueArray
  { $!g-va }

  method new (Int() $preallocated = 1) {
    my gint $p = $preallocated;

    my $gimp-value-array = gimp_value_array_new($p);

    $gimp-value-array ?? self.bless( :$gimp-value-array ) !! Nil;
  }

  proto method new_from_values (|)
  { * }

  multi method new_from_values (@values) {
    samewith(
      GLib::Roles::TypedBuffer[GValue].new(@values).p,
      @values.elems
    );
  }
  multi method new_from_values (gpointer $values, Int() $n_values) {
    my gint $n = $n_values;

    my $gimp-value-array = gimp_value_array_new_from_values($values, $n);

    $gimp-value-array ?? self.bless( :$gimp-value-array ) !! Nil;
  }

  method append (GValue() $value) {
    gimp_value_array_append($!g-va, $value);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gimp_value_array_copy($!g-va),
      $raw,
      |self.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_value_array_get_type, $n, $t );
  }

  method index (Int() $index, :$raw = False) {
    propReturnObject(
      gimp_value_array_index($!g-va, $index),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method insert (Int() $index, GValue() $value) {
    my gint $i = $index;

    gimp_value_array_insert($!g-va, $i, $value);
  }

  method length {
    gimp_value_array_length($!g-va);
  }

  method prepend (GValue() $value) {
    gimp_value_array_prepend($!g-va, $value);
  }

  method ref {
    gimp_value_array_ref($!g-va);
    self
  }

  method remove (Int() $index) {
    my gint $i = $index;

    gimp_value_array_remove($!g-va, $i);
  }

  method truncate (Int() $n_values) {
    my gint $n = $n_values;

    gimp_value_array_truncate($!g-va, $n);
  }

  method unref {
    gimp_value_array_unref($!g-va);
  }

}

class GIMP::ParamSpec {

  method value_array (
    Str          $name,
    Str          $nick,
    Str          $blurb,
    GParamSpec() $element_spec,
    Int()        $flags
  ) {
    my GParamFlags $f = $flags;

    gimp_param_spec_value_array($name, $nick, $blurb, $element_spec, $f);
  }

  method value_array_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, gimp_param_value_array_get_type(), $n, $t );
  }

}
