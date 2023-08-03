use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::Vector;

### /usr/src/gimp/libgimpmath/gimpvector.h

# cw: All subs ending with _val are pass-by-value, which NativeCall does not
#     currently support. All vector returns are also return-by-value, and
#     it is hoped that by commenting out the return declaration the subs can
#     still be used without penaly.
#
#     Routines have been left in-situ in-case NativeCall support for by-value
#     structures is introduced in a later version.

sub gimp_vector2_add (
  GimpVector2 $result,
  GimpVector2 $vector1,
  GimpVector2 $vector2
)
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector2_add_val (
#   GimpVector2 $vector1,
#   GimpVector2 $vector2
# )
#   returns GimpVector2
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector2_cross_product (
  GimpVector2 $vector1,
  GimpVector2 $vector2
)
#  returns GimpVector2
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector2_cross_product_val (
#   GimpVector2 $vector1,
#   GimpVector2 $vector2
# )
#   returns GimpVector2
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector2_inner_product (
  GimpVector2 $vector1,
  GimpVector2 $vector2
)
  returns gdouble
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector2_inner_product_val (
#   GimpVector2 $vector1,
#   GimpVector2 $vector2
# )
#   returns gdouble
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector2_length (GimpVector2 $vector)
  returns gdouble
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector2_length_val (GimpVector2 $vector)
#   returns gdouble
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector2_mul (
  GimpVector2 $vector,
  gdouble     $factor
)
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector2_mul_val (
#   GimpVector2 $vector,
#   gdouble     $factor
# )
#   returns GimpVector2
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector2_neg (GimpVector2 $vector)
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector2_neg_val (GimpVector2 $vector)
#   returns GimpVector2
#   is      native(gimpmath)
#   is      export
# { * }

# cw: Reimplemented in Raku since it is return by value.
#
# sub gimp_vector2_new (
#   gdouble $x,
#   gdouble $y
# )
#   returns GimpVector2
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector2_normal (GimpVector2 $vector)
#  returns GimpVector2
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector2_normal_val (GimpVector2 $vector)
#   returns GimpVector2
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector2_normalize (GimpVector2 $vector)
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector2_normalize_val (GimpVector2 $vector)
#   returns GimpVector2
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector2_rotate (
  GimpVector2 $vector,
  gdouble     $alpha
)
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector2_rotate_val (
#   GimpVector2 $vector,
#   gdouble     $alpha
# )
#   returns GimpVector2
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector2_set (
  GimpVector2 $vector,
  gdouble     $x,
  gdouble     $y
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_vector2_sub (
  GimpVector2 $result,
  GimpVector2 $vector1,
  GimpVector2 $vector2
)
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector2_sub_val (
#   GimpVector2 $vector1,
#   GimpVector2 $vector2
# )
#   returns GimpVector2
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector3_add (
  GimpVector3 $result,
  GimpVector3 $vector1,
  GimpVector3 $vector2
)
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector3_add_val (
#   GimpVector3 $vector1,
#   GimpVector3 $vector2
# )
#   returns GimpVector3
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector3_cross_product (
  GimpVector3 $vector1,
  GimpVector3 $vector2
)
#  returns GimpVector3
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector3_cross_product_val (
#   GimpVector3 $vector1,
#   GimpVector3 $vector2
# )
#   returns GimpVector3
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector3_inner_product (
  GimpVector3 $vector1,
  GimpVector3 $vector2
)
  returns gdouble
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector3_inner_product_val (
#   GimpVector3 $vector1,
#   GimpVector3 $vector2
# )
#   returns gdouble
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector3_length (GimpVector3 $vector)
  returns gdouble
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector3_length_val (GimpVector3 $vector)
#   returns gdouble
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector3_mul (
  GimpVector3 $vector,
  gdouble     $factor
)
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector3_mul_val (
#   GimpVector3 $vector,
#   gdouble     $factor
# )
#   returns GimpVector3
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector3_neg (GimpVector3 $vector)
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector3_neg_val (GimpVector3 $vector)
#   returns GimpVector3
#   is      native(gimpmath)
#   is      export
# { * }

# cw: Will be reimplemented in Raku since it is return-by-value
#
# sub gimp_vector3_new (
#   gdouble $x,
#   gdouble $y,
#   gdouble $z
# )
#   returns GimpVector3
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector3_normalize (GimpVector3 $vector)
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector3_normalize_val (GimpVector3 $vector)
#   returns GimpVector3
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector3_rotate (
  GimpVector3 $vector,
  gdouble     $alpha,
  gdouble     $beta,
  gdouble     $gamma
)
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector3_rotate_val (
#   GimpVector3 $vector,
#   gdouble     $alpha,
#   gdouble     $beta,
#   gdouble     $gamma
# )
#   returns GimpVector3
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector3_set (
  GimpVector3 $vector,
  gdouble     $x,
  gdouble     $y,
  gdouble     $z
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_vector3_sub (
  GimpVector3 $result,
  GimpVector3 $vector1,
  GimpVector3 $vector2
)
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector3_sub_val (
#   GimpVector3 $vector1,
#   GimpVector3 $vector2
# )
#   returns GimpVector3
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector_2d_to_3d (
  gint        $sx,
  gint        $sy,
  gint        $w,
  gint        $h,
  gint        $x,
  gint        $y,
  GimpVector3 $vp,
  GimpVector3 $p
)
  is      native(gimpmath)
  is      export
{ * }

# sub gimp_vector_2d_to_3d_val (
#   gint        $sx,
#   gint        $sy,
#   gint        $w,
#   gint        $h,
#   gint        $x,
#   gint        $y,
#   GimpVector3 $vp,
#   GimpVector3 $p
# )
#   returns GimpVector3
#   is      native(gimpmath)
#   is      export
# { * }

sub gimp_vector_3d_to_2d (
  gint        $sx,
  gint        $sy,
  gint        $w,
  gint        $h,
  gdouble     $x is rw,
  gdouble     $y is rw,
  GimpVector3 $vp,
  GimpVector3 $p
)
  is      native(gimpmath)
  is      export
{ * }

sub gimp_vector2_get_type
  returns GType
  is      native(gimpmath)
  is      export
{ * }

sub gimp_vector3_get_type 
  returns GType
  is      native(gimpmath)
  is      export
{ * }
