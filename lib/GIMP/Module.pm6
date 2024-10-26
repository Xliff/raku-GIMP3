use v6.c;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::Module;

use GLib::Object::TypeModule;

use GLib::Roles::Implementor;

class GIMP::Module is GLib::Object::TypeModule {
  has GimpModule $!g-m is implementor;

  method new (
    Int() $auto_load,
    Int() $verbose
  ) {
    my ($a, $v) = ($auto_load, $verbose).map( *.so.Int );

    my $gimp-module = gimp_module_new($a, $v);

    $gimp-module ?? self.bless( :$gimp-module ) !! Nil;
  }

  method error_quark is static {
    gimp_module_error_quark();
  }

  method get_auto_load {
    so gimp_module_get_auto_load($!g-m);
  }

  method get_file {
    gimp_module_get_file($!g-m);
  }

  method get_info {
    gimp_module_get_info($!g-m);
  }

  method get_last_error {
    gimp_module_get_last_error($!g-m);
  }

  method get_state {
    gimp_module_get_state($!g-m);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_module_get_type, $n, $t );
  }

  method is_loaded {
    so gimp_module_is_loaded($!g-m);
  }

  method is_on_disk {
    so gimp_module_is_on_disk($!g-m);
  }

  method query {
    gimp_module_query($!g-m);
  }

  method query_module {
    gimp_module_query_module($!g-m);
  }

  method register {
    gimp_module_register($!g-m);
  }

  method set_auto_load (Int() $auto_load) {
    my gboolean $a = $auto_load.so.Int;

    gimp_module_set_auto_load($!g-m, $a);
  }

}
