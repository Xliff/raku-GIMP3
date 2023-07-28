use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::NumberPairEntry;

use GTK::Entry;

use GLib::Roles::Implementor;

our subset GimpNumberPairEntryAncestry is export of Mu
  where GimpNumberPairEntry | GtkEntryAncestry;

class GIMP::UI::NumberPairEntry is GTK::Entry {
  has GimpNumberPairEntry $!g-npe is implementor;

  submethod BUILD ( :$gimp-pair-entry ) {
    self.setGimpNumberPairEntry($gimp-pair-entry) if $gimp-pair-entry
  }

  method setGimpNumberPairEntry (GimpNumberPairEntryAncestry $_) {
    my $to-parent;

    $!g-npe = do {
      when GimpNumberPairEntry {
        $to-parent = cast(GtkEntry, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpNumberPairEntry, $_);
      }
    }
    self.setGtkEntry($to-parent);
  }

  method GIMP::Raw::Structs::GimpNumberPairEntry
    is also<GimpNumberPairEntry>
  { $!g-npe }

  multi method new (
     $gimp-pair-entry where * ~~ GimpNumberPairEntryAncestry,

    :$ref = True
  ) {
    return unless $gimp-pair-entry;

    my $o = self.bless( :$gimp-pair-entry );
    $o.ref if $ref;
    $o;
  }

  proto method new (|)
  { * }

  multi method new (
    Str()  :$separators            = 'x,:',
    Int()  :$allow_simplification  = True,
    Num()  :min(:$min_valid_value) = 0,
    Num()  :max(:$max_valid_value) = 10000,
    
           *%a
  ) {
    my $o = samewith(
      $separators,
      $allow_simplification,
      $min_valid_value,
      $max_valid_value
    );
    $o.setAttributes(%a) if +%a;
    $o;
  }
  multi method new (
    Str()  $separators,
    Int()  $allow_simplification,
    Num()  $min_valid_value,
    Num()  $max_valid_value
  ) {
    my gboolean  $a      =  $allow_simplification;
    my gdouble  ($n, $x) = ($min_valid_value, $max_valid_value);

    my $gimp-pair-entry = gimp_number_pair_entry_new(
      $separators,
      $a,
      $n,
      $x
    );

    $gimp-pair-entry ?? self.bless( :$gimp-pair-entry ) !! Nil;
  }

  # Type: boolean
  method allow-simplification is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('allow-simplification', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('allow-simplification', $gv);
      }
    );
  }

  # Type: GimpAspectType
  method aspect ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GimpAspectType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('aspect', $gv);
        my $a = $gv.enum;
        return $a unless $enum;
        GimpAspectTypeEnum($a);
      },
      STORE => -> $, Int()  $val is copy {
        $gv.valueFromEnum(GimpAspectType) = $val;
        self.prop_set('aspect', $gv);
      }
    );
  }

  # Type: double
  method default-left-number is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('default-left-number', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('default-left-number', $gv);
      }
    );
  }

  # Type: double
  method default-right-number is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('default-right-number', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('default-right-number', $gv);
      }
    );
  }

  # Type: string
  method default-text is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('default-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('default-text', $gv);
      }
    );
  }

  # Type: double
  method left-number is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('left-number', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('left-number', $gv);
      }
    );
  }

  # Type: double
  method max-valid-value is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-valid-value', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('max-valid-value', $gv);
      }
    );
  }

  # Type: double
  method min-valid-value is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('min-valid-value', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('min-valid-value', $gv);
      }
    );
  }

  # Type: double
  method ratio is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('ratio', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('ratio', $gv);
      }
    );
  }

  # Type: double
  method right-number is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('right-number', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('right-number', $gv);
      }
    );
  }

  # Type: string
  method separators is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('separators', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('separators', $gv);
      }
    );
  }

  # Type: boolean
  method user-override is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('user-override', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('user-override', $gv);
      }
    );
  }

  method numbers-changed {
    self.connect($!g-npe, 'numbers-changed');
  }

  method ratio-changed {
    self.connect($!g-npe, 'ratio-changed');
  }

  method get_aspect is also<get-aspect> {
    gimp_number_pair_entry_get_aspect($!g-npe);
  }

  method get_default_text is also<get-default-text> {
    gimp_number_pair_entry_get_default_text($!g-npe);
  }

  proto method get_default_values (|)
    is also<get-default-values>
  { * }

  multi method get_default_values {
    samewith($, $);
  }
  multi method get_default_values ($left is rw, $right is rw) {
    my gdouble ($l, $r) = 0e0 xx 2;

    gimp_number_pair_entry_get_default_values($!g-npe, $l, $r);
    ($left, $right) = ($l, $r);
  }

  method get_ratio is also<get-ratio> {
    gimp_number_pair_entry_get_ratio($!g-npe);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gimp_number_pair_entry_get_type,
      $n,
      $t
    );
  }

  method get_user_override is also<get-user-override> {
    so gimp_number_pair_entry_get_user_override($!g-npe);
  }

  proto method get_values (|)
    is also<get-values>
  { * }

  multi method get_values {
    samewith($, $);
  }
  multi method get_values ($left is rw, $right is rw) {
    my gdouble ($l, $r) = 0e0 xx 2;
    gimp_number_pair_entry_get_values($!g-npe, $l, $r);
    ($left, $right) = ($l, $r);
  }

  method set_aspect (Int() $aspect) is also<set-aspect> {
    my GimpAspectType $a = $aspect;

    gimp_number_pair_entry_set_aspect($!g-npe, $a);
  }

  method set_default_text (Str() $string) is also<set-default-text> {
    gimp_number_pair_entry_set_default_text($!g-npe, $string);
  }

  method set_default_values (Num() $left, Num() $right)
    is also<set-default-values>
  {
    my gdouble ($l, $r) = ($left, $right);

    gimp_number_pair_entry_set_default_values($!g-npe, $l, $r);
  }

  method set_ratio (Num() $ratio) is also<set-ratio> {
    my gdouble $r = $ratio;

    gimp_number_pair_entry_set_ratio($!g-npe, $r);
  }

  method set_user_override (Int() $user_override)
    is also<set-user-override>
  {
    my gboolean $u = $user_override.so.Int;

    gimp_number_pair_entry_set_user_override($!g-npe, $u);
  }

  method set_values (Num() $left, Num() $right) is also<set-values> {
    my gdouble ($l, $r) = ($left, $right);

    gimp_number_pair_entry_set_values($!g-npe, $l, $r);
  }

}
