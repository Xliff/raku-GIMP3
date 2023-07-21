use v6.c;

use Method::Also;

use NativeCall;

use GIMP::Raw::Types;
use GIMP::Raw::File;

use GLib::Roles::StaticClass;
use GIO::Roles::GFile;

class GIMP::File {
  has GimpImage $!this is built;

  method !resolveRunMode ($interactive, $noninteractive, $lastvals) {
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
    $arg where * !~~ (GFile, Str).any,
    :i(:$interactive),
    :n(:non_interactive(:non-interactive(:$noninteractive))),
    :l(:last(:last_vals(:last-vals(:$lastvals))))
  ) {
    given $arg -> $_ is copy {

      when .^can('GFile').so {
          say "GFILE!";
          $_ .= GFile;
          proceed
      }

      when $_ !~~ GFile && .^can('Str').so {
          say "STR!";
          $_ .= Str;
          proceed
      }

      when GFile | Str {
        samewith($_, :$interactive, :$noninteractive, :$lastvals)
      }

      default {
        X::GLib::UnknownType.new(
          message => "The { .^name } argument that is passed to .load must {
                      '' } be a GFile or Str compatible object!"
        ).throw;
      }
    }
  }
  multi method load (
    Str  $filename,
        :i(:$interactive),
        :n(:non_interactive(:non-interactive(:$noninteractive))),
        :l(:last(:last_vals(:last-vals(:$lastvals))))
  ) {
    samewith(
       GIO::File.new($filename, :path),
      :$interactive,
      :$noninteractive,
      :$lastvals
    )
  }
  multi method load (
    GFile  $file,
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

    my $gfl = gimp_file_load($m, $file);

    say "GFL: { +$gfl.p }";

    propReturnObject($gfl, $raw, |::('GIMP::Image').getTypePair);
  }

  proto method load_layer (|)
    is also<load-layer>
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
    is also<load-layers>
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

  method save_thumbnail (GimpImage() $image, GFile() $file) is also<save-thumbnail> {
    so gimp_file_save_thumbnail($image, $file);
  }

}
