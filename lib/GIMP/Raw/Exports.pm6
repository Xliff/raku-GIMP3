use v6.c;

unit package GIMP::Raw::Exports;

our @gimp-exports is export;

BEGIN {
  @gimp-exports = <
    GIMP::Raw::Definitions
    GIMP::Raw::Enums
    GIMP::Raw::Structs
  >;
}
