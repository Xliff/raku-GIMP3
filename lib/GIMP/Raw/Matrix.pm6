use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::Matrix;

### /usr/src/gimp/libgimpmath/gimpmatrix.h

sub gimp_matrix2_determinant (GimpMatrix2 $matrix)
  returns gdouble
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix2_get_type
  returns GType
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix2_identity (GimpMatrix2 $matrix)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix2_invert (GimpMatrix2 $matrix)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix2_mult (
  GimpMatrix2 $left,
  GimpMatrix2 $right
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix2_transform_point (
  GimpMatrix2 $matrix,
  gdouble     $x,
  gdouble     $y,
  gdouble     $newx is rw,
  gdouble     $newy is rw
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_affine (
  GimpMatrix3 $matrix,
  gdouble     $a,
  gdouble     $b,
  gdouble     $c,
  gdouble     $d,
  gdouble     $e,
  gdouble     $f
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_determinant (GimpMatrix3 $matrix)
  returns gdouble
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_equal (
  GimpMatrix3 $matrix1,
  GimpMatrix3 $matrix2
)
  returns uint32
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_get_type
  returns GType
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_identity (GimpMatrix3 $matrix)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_invert (GimpMatrix3 $matrix)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_is_affine (GimpMatrix3 $matrix)
  returns uint32
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_is_diagonal (GimpMatrix3 $matrix)
  returns uint32
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_is_identity (GimpMatrix3 $matrix)
  returns uint32
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_is_simple (GimpMatrix3 $matrix)
  returns uint32
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_mult (
  GimpMatrix3 $left,
  GimpMatrix3 $right
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_rotate (
  GimpMatrix3 $matrix,
  gdouble     $theta
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_scale (
  GimpMatrix3 $matrix,
  gdouble     $x,
  gdouble     $y
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_transform_point (
  GimpMatrix3 $matrix,
  gdouble     $x,
  gdouble     $y,
  gdouble     $newx is rw,
  gdouble     $newy is rw
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_translate (
  GimpMatrix3 $matrix,
  gdouble     $x,
  gdouble     $y
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_xshear (
  GimpMatrix3 $matrix,
  gdouble     $amount
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix3_yshear (
  GimpMatrix3 $matrix,
  gdouble     $amount
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix4_identity (GimpMatrix4 $matrix)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix4_mult (
  GimpMatrix4 $left,
  GimpMatrix4 $right
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix4_to_deg (
  GimpMatrix4 $matrix,
  gdouble     $a is rw,
  gdouble     $b is rw,
  gdouble     $c is rw
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_matrix4_transform_point (
  GimpMatrix4 $matrix,
  gdouble     $x,
  gdouble     $y,
  gdouble     $z,
  gdouble     $newx is rw,
  gdouble     $newy is rw,
  gdouble     $newz is rw
)
  returns gdouble
  is      native(gimpmath)
  is      export
{ * }

sub gimp_param_matrix2_get_type
  returns GType
  is      native(gimpmath)
  is      export
{ * }

sub gimp_param_matrix3_get_type
  returns GType
  is      native(gimpmath)
  is      export
{ * }

sub gimp_param_spec_matrix2 (
  Str         $name,
  Str         $nick,
  Str         $blurb,
  GimpMatrix2 $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is      native(gimpmath)
  is      export
{ * }

sub gimp_param_spec_matrix3 (
  Str         $name,
  Str         $nick,
  Str         $blurb,
  GimpMatrix3 $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is      native(gimpmath)
  is      export
{ * }
