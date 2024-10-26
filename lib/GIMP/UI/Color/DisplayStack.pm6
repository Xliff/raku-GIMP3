use v6.c;

use Method::Also;

use GIMP::Raw::Types;
use GIMP::Raw::UI::Color::DisplayStack;

use GIMP::UI::Color::Display;

use GLib::Roles::Object;
use GLib::Roles::Implementor;

use GIMP::Roles::Signals::UI::Color::DisplayStack;

our subset GimpColorDisplayStackAncestry is export of Mu
  where GimpColorDisplayStack | GObject;

class Gimp::UI::Color::DisplayStack {
  also does GLib::Roles::Object;
  also does GIMP::Roles::Signals::UI::Color::DisplayStack;

  has GimpColorDisplayStack $!gcds is implementor;

  submethod BUILD ( :$gimp-color-stack ) {
    self.setGimpColorDisplayStack($gimp-color-stack) if $gimp-color-stack
  }

  method setGimpColorDisplayStack (GimpColorDisplayStackAncestry $_) {
    my $to-parent;

    $!gcds = do {
      when GimpColorDisplayStack {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorDisplayStack, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GIMP::Raw::Definitions::GimpColorDisplayStack
    is also<GimpColorDisplayStack>
  { $!gcds }

  multi method new (
     $gimp-color-stack where * ~~ GimpColorDisplayStackAncestry,

    :$ref = True
  ) {
    return unless $gimp-color-stack;

    my $o = self.bless( :$gimp-color-stack );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gimp-color-stack = gimp_color_display_stack_new();

    $gimp-color-stack ?? self.bless( :$gimp-color-stack ) !! Nil;
  }

  # Is originally:
  # GimpColorDisplayStack *stack,  GimpColorDisplay *display,  gint position --> void
  method Reordered {
    self.connect-colordisplay-position($!gcds, 'reordered');
  }

  # Is originally:
  # GimpColorDisplayStack *stack,  GimpColorDisplay *display,  gint position --> void
  method Added {
    self.connect-colordisplay-position($!gcds, 'added');
  }

  # Is originally:
  # GimpColorDisplayStack *stack --> void
  method Changed {
    self.connect($!gcds, 'changed');
  }

  # Is originally:
  # GimpColorDisplayStack *stack,  GimpColorDisplay *display --> void
  method Removed {
    self.connect-colordisplay($!gcds);
  }

  method add (GimpColorDisplay() $display) {
    gimp_color_display_stack_add($!gcds, $display);
  }

  method changed {
    gimp_color_display_stack_changed($!gcds);
  }

  method clone {
    gimp_color_display_stack_clone($!gcds);
  }

  method convert_buffer (GeglBuffer() $buffer, GeglRectangle() $area)
    is also<convert-buffer>
  {
    gimp_color_display_stack_convert_buffer($!gcds, $buffer, $area);
  }

  method get_filters ( :$raw = False, :gslist(:$glist) )
    is also<get-filters>
  {
    returnGList(
      gimp_color_display_stack_get_filters($!gcds),
      $raw,
      $glist,
      |GIMP::UI::Color::Display.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gimp_color_display_stack_get_type,
      $n,
      $t
    );
  }

  method remove (GimpColorDisplay() $display) {
    gimp_color_display_stack_remove($!gcds, $display);
  }

  method reorder_down (GimpColorDisplay() $display) is also<reorder-down> {
    gimp_color_display_stack_reorder_down($!gcds, $display);
  }

  method reorder_up (GimpColorDisplay() $display) is also<reorder-up> {
    gimp_color_display_stack_reorder_up($!gcds, $display);
  }

}
