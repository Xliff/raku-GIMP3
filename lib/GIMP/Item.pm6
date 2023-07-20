use v6.c;

use GIMP::Raw::Types;
use GIMP::Raw::Item;

use GLib::GList;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GIMP::Item {
  also does GLib::Roles::Object;

  has GimpItem $!g-i is implementor;

  method get_by_id (Int() $id) {
    my $gimp-item = gimp_item_get_by_id($id);

    $gimp-item ?? self.bless( :$gimp-item ) !! Nil;
  }

  method attach_parasite (GimpParasite() $parasite) {
    gimp_item_attach_parasite($!g-i, $parasite);
  }

  method delete {
    gimp_item_delete($!g-i);
  }

  method detach_parasite (Str() $name, :$raw = False) {
    propReturnObject(
      gimp_item_detach_parasite($!g-i, $name),
      $raw,
      |GIMP::Parasite.getTypeName
    );
  }

  method get_id {
    gimp_item_get_id($!g-i);
  }

  method get_children ($num_children is rw, :$raw = False, :$carray = False) {
    my gint $n = 0;

    my $kl = gimp_item_get_children($!g-i, $n);
    $num_children = $n;
    return $kl if $raw && $carray;
    $kl = CArrayToArray( ppr($kl) );
    return $kl if $raw;
    $kl.map({ GIMP::Item.new($_) });
  }

  method get_color_tag ( :$enum = True ) {
    my $t = gimp_item_get_color_tag($!g-i);
    return $t unless $enum;
    GimpColorTagEnum($t);
  }

  method get_expanded {
    so gimp_item_get_expanded($!g-i);
  }

  method get_image ( :$raw = False ) {
    propReturnObject(
      gimp_item_get_image($!g-i),
      $raw,
      |GIMP::Image.getTypePair
    );
  }

  method get_lock_content {
    so gimp_item_get_lock_content($!g-i);
  }

  method get_lock_position {
    so gimp_item_get_lock_position($!g-i);
  }

  method get_lock_visibility {
    so gimp_item_get_lock_visibility($!g-i);
  }

  method get_name {
    gimp_item_get_name($!g-i);
  }

  method get_parasite (Str() $name, :$raw = False) {
    propReturnObject(
      gimp_item_get_parasite($!g-i, $name),
      $raw,
      |GIMP::Parasite.getTypePair
    );
  }

  method get_parasite_list {
    CArrayToArray( gimp_item_get_parasite_list($!g-i) );
  }

  method get_parent ( :$raw = False ) {
    propReturnObject(
      gimp_item_get_parent($!g-i),
      $raw,
      |self.getTypePair
    );
  }

  method get_tattoo {
    gimp_item_get_tattoo($!g-i);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_item_get_type, $n, $t );
  }

  method get_visible {
    so gimp_item_get_visible($!g-i);
  }

  method id_is_channel {
    so gimp_item_id_is_channel($!g-i);
  }

  method id_is_drawable {
    so gimp_item_id_is_drawable($!g-i);
  }

  method id_is_layer {
    so gimp_item_id_is_layer($!g-i);
  }

  method id_is_layer_mask {
    so gimp_item_id_is_layer_mask($!g-i);
  }

  method id_is_selection {
    so gimp_item_id_is_selection($!g-i);
  }

  method id_is_text_layer {
    so gimp_item_id_is_text_layer($!g-i);
  }

  method id_is_valid {
    so gimp_item_id_is_valid($!g-i);
  }

  method id_is_vectors {
    so gimp_item_id_is_vectors($!g-i);
  }

  method is_channel {
    so gimp_item_is_channel($!g-i);
  }

  method is_drawable {
    so gimp_item_is_drawable($!g-i);
  }

  method is_group {
    so gimp_item_is_group($!g-i);
  }

  method is_layer {
    so gimp_item_is_layer($!g-i);
  }

  method is_layer_mask {
    so gimp_item_is_layer_mask($!g-i);
  }

  method is_selection {
    so gimp_item_is_selection($!g-i);
  }

  method is_text_layer {
    so gimp_item_is_text_layer($!g-i);
  }

  method is_valid {
    so gimp_item_is_valid($!g-i);
  }

  method is_vectors {
    so gimp_item_is_vectors($!g-i);
  }

  method list_children ( :$raw = False, :$glist = False ) {
    returnGList(
      gimp_item_list_children($!g-i),
      $raw,
      $glist,
      |self.getTypePair
    );
  }

  method set_color_tag (Int() $color_tag) {
    my GimpColorTag $c = $color_tag;

    gimp_item_set_color_tag($!g-i, $color_tag);
  }

  method set_expanded (Int() $expanded) {
    my gboolean $e = $expanded.so.Int;

    gimp_item_set_expanded($!g-i, $e);
  }

  method set_lock_content (Int() $lock_content) {
    my gboolean $l = $lock_content.so.Int;

    gimp_item_set_lock_content($!g-i, $l);
  }

  method set_lock_position (Int() $lock_position) {
    my gboolean $l = $lock_position.so.Int;

    gimp_item_set_lock_position($!g-i, $l);
  }

  method set_lock_visibility (Int() $lock_visibility) {
    my gboolean $l = $lock_visibility.so.Int;

    gimp_item_set_lock_visibility($!g-i, $l);
  }

  method set_name (Str() $name) {
    gimp_item_set_name($!g-i, $name);
  }

  method set_tattoo (Int() $tattoo) {
    my guint $t = $tattoo;

    gimp_item_set_tattoo($!g-i, $t);
  }

  method set_visible (Int() $visible) {
    my gboolean $v = $visible.so.Int;

    gimp_item_set_visible($!g-i, $v);
  }

}
