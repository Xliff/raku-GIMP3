use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::PageSelector;

use GTK::Box;

use GLib::Roles::Implementor;

our subset GimpPageSelectorAncestry is export of Mu
  where GimpPageSelector | GtkBoxAncestry;

class GIMP::UI::PageSelector is GTK::Box {
  has GimpPageSelector $!g-ps is implementor;

  submethod BUILD ( :$gimp-page-selector ) {
    self.setGimpPageSelector($gimp-page-selector)
      if $gimp-page-selector
  }

  method setGimpPageSelector (GimpPageSelectorAncestry $_) {
    my $to-parent;

    $!g-ps = do {
      when GimpPageSelector {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpPageSelector, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GIMP::Raw::Definitions::GimpPageSelector
    is also<GimpPageSelector>
  { $!g-ps }

  multi method new (
     $gimp-page-selector where * ~~ GimpPageSelectorAncestry,

    :$ref = True
  ) {
    return unless $gimp-page-selector;

    my $o = self.bless( :$gimp-page-selector );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gimp-page-selector = gimp_page_selector_new();

    $gimp-page-selector ?? self.bless( :$gimp-page-selector ) !! Nil;
  }

  # Type: int
  method n-pages is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('n-pages', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('n-pages', $gv);
      }
    );
  }

  # Type: GimpPageSelectorTarget
  method target ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new(
      GLib::Vale.typeFromEnum(GimpPageSelectorTarget)
    );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('target', $gv);
        my $t = $gv.enum;
        return $t unless $enum;
        GimpPageSelectorTargetEnum($t);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GimpPageSelectorTarget) = $val;
        self.prop_set('target', $gv);
      }
    );
  }

  method get_n_pages is also<get-n-pages> {
    gimp_page_selector_get_n_pages($!g-ps);
  }

  method get_page_label (Int() $page_no) is also<get-page-label> {
    my gint $p = $page_no;

    gimp_page_selector_get_page_label($!g-ps, $p);
  }

  method get_page_thumbnail (Int() $page_no) is also<get-page-thumnail> {
    my gint $p = $page_no;

    gimp_page_selector_get_page_thumbnail($!g-ps, $p);
  }

  proto method get_selected_pages (|)
    is also<get-selected-pages>
  { * }

  multi method get_selected_pages {
    samewith($);
  }
  multi method get_selected_pages ($n_selected_pages is rw) {
    my gint $n = 0;

    gimp_page_selector_get_selected_pages($!g-ps, $n);
    $n_selected_pages = $n;
  }

  method get_selected_range is also<get-selected-range> {
    gimp_page_selector_get_selected_range($!g-ps);
  }

  method get_target ( :$enum = True ) is also<get-target> {
    my $t = gimp_page_selector_get_target($!g-ps);
    return $t unless $enum;
    GimpPageSelectorTargetEnum($t);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_page_selector_get_type, $n, $t );
  }

  method page_is_selected (Int() $page_no) is also<page-is-selected> {
    my gint $p = $page_no;

    gimp_page_selector_page_is_selected($!g-ps, $p);
  }

  method select_all is also<select-all> {
    gimp_page_selector_select_all($!g-ps);
  }

  method select_page (Int() $page_no) is also<select-page> {
    my gint $p = $page_no;

    gimp_page_selector_select_page($!g-ps, $p);
  }

  method select_range (Str() $range) is also<select-range> {

    gimp_page_selector_select_range($!g-ps, $range);
  }

  method set_n_pages (Int() $n_pages) is also<set-n-pages> {
    my gint $n = $n_pages;

    gimp_page_selector_set_n_pages($!g-ps, $n);
  }

  method set_page_label (Int() $page_no, Str() $label)
    is also<set-page-label>
  {
    my gint $p = $page_no;

    gimp_page_selector_set_page_label($!g-ps, $p, $label);
  }

  method set_page_thumbnail (Int() $page_no, GdkPixbuf() $thumbnail)
    is also<set-page-thumbnail>
  {
    my gint $p = $page_no;

    gimp_page_selector_set_page_thumbnail($!g-ps, $p, $thumbnail);
  }

  method set_target (Int() $target) is also<set-target> {
    my GimpPageSelectorTarget $t = $target;

    gimp_page_selector_set_target($!g-ps, $t);
  }

  method unselect_all is also<unselect-all> {
    gimp_page_selector_unselect_all($!g-ps);
  }

  method unselect_page (Int() $page_no) is also<unselect-page> {
    my gint $p = $page_no;

    gimp_page_selector_unselect_page($!g-ps, $p);
  }

}
