use v6.c;

use NativeCall;
use Method::Also;

use GTK::Dialog;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::Dialog;

our subset GimpDialogAncestry is export of Mu
  where GimpDialog | GtkDialogAncestry;

class GIMP::UI::Dialog {
  has GimpDialog $!g-d is implementor;

  submethod BUILD ( :$gimp-dialog ) {
    self.setGimpDialog($gimp-dialog) if $gimp-dialog
  }

  method setGimpDialog (GimpDialogAncestry $_) {
    my $to-parent;

    $!g-d = do {
      when GimpDialog {
        $to-parent = cast(GtkDialog, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpDialog, $_);
      }
    }
    self.setGtkDialog($to-parent);
  }

  method GIMP::Raw::Structs::GimpDialog
    is also<GimpDialog>
  { $!g-d }

  multi method new (
     $gimp-dialog where * ~~ GimpDialogAncestry,

    :$ref = True
  ) {
    return unless $gimp-dialog;

    my $o = self.bless( :$gimp-dialog );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    Str()       $title,
    Str()       $role,
    GtkWidget() $parent,
    Int()       $flags,
                &help_func,
    Str()       $help_id,
                *@text-id,
                *%Text-Id
  ) {
    my GtkDialogFlags $f = $flags;

    my $gimp-dialog = gimp_dialog_new(
      $title,
      $role,
      $parent,
      $f,
      &help_func,
      $help_id,
      Str
    );

    my $o = $gimp-dialog ?? self.bless( :$gimp-dialog ) !! Nil;

    $o.add-buttons(@text-id) if +@text-id;
    $o.add-buttons(%Text-Id) if +%Text-Id;
    $o
  }

  # Type: pointer
  method help-func is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('help-func', $gv);
        $gv.pointer;
      },
      STORE => -> $,  $val is copy {
        $gv.pointer = $val;
        self.prop_set('help-func', $gv);
      }
    );
  }

  # Type: string
  method help-id is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('help-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('help-id', $gv);
      }
    );
  }

  # Type: GtkWidget
  method parent is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'parent does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('parent', $gv);
      }
    );
  }

  method unsetParent
    is also<
      unparent
      removeParent
    >
  {
    self.parent = GtkWidget;
  }

  method add_button (Str() $button_text, Int() $response_id)
    is also<add-button>
  {
    my gint $r = $response_id;

    gimp_dialog_add_button($!g-d, $button_text, $r);
  }

  proto method add_buttons (|)
    is also<add-buttons>
  { * }

  multi method add_buttons ( *%new-buttons ) {
    samewith( %new-buttons );
  }
  multi method add_buttons (  %new-buttons ) {
    self.add_button( .key, .value ) for %new-buttons.pairs;
  }
  multi method add_buttons ( *@text-response ) {
    samewith( @text-response );
  }
  multi method add_buttons ( @text-response ) {
    self.add_button( |$_ ) for @text-response.rotor(2);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_dialog_get_type, $n, $t );
  }

  method show_help_button (Int() $show)
    is static
    is also<show-help-button>
  {
    my gboolean $s = $show.so.Int;

    gimp_dialogs_show_help_button($s);
  }

  method run {
    gimp_dialog_run($!g-d);
  }

  proto method set_alternative_button_order_from_array (|)
    is also<
      set-alternative-button-order-from-array
      set_button_order
      set-button-order
    >
  { * }

  multi method set_alternative_button_order_from_array (@order) {
    samewith( @order.elems, ArrayToCArray(gint, @order) )
  }
  multi method set_alternative_button_order_from_array (
    Int()        $n_buttons,
    CArray[gint] $order
  ) {
    my gint $n = $n_buttons;

    gimp_dialog_set_alternative_button_order_from_array(
      $!g-d,
      $n_buttons,
      $order
    );
  }

}
