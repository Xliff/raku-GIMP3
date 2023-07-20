use v6.c;

use NativeCall;

use GIMP::Raw::Types;
use GIMP::Raw::File;

use GLib::Roles::StaticClass;

class GIMP::File {
  has GimpImage $!this is built;

  method !resolveRunMode (
    :i(:$interactive),
    :n(:non_interactive(:non-interactive(:$noninteractive))),
    :l(:last(:last_vals(:last-vals(:$lastvals))))
  ) {
    X::GLib::InvalidArguments.new(
      message => "You must use ONE of the following arguments: {
                  '' }<interactive>, <noninteractive> or <last>"
    ).throw unless [^^]($interactive, $noninteractive, $lastvals);

    my $f = 0;
    $f +|= GIMP_RUN_INTERACTIVE    if $interactive;
    $f +|= GIMP_RUN_NONINTERACTIVE if $noninteractive;
    $f +|= GIMP_RUN_WITH_LAST_VALS if $lastvals;
    $f;
  }

  multi method load (
    GFile()  $file,
            :i(:$interactive),
            :n(:non_interactive(:non-interactive(:$noninteractive))),
            :l(:last(:last_vals(:last-vals(:$lastvals))))
  ) {
    samewith(
      self!resolveRunMode($interactive, $noninteractive, $lastvals),
      $file
    );
  }
  multi method load (
    Int()    $run_mode,
    GFile()  $file,
            :$raw       = False
  ) {
    my GimpRunMode $m = $run_mode;

    propReturnObject(
      gimp_file_load($m, $file),
      $raw,
      |GIMP::Image.getTypePair
    );
  }

  proto method load_layer (|)
  { * }

  multi method load_layer (
    GimpImage()  $image,
    GFile()      $file,
                :$raw = False,
                :i(:$interactive),
                :n(:non_interactive(:non-interactive(:$noninteractive))),
                :l(:last(:last_vals(:last-vals(:$lastvals))))
  ) {
    samewith(
       self!resolveRunMode($interactive, $noninteractive, $lastvals),
       $image,
       $file,
      :$raw
    );
  }
  multi method load_layer (
    Int()        $run_mode,
    GimpImage()  $image,
    GFile()      $file,
                :$raw       = False
  ) {
    my GimpRunMode $m = $run_mode;

    propReturnObject(
      gimp_file_load_layer($m, $image, $file),
      $raw,
      |GIMP::Layer.getTypePair
    );
  }

  proto method load_layers (|)
  { * }

  multi method load_layers (
    GFile()      $file,
                :$raw    = False,
                :$carray = False,
                :i(:$interactive),
                :n(:non_interactive(:non-interactive(:$noninteractive))),
                :l(:last(:last_vals(:last-vals(:$lastvals))))
  ) {
    samewith(
      $!this,
      $file,
      $,
     :$raw,
     :$carray,
     :$interactive,
     :$noninteractive,
     :$lastvals
    );
  }
  multi method load_layers (
    GimpImage()  $image where *.defined,
    GFile()      $file,
                :$raw    = False,
                :$carray = False,
                :i(:$interactive),
                :n(:non_interactive(:non-interactive(:$noninteractive))),
                :l(:last(:last_vals(:last-vals(:$lastvals))))
  ) {
    samewith(
       self!resolveRunMode($interactive, $noninteractive, $lastvals),
       $image,
       $file,
       $,
      :$raw,
      :$carray
    );
  }
  multi method load_layers (
    Int()        $run_mode,
    GimpImage()  $image,
    GFile()      $file,
                 $num_layers is rw,
                :$raw               = False,
                :$carray            = False

  ) {
    my GimpRunMode $m = $run_mode;
    my gint        $n = 0;

    my $a = gimp_file_load_layers($m, $image, $file, $n);
    $num_layers = $n;
    return $a if $raw && $carray;
    $a = CArrayToArray( ppr($a) );
    return $a if $raw;
    $a.map({ GIMP::Layer.new($_) });
  }

  multi method save (
    GFile() $file,
            @drawables,
            :$raw = False,
            :i(:$interactive),
            :n(:non_interactive(:non-interactive(:$noninteractive))),
            :l(:last(:last_vals(:last-vals(:$lastvals))))
  ) {
    samewith(
      $!this,
      @drawables,
      $file,
      :$raw,
      :$interactive,
      :$noninteractive,
      :$lastvals
    );
  }
  multi method save (
    GimpImage()  $image      where *.defined,
                 @drawables,
    GFile()      $file,
                :$raw = False,
                :i(:$interactive),
                :n(:non_interactive(:non-interactive(:$noninteractive))),
                :l(:last(:last_vals(:last-vals(:$lastvals))))
  ) {
    samewith(
      self!resolveRunMode($interactive, $noninteractive, $lastvals),
      $image,
      @drawables.elems,
      ArrayToCArray(GimpItem, @drawables),
      $file
    );
  }
  multi method save (
    Int()            $run_mode,
    GimpImage()      $image,
    Int()            $num_drawables,
    CArray[GimpItem] $drawables,
    GFile()          $file
  ) {
    my GimpRunMode $m = $run_mode;
    my gint        $n = $num_drawables;

    so gimp_file_save($m, $image, $n, $drawables, $file);
  }

  method save_thumbnail (GimpImage() $image, GFile() $file) {
    so gimp_file_save_thumbnail($image, $file);
  }

}
