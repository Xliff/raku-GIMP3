use v6.c;

use NativeCall;
use Method::Also;

use GIMP::Raw::Types;
use GIMP::Raw::UI::IntStore;

use GTK::ListStore:ver<3>;

use GLib::Roles::Object;
use GTK::Roles::TreeModel:ver<3>;

our subset GimpIntStoreAncestry is export of Mu
  where GimpIntStore | GtkListStoreAncestry;

class GIMP::UI::Int::Store is GTK::ListStore {
  has GimpIntStore $!gis is implementor;

  submethod BUILD ( :$gimp-int-store, :$columns ) {
    self.setGimpIntStore($gimp-int-store, :$columns) if $gimp-int-store
  }

  method setGimpIntStore (GimpIntStoreAncestry $_, :$columns) {
    my $to-parent;

    $!gis = do {
      when GimpIntStore {
        $to-parent = cast(GtkListStore, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpIntStore, $_);
      }
    }
    self.setGtkListStore($to-parent, :$columns);
  }

  method GIMP::Raw::Definitions::GimpIntStore
    is also<GimpIntStore>
  { $!gis }

   multi method new (
     $gimp-int-store where * ~~ GimpIntStoreAncestry,

    :$ref = True
  ) {
    return unless $gimp-int-store;

    my $o = self.bless( :$gimp-int-store );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str() $first_label,
    Int() $first_value
  ) {
    my gint $fv = $first_value;

    my $gimp-int-store = gimp_int_store_new($first_label, $first_value, Str);

    $gimp-int-store
      ?? self.bless(
        :$gimp-int-store,

        columns => [$first_label]
      )
      !! Nil;
  }


  proto method new_array (|)
    is also<new-array>
  { * }

  multi method new_array (@labels) {
    samewith( @labels.elems, ArrayToCArray(Str, @labels) )
  }
  multi method new_array (Int() $n_values, CArray[Str] $columns) {
    my gint $n = $n_values;

    my $gimp-int-store = gimp_int_store_new_array($n, $columns);

    $gimp-int-store
      ?? self.bless(
        :$gimp-int-store,

        columns => $columns[^$n]
      )
      !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_int_store_get_type, $n, $t );
  }

  proto method lookup_by_user_data (|)
    is also<lookup-by-user-data>
  { * }

  multi method lookup_by_user_data (gpointer $user_data, :$raw = False) {
    my $i = GtkTreeIter.new;
    samewith($user_data, $i);
    propReturnObject($i, $raw, |GTK::TreeIter.getTypePair)
  }
  multi method lookup_by_user_data (
    gpointer()     $user_data,
    GtkTreeIter()  $iter
  ) {
    gimp_int_store_lookup_by_user_data($!gis, $user_data, $iter);
  }

  proto method lookup_by_value (|)
    is also<lookup-by-value>
  { * }

  multi method lookup_by_value ($value, :$raw = False) {
    my $i = GtkTreeIter.new;
    samewith($value, $i);
    propReturnObject($i, $raw, |GTK::TreeIter.getTypePair)
  }
  multi method lookup_by_value (
    Int()         $value,
    GtkTreeIter() $iter
  ) {
    my gint $v = $value;

    so gimp_int_store_lookup_by_value($!gis, $v, $iter);
  }

  method gist {
    qq:to/GIST/;
      GIMP::UI::IntStore.new(
        columns => [{ $.columns.map({ qq<'{ $_ }'> }).join(', ') }]
      )
      GIST
  }

}
