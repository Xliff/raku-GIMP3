use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::Item;

use GLib::GList;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GimpItemAncestry is export of Mu
  where GimpItem | GObject;

class GIMP::Item {
  also does GLib::Roles::Object;

  has GimpItem $!g-i is implementor;
  
  submethod BUILD ( :$gimp-item ) {
    self.setGimpItem($gimp-item) if $gimp-item
  }

  method setGimpItem (GimpItemAncestry $_) {
    my $to-parent;

    $!g-i = do {
      when GimpItem {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpItem, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GIMP::Raw::Definitions::GimpItem
    is also<GimpItem>
  { $!g-i }

  multi method new ($gimp-item where * ~~ GimpItemAncestry , :$ref = True) {
    return unless $gimp-item;

    my $o = self.bless( :$gimp-item );
    $o.ref if $ref;
    $o;
  }

  method color_tag is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_color_tag    },
      STORE => -> $, \v { self.set_color_tag(v) }
  }

  method expanded is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_expanded    },
      STORE => -> $, \v { self.set_expanded(v) }
  }

  method lock_content is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_lock_content    },
      STORE => -> $, \v { self.set_lock_content(v) }
  }

  method lock_position is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_lock_position    },
      STORE => -> $, \v { self.set_lock_position(v) }
  }

  method lock_visibility is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_lock_visibility    },
      STORE => -> $, \v { self.set_lock_visibility(v) }
  }

  method name is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_name    },
      STORE => -> $, \v { self.set_name(v) }
  }

  method tattoo is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_tattoo    },
      STORE => -> $, \v { self.set_tattoo(v) }
  }

  method visible is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_visible    },
      STORE => -> $, \v { self.set_visible(v) }
  }

  method get_by_id (Int() $id) is also<get-by-id> {
    my $gimp-item = gimp_item_get_by_id($id);

    $gimp-item ?? self.bless( :$gimp-item ) !! Nil;
  }

  method attach_parasite (GimpParasite() $parasite) is also<attach-parasite> {
    gimp_item_attach_parasite($!g-i, $parasite);
  }

  method delete {
    gimp_item_delete($!g-i);
  }

  method detach_parasite (Str() $name, :$raw = False)
    is also<detach-parasite>
  {
    propReturnObject(
      gimp_item_detach_parasite($!g-i, $name),
      $raw,
      |GIMP::Parasite.getTypeName
    );
  }

  method get_id is also<get-id> {
    gimp_item_get_id($!g-i);
  }

  method get_children ($num_children is rw, :$raw = False, :$carray = False)
    is also<get-children>
  {
    my gint $n = 0;

    my $kl = gimp_item_get_children($!g-i, $n);
    $num_children = $n;
    return $kl if $raw && $carray;
    $kl = CArrayToArray( ppr($kl) );
    return $kl if $raw;
    $kl.map({ GIMP::Item.new($_) });
  }

  method get_color_tag ( :$enum = True ) is also<get-color-tag> {
    my $t = gimp_item_get_color_tag($!g-i);
    return $t unless $enum;
    GimpColorTagEnum($t);
  }

  method get_expanded is also<get-expanded> {
    so gimp_item_get_expanded($!g-i);
  }

  method get_image ( :$raw = False ) is also<get-image> {
    propReturnObject(
      gimp_item_get_image($!g-i),
      $raw,
      |GIMP::Image.getTypePair
    );
  }

  method get_lock_content is also<get-lock-content> {
    so gimp_item_get_lock_content($!g-i);
  }

  method get_lock_position is also<get-lock-position> {
    so gimp_item_get_lock_position($!g-i);
  }

  method get_lock_visibility is also<get-lock-visibility> {
    so gimp_item_get_lock_visibility($!g-i);
  }

  method get_name is also<get-name> {
    gimp_item_get_name($!g-i);
  }

  method get_parasite (Str() $name, :$raw = False) is also<get-parasite> {
    propReturnObject(
      gimp_item_get_parasite($!g-i, $name),
      $raw,
      |GIMP::Parasite.getTypePair
    );
  }

  method get_parasite_list is also<get-parasite-list> {
    CArrayToArray( gimp_item_get_parasite_list($!g-i) );
  }

  method get_parent ( :$raw = False ) is also<get-parent> {
    propReturnObject(
      gimp_item_get_parent($!g-i),
      $raw,
      |self.getTypePair
    );
  }

  method get_tattoo is also<get-tattoo> {
    gimp_item_get_tattoo($!g-i);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_item_get_type, $n, $t );
  }

  method get_visible is also<get-visible> {
    so gimp_item_get_visible($!g-i);
  }

  method id_is_channel is also<id-is-channel> {
    so gimp_item_id_is_channel($!g-i);
  }

  method id_is_drawable is also<id-is-drawable> {
    so gimp_item_id_is_drawable($!g-i);
  }

  method id_is_layer is also<id-is-layer> {
    so gimp_item_id_is_layer($!g-i);
  }

  method id_is_layer_mask is also<id-is-layer-mask> {
    so gimp_item_id_is_layer_mask($!g-i);
  }

  method id_is_selection is also<id-is-selection> {
    so gimp_item_id_is_selection($!g-i);
  }

  method id_is_text_layer is also<id-is-text-layer> {
    so gimp_item_id_is_text_layer($!g-i);
  }

  method id_is_valid is also<id-is-valid> {
    so gimp_item_id_is_valid($!g-i);
  }

  method id_is_vectors is also<id-is-vectors> {
    so gimp_item_id_is_vectors($!g-i);
  }

  method is_channel is also<is-channel> {
    so gimp_item_is_channel($!g-i);
  }

  method is_drawable is also<is-drawable> {
    so gimp_item_is_drawable($!g-i);
  }

  method is_group is also<is-group> {
    so gimp_item_is_group($!g-i);
  }

  method is_layer is also<is-layer> {
    so gimp_item_is_layer($!g-i);
  }

  method is_layer_mask is also<is-layer-mask> {
    so gimp_item_is_layer_mask($!g-i);
  }

  method is_selection is also<is-selection> {
    so gimp_item_is_selection($!g-i);
  }

  method is_text_layer is also<is-text-layer> {
    so gimp_item_is_text_layer($!g-i);
  }

  method is_valid is also<is-valid> {
    so gimp_item_is_valid($!g-i);
  }

  method is_vectors is also<is-vectors> {
    so gimp_item_is_vectors($!g-i);
  }

  method list_children ( :$raw = False, :$glist = False )
    is also<list-children>
  {
    returnGList(
      gimp_item_list_children($!g-i),
      $raw,
      $glist,
      |self.getTypePair
    );
  }

  method set_color_tag (Int() $color_tag) is also<set-color-tag> {
    my GimpColorTag $c = $color_tag;

    gimp_item_set_color_tag($!g-i, $color_tag);
  }

  method set_expanded (Int() $expanded) is also<set-expanded> {
    my gboolean $e = $expanded.so.Int;

    gimp_item_set_expanded($!g-i, $e);
  }

  method set_lock_content (Int() $lock_content) is also<set-lock-content> {
    my gboolean $l = $lock_content.so.Int;

    gimp_item_set_lock_content($!g-i, $l);
  }

  method set_lock_position (Int() $lock_position) is also<set-lock-position> {
    my gboolean $l = $lock_position.so.Int;

    gimp_item_set_lock_position($!g-i, $l);
  }

  method set_lock_visibility (Int() $lock_visibility)
    is also<set-lock-visibility>
  {
    my gboolean $l = $lock_visibility.so.Int;

    gimp_item_set_lock_visibility($!g-i, $l);
  }

  method set_name (Str() $name) is also<set-name> {
    gimp_item_set_name($!g-i, $name);
  }

  method set_tattoo (Int() $tattoo) is also<set-tattoo> {
    my guint $t = $tattoo;

    gimp_item_set_tattoo($!g-i, $t);
  }

  method set_visible (Int() $visible) is also<set-visible> {
    my gboolean $v = $visible.so.Int;

    gimp_item_set_visible($!g-i, $v);
  }

}
