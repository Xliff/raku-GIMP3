use v6.c;

use NativeCall;
use Method::Also;

use GIMP::Raw::Types;
use GIMP::Raw::UI::Int::RadioFrame;

use GIMP::UI::Frame;

our subset GimpIntRadioFrameAncestry is export of Mu
  where GimpIntRadioFrame | GimpFrameAncestry;

class GIMP::UI::Int::RadioFrame is GIMP::UI::Frame {
  has GimpIntRadioFrame $!girf is implementor;

  submethod BUILD ( :$gimp-int-rf ) {
    self.setGimpIntRadioFrame($gimp-int-rf) if $gimp-int-rf
  }

  method setGimpIntRadioFrame (GimpIntRadioFrameAncestry $_) {
    my $to-parent;

    $!girf = do {
      when GimpIntRadioFrame {
        $to-parent = cast(GimpFrame, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpIntRadioFrame, $_);
      }
    }
    self.setGimpFrame($to-parent);
  }

  method GIMP::Raw::Definitions::GimpIntRadioFrame
    is also<GimpIntRadioFrame>
  { $!girf }

  multi method new (
     $gimp-int-rf where * ~~ GimpIntRadioFrameAncestry,

    :$ref = True
  ) {
    return unless $gimp-int-rf;

    my $o = self.bless( :$gimp-int-rf );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $label, Int() $first_value) {
    my $gimp-int-rf = gimp_int_radio_frame_new($label, $first_value, Str);

    $gimp-int-rf ?? self.bless( :$gimp-int-rf ) !! Nil;
  }

  proto method new_array (|)
    is also<new-array>
  { * }

  multi method new_array (@labels) {
    samewith( ArrayToCArray(Str, @labels) );
  }
  multi method new_array (CArray[Str] $labels) {
    my $gimp-int-rf = gimp_int_radio_frame_new_array($labels);

    $gimp-int-rf ?? self.bless( :$gimp-int-rf ) !! Nil;
  }

  method new_from_store (Str() $title, GimpIntStore() $store)
    is also<new-from-store>
  {
    my $gimp-int-rf = gimp_int_radio_frame_new_from_store($title, $store);

    $gimp-int-rf ?? self.bless( :$gimp-int-rf ) !! Nil;
  }

  method append (Int() $column, Int() $value) {
    my gint ($c, $v) = ($column, $value);

    gimp_int_radio_frame_append($!girf, $c, $v, -1);
  }

  method get_active is also<get-active> {
    gimp_int_radio_frame_get_active($!girf);
  }

  method get_active_user_data (gpointer $user_data)
    is also<get-active-user-data>
  {
    gimp_int_radio_frame_get_active_user_data($!girf, $user_data);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_int_radio_frame_get_type, $n, $t );
  }

  method prepend (Int() $column, Int() $value) {
    my gint ($c, $v) = ($column, $value);

    gimp_int_radio_frame_prepend($!girf, $c, $v, -1);
  }

  method set_active (Int() $value) is also<set-active> {
    my gint $v = $value;

    gimp_int_radio_frame_set_active($!girf, $v);
  }

  method set_active_by_user_data (gpointer $user_data)
    is also<set-active-by-user-data>
  {
    gimp_int_radio_frame_set_active_by_user_data($!girf, $user_data);
  }

  method set_sensitivity (
             &func,
    gpointer $data,
             &destroy = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<set-sensitivity>
  {
    gimp_int_radio_frame_set_sensitivity($!girf, &func, $data, &destroy);
  }

}
