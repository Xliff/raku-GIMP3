use v6;

use GIMP::Raw::Types;
use GIMP::Raw::Parasite;

use GLib::Object::ParamSpec;

use GLib::Roles::StaticClass;

# BOXED

class GIMP::Parasite {
  has GimpParasite $!p;

  submethod BUILD (:$parasite) {
    $!p = $parasite;
  }

  # submethod DESTROY {
  #   self.free;
  # }

  method GIMP::Raw::Structs::GimpParasite
  { $!p }

  multi method new (GimpParasite $parasite, :$ref = True) {
    return unless $parasite;

    my $o = self.bless( :$parasite );
    return $o.ref if $ref;
    $o;
  }
  multi method new (
    Str()    $name,
    Int()    $flags,
    Int()    $size,
    gpointer $data
  ) {
    my guint32 ($f, $s) = ($flags, $size);
    my $p = gimp_parasite_new($name, $flags, $size, $data);

    $p ?? self.bless( parasite => $p ) !! Nil;
  }

  method compare (GimpParasite() $b) {
    so gimp_parasite_compare($!p, $b);
  }

  method copy {
    my $p = gimp_parasite_copy($!p);

    $p ?? Gimp::Parasite.new($p, :!ref) !! Nil;
  }

  method free {
    gimp_parasite_free($!g-p);
  }

  proto method get_data (|)
  { * }

  multi method get_data {
    samewith($);
  }
  multi method get_data ($num_bytes is rw, :$buf = True) {
    my guint32 $n = 0;

    my $d = gimp_parasite_get_data($!g-p, $n);
    $num_bytes = $n;
    return ( $d = SizedCArray.new($d, size => $n) ) unless $buf;

    Buf.new($d);
  }

  method get_flags ( :set(:$flags) = True ) {
    getFlags( gimp_parasite_get_flags($!g-p), :index );
  }

  method get_name {
    gimp_parasite_get_name($!g-p);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_parasite_get_type, $n, $t );
  }

  method has_flag (Int() $flag) {
    my gulong $f = $flag;

    so gimp_parasite_has_flag($!g-p, $f);
  }

  method is_persistent {
    so gimp_parasite_is_persistent($!g-p);
  }

  method is_type (Str() $name) {
    so gimp_parasite_is_type($!g-p, $name);
  }

  method is_undoable {
    so gimp_parasite_is_undoable($!g-p);
  }

}

role GIMP::Roles::ParamSpec::Parasite {

  method parasite_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_param_parasite_get_type, $n, $t );
  }

  method spec_parasite (
    Str()  $name,
    Str()  $nick,
    Str()  $blurb,
    Int()  $flags,
          :$raw    = False
  ) {
    my GParamFlags $f = $flags;

    my $glib-paramspec = gimp_param_spec_parasite($name, $nick, $blurb, $f);

    $glib-paramspec ?? self.bless( :$glib-paramspec ) !! Nil;
  }

}
