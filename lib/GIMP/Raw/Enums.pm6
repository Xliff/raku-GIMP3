use v6.c;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;

unit package GIMP::Raw::Enums;

constant GPParamDefType is export := guint32;
our enum GPParamDefTypeEnum is export <
  GP_PARAM_DEF_TYPE_DEFAULT
  GP_PARAM_DEF_TYPE_INT
  GP_PARAM_DEF_TYPE_UNIT
  GP_PARAM_DEF_TYPE_ENUM
  GP_PARAM_DEF_TYPE_BOOLEAN
  GP_PARAM_DEF_TYPE_FLOAT
  GP_PARAM_DEF_TYPE_STRING
  GP_PARAM_DEF_TYPE_COLOR
  GP_PARAM_DEF_TYPE_ID
  GP_PARAM_DEF_TYPE_ID_ARRAY
>;

constant GPParamType is export := guint32;
our enum GPParamTypeEnum is export <
  GP_PARAM_TYPE_INT
  GP_PARAM_TYPE_FLOAT
  GP_PARAM_TYPE_STRING
  GP_PARAM_TYPE_STRV
  GP_PARAM_TYPE_BYTES
  GP_PARAM_TYPE_FILE
  GP_PARAM_TYPE_COLOR
  GP_PARAM_TYPE_PARASITE
  GP_PARAM_TYPE_ARRAY
  GP_PARAM_TYPE_ID_ARRAY
  GP_PARAM_TYPE_PARAM_DEF
>;

constant GimpAddMaskType is export := guint32;
our enum GimpAddMaskTypeEnum is export <
  GIMP_ADD_MASK_WHITE
  GIMP_ADD_MASK_BLACK
  GIMP_ADD_MASK_ALPHA
  GIMP_ADD_MASK_ALPHA_TRANSFER
  GIMP_ADD_MASK_SELECTION
  GIMP_ADD_MASK_COPY
  GIMP_ADD_MASK_CHANNEL
>;

constant GimpAddMaskTypeCompat is export := guint32;
our enum GimpAddMaskTypeCompatEnum is export <
  GIMP_ADD_WHITE_MASK
  GIMP_ADD_BLACK_MASK
  GIMP_ADD_ALPHA_MASK
  GIMP_ADD_ALPHA_TRANSFER_MASK
  GIMP_ADD_SELECTION_MASK
  GIMP_ADD_COPY_MASK
  GIMP_ADD_CHANNEL_MASK
>;

constant GimpArgumentSync is export := guint32;
our enum GimpArgumentSyncEnum is export <
  GIMP_ARGUMENT_SYNC_NONE
  GIMP_ARGUMENT_SYNC_PARASITE
>;

constant GimpAspectType is export := guint32;
our enum GimpAspectTypeEnum is export <
  GIMP_ASPECT_SQUARE
  GIMP_ASPECT_PORTRAIT
  GIMP_ASPECT_LANDSCAPE
>;

constant GimpBinrelocInitError is export := guint32;
our enum GimpBinrelocInitErrorEnum is export <
  GIMP_RELOC_INIT_ERROR_NOMEM
  GIMP_RELOC_INIT_ERROR_OPEN_MAPS
  GIMP_RELOC_INIT_ERROR_READ_MAPS
  GIMP_RELOC_INIT_ERROR_INVALID_MAPS
  GIMP_RELOC_INIT_ERROR_DISABLED
>;

constant GimpBrushApplicationMode is export := guint32;
our enum GimpBrushApplicationModeEnum is export <
  GIMP_BRUSH_HARD
  GIMP_BRUSH_SOFT
>;

constant GimpBrushGeneratedShape is export := guint32;
our enum GimpBrushGeneratedShapeEnum is export <
  GIMP_BRUSH_GENERATED_CIRCLE
  GIMP_BRUSH_GENERATED_SQUARE
  GIMP_BRUSH_GENERATED_DIAMOND
>;

constant GimpCapStyle is export := guint32;
our enum GimpCapStyleEnum is export <
  GIMP_CAP_BUTT
  GIMP_CAP_ROUND
  GIMP_CAP_SQUARE
>;

constant GimpChainPosition is export := guint32;
our enum GimpChainPositionEnum is export <
  GIMP_CHAIN_TOP
  GIMP_CHAIN_LEFT
  GIMP_CHAIN_BOTTOM
  GIMP_CHAIN_RIGHT
>;

constant GimpChannelOps is export := guint32;
our enum GimpChannelOpsEnum is export <
  GIMP_CHANNEL_OP_ADD
  GIMP_CHANNEL_OP_SUBTRACT
  GIMP_CHANNEL_OP_REPLACE
  GIMP_CHANNEL_OP_INTERSECT
>;

constant GimpChannelType is export := guint32;
our enum GimpChannelTypeEnum is export <
  GIMP_CHANNEL_RED
  GIMP_CHANNEL_GREEN
  GIMP_CHANNEL_BLUE
  GIMP_CHANNEL_GRAY
  GIMP_CHANNEL_INDEXED
  GIMP_CHANNEL_ALPHA
>;

constant GimpCheckSize is export := guint32;
our enum GimpCheckSizeEnum is export <
  GIMP_CHECK_SIZE_SMALL_CHECKS
  GIMP_CHECK_SIZE_MEDIUM_CHECKS
  GIMP_CHECK_SIZE_LARGE_CHECKS
>;

constant GimpCheckType is export := guint32;
our enum GimpCheckTypeEnum is export <
  GIMP_CHECK_TYPE_LIGHT_CHECKS
  GIMP_CHECK_TYPE_GRAY_CHECKS
  GIMP_CHECK_TYPE_DARK_CHECKS
  GIMP_CHECK_TYPE_WHITE_ONLY
  GIMP_CHECK_TYPE_GRAY_ONLY
  GIMP_CHECK_TYPE_BLACK_ONLY
  GIMP_CHECK_TYPE_CUSTOM_CHECKS
>;

constant GimpCloneType is export := guint32;
our enum GimpCloneTypeEnum is export <
  GIMP_CLONE_IMAGE
  GIMP_CLONE_PATTERN
>;

constant GimpColorAreaType is export := guint32;
our enum GimpColorAreaTypeEnum is export <
  GIMP_COLOR_AREA_FLAT
  GIMP_COLOR_AREA_SMALL_CHECKS
  GIMP_COLOR_AREA_LARGE_CHECKS
>;

constant GimpColorManagementMode is export := guint32;
our enum GimpColorManagementModeEnum is export <
  GIMP_COLOR_MANAGEMENT_OFF
  GIMP_COLOR_MANAGEMENT_DISPLAY
  GIMP_COLOR_MANAGEMENT_SOFTPROOF
>;

constant GimpColorProfileStoreColumns is export := guint32;
our enum GimpColorProfileStoreColumnsEnum is export <
  GIMP_COLOR_PROFILE_STORE_ITEM_TYPE
  GIMP_COLOR_PROFILE_STORE_LABEL
  GIMP_COLOR_PROFILE_STORE_FILE
  GIMP_COLOR_PROFILE_STORE_INDEX
>;

constant GimpColorProfileStoreItemType is export := guint32;
our enum GimpColorProfileStoreItemTypeEnum is export <
  GIMP_COLOR_PROFILE_STORE_ITEM_FILE
  GIMP_COLOR_PROFILE_STORE_ITEM_SEPARATOR_TOP
  GIMP_COLOR_PROFILE_STORE_ITEM_SEPARATOR_BOTTOM
  GIMP_COLOR_PROFILE_STORE_ITEM_DIALOG
>;

constant GimpColorRenderingIntent is export := guint32;
our enum GimpColorRenderingIntentEnum is export <
  GIMP_COLOR_RENDERING_INTENT_PERCEPTUAL
  GIMP_COLOR_RENDERING_INTENT_RELATIVE_COLORIMETRIC
  GIMP_COLOR_RENDERING_INTENT_SATURATION
  GIMP_COLOR_RENDERING_INTENT_ABSOLUTE_COLORIMETRIC
>;

constant GimpColorSelectorChannel is export := guint32;
our enum GimpColorSelectorChannelEnum is export <
  GIMP_COLOR_SELECTOR_HUE
  GIMP_COLOR_SELECTOR_SATURATION
  GIMP_COLOR_SELECTOR_VALUE
  GIMP_COLOR_SELECTOR_RED
  GIMP_COLOR_SELECTOR_GREEN
  GIMP_COLOR_SELECTOR_BLUE
  GIMP_COLOR_SELECTOR_ALPHA
  GIMP_COLOR_SELECTOR_LCH_LIGHTNESS
  GIMP_COLOR_SELECTOR_LCH_CHROMA
  GIMP_COLOR_SELECTOR_LCH_HUE
>;

constant GimpColorSelectorModel is export := guint32;
our enum GimpColorSelectorModelEnum is export <
  GIMP_COLOR_SELECTOR_MODEL_RGB
  GIMP_COLOR_SELECTOR_MODEL_LCH
  GIMP_COLOR_SELECTOR_MODEL_HSV
>;

constant GimpColorTag is export := guint32;
our enum GimpColorTagEnum is export <
  GIMP_COLOR_TAG_NONE
  GIMP_COLOR_TAG_BLUE
  GIMP_COLOR_TAG_GREEN
  GIMP_COLOR_TAG_YELLOW
  GIMP_COLOR_TAG_ORANGE
  GIMP_COLOR_TAG_BROWN
  GIMP_COLOR_TAG_RED
  GIMP_COLOR_TAG_VIOLET
  GIMP_COLOR_TAG_GRAY
>;

constant GimpColorTransformFlags is export := guint32;
our enum GimpColorTransformFlagsEnum is export <
  GIMP_COLOR_TRANSFORM_FLAGS_NOOPTIMIZE
  GIMP_COLOR_TRANSFORM_FLAGS_GAMUT_CHECK
  GIMP_COLOR_TRANSFORM_FLAGS_BLACK_POINT_COMPENSATION
>;

constant GimpComponentType is export := guint32;
our enum GimpComponentTypeEnum is export <
  GIMP_COMPONENT_TYPE_U8
  GIMP_COMPONENT_TYPE_U16
  GIMP_COMPONENT_TYPE_U32
  GIMP_COMPONENT_TYPE_HALF
  GIMP_COMPONENT_TYPE_FLOAT
  GIMP_COMPONENT_TYPE_DOUBLE
>;

constant GimpConfigError is export := guint32;
our enum GimpConfigErrorEnum is export <
  GIMP_CONFIG_ERROR_OPEN
  GIMP_CONFIG_ERROR_OPEN_ENOENT
  GIMP_CONFIG_ERROR_WRITE
  GIMP_CONFIG_ERROR_PARSE
  GIMP_CONFIG_ERROR_VERSION
>;

constant GimpConfigPathType is export := guint32;
our enum GimpConfigPathTypeEnum is export <
  GIMP_CONFIG_PATH_FILE
  GIMP_CONFIG_PATH_FILE_LIST
  GIMP_CONFIG_PATH_DIR
  GIMP_CONFIG_PATH_DIR_LIST
>;

constant GimpControllerEventType is export := guint32;
our enum GimpControllerEventTypeEnum is export <
  GIMP_CONTROLLER_EVENT_TRIGGER
  GIMP_CONTROLLER_EVENT_VALUE
>;

constant GimpConvertDitherType is export := guint32;
our enum GimpConvertDitherTypeEnum is export <
  GIMP_CONVERT_DITHER_NONE
  GIMP_CONVERT_DITHER_FS
  GIMP_CONVERT_DITHER_FS_LOWBLEED
  GIMP_CONVERT_DITHER_FIXED
>;

constant GimpConvertPaletteType is export := guint32;
our enum GimpConvertPaletteTypeEnum is export <
  GIMP_CONVERT_PALETTE_GENERATE
  GIMP_CONVERT_PALETTE_WEB
  GIMP_CONVERT_PALETTE_MONO
  GIMP_CONVERT_PALETTE_CUSTOM
>;

constant GimpConvolveType is export := guint32;
our enum GimpConvolveTypeEnum is export <
  GIMP_CONVOLVE_BLUR
  GIMP_CONVOLVE_SHARPEN
>;

constant GimpCpuAccelFlags is export := guint32;
our enum GimpCpuAccelFlagsEnum is export <
  GIMP_CPU_ACCEL_NONE
  GIMP_CPU_ACCEL_X86_MMX
  GIMP_CPU_ACCEL_X86_3DNOW
  GIMP_CPU_ACCEL_X86_MMXEXT
  GIMP_CPU_ACCEL_X86_SSE
  GIMP_CPU_ACCEL_X86_SSE2
  GIMP_CPU_ACCEL_X86_SSE3
  GIMP_CPU_ACCEL_X86_SSSE3
  GIMP_CPU_ACCEL_X86_SSE4_1
  GIMP_CPU_ACCEL_X86_SSE4_2
  GIMP_CPU_ACCEL_X86_AVX
  GIMP_CPU_ACCEL_PPC_ALTIVEC
>;

constant GimpDebugFlag is export := guint32;
our enum GimpDebugFlagEnum is export <
  GIMP_DEBUG_PID
  GIMP_DEBUG_FATAL_WARNINGS
  GIMP_DEBUG_QUERY
  GIMP_DEBUG_INIT
  GIMP_DEBUG_RUN
  GIMP_DEBUG_QUIT
  GIMP_DEBUG_FATAL_CRITICALS
>;

constant GimpDesaturateMode is export := guint32;
our enum GimpDesaturateModeEnum is export <
  GIMP_DESATURATE_LIGHTNESS
  GIMP_DESATURATE_LUMA
  GIMP_DESATURATE_AVERAGE
  GIMP_DESATURATE_LUMINANCE
  GIMP_DESATURATE_VALUE
>;

constant GimpDodgeBurnType is export := guint32;
our enum GimpDodgeBurnTypeEnum is export <
  GIMP_DODGE_BURN_TYPE_DODGE
  GIMP_DODGE_BURN_TYPE_BURN
>;

constant GimpExportCapabilities is export := guint32;
our enum GimpExportCapabilitiesEnum is export <
  GIMP_EXPORT_CAN_HANDLE_RGB
  GIMP_EXPORT_CAN_HANDLE_GRAY
  GIMP_EXPORT_CAN_HANDLE_INDEXED
  GIMP_EXPORT_CAN_HANDLE_BITMAP
  GIMP_EXPORT_CAN_HANDLE_ALPHA
  GIMP_EXPORT_CAN_HANDLE_LAYERS
  GIMP_EXPORT_CAN_HANDLE_LAYERS_AS_ANIMATION
  GIMP_EXPORT_CAN_HANDLE_LAYER_MASKS
  GIMP_EXPORT_NEEDS_ALPHA
  GIMP_EXPORT_NEEDS_CROP
>;

constant GimpExportReturn is export := guint32;
our enum GimpExportReturnEnum is export <
  GIMP_EXPORT_CANCEL
  GIMP_EXPORT_IGNORE
  GIMP_EXPORT_EXPORT
>;

constant GimpFillType is export := guint32;
our enum GimpFillTypeEnum is export <
  GIMP_FILL_FOREGROUND
  GIMP_FILL_BACKGROUND
  GIMP_FILL_CIELAB_MIDDLE_GRAY
  GIMP_FILL_WHITE
  GIMP_FILL_TRANSPARENT
  GIMP_FILL_PATTERN
>;

constant GimpForegroundExtractMode is export := guint32;
our enum GimpForegroundExtractModeEnum is export <
  GIMP_FOREGROUND_EXTRACT_MATTING
>;

constant GimpGradientBlendColorSpace is export := guint32;
our enum GimpGradientBlendColorSpaceEnum is export <
  GIMP_GRADIENT_BLEND_RGB_PERCEPTUAL
  GIMP_GRADIENT_BLEND_RGB_LINEAR
  GIMP_GRADIENT_BLEND_CIE_LAB
>;

constant GimpGradientSegmentColor is export := guint32;
our enum GimpGradientSegmentColorEnum is export <
  GIMP_GRADIENT_SEGMENT_RGB
  GIMP_GRADIENT_SEGMENT_HSV_CCW
  GIMP_GRADIENT_SEGMENT_HSV_CW
>;

constant GimpGradientSegmentType is export := guint32;
our enum GimpGradientSegmentTypeEnum is export <
  GIMP_GRADIENT_SEGMENT_LINEAR
  GIMP_GRADIENT_SEGMENT_CURVED
  GIMP_GRADIENT_SEGMENT_SINE
  GIMP_GRADIENT_SEGMENT_SPHERE_INCREASING
  GIMP_GRADIENT_SEGMENT_SPHERE_DECREASING
  GIMP_GRADIENT_SEGMENT_STEP
>;

constant GimpGradientType is export := guint32;
our enum GimpGradientTypeEnum is export <
  GIMP_GRADIENT_LINEAR
  GIMP_GRADIENT_BILINEAR
  GIMP_GRADIENT_RADIAL
  GIMP_GRADIENT_SQUARE
  GIMP_GRADIENT_CONICAL_SYMMETRIC
  GIMP_GRADIENT_CONICAL_ASYMMETRIC
  GIMP_GRADIENT_SHAPEBURST_ANGULAR
  GIMP_GRADIENT_SHAPEBURST_SPHERICAL
  GIMP_GRADIENT_SHAPEBURST_DIMPLED
  GIMP_GRADIENT_SPIRAL_CLOCKWISE
  GIMP_GRADIENT_SPIRAL_ANTICLOCKWISE
>;

constant GimpGridStyle is export := guint32;
our enum GimpGridStyleEnum is export <
  GIMP_GRID_DOTS
  GIMP_GRID_INTERSECTIONS
  GIMP_GRID_ON_OFF_DASH
  GIMP_GRID_DOUBLE_DASH
  GIMP_GRID_SOLID
>;

constant GimpHistogramChannel is export := guint32;
our enum GimpHistogramChannelEnum is export <
  GIMP_HISTOGRAM_VALUE
  GIMP_HISTOGRAM_RED
  GIMP_HISTOGRAM_GREEN
  GIMP_HISTOGRAM_BLUE
  GIMP_HISTOGRAM_ALPHA
  GIMP_HISTOGRAM_LUMINANCE
>;

constant GimpHueRange is export := guint32;
our enum GimpHueRangeEnum is export <
  GIMP_HUE_RANGE_ALL
  GIMP_HUE_RANGE_RED
  GIMP_HUE_RANGE_YELLOW
  GIMP_HUE_RANGE_GREEN
  GIMP_HUE_RANGE_CYAN
  GIMP_HUE_RANGE_BLUE
  GIMP_HUE_RANGE_MAGENTA
>;

constant GimpIconType is export := guint32;
our enum GimpIconTypeEnum is export <
  GIMP_ICON_TYPE_ICON_NAME
  GIMP_ICON_TYPE_PIXBUF
  GIMP_ICON_TYPE_IMAGE_FILE
>;

constant GimpImageBaseType is export := guint32;
our enum GimpImageBaseTypeEnum is export <
  GIMP_RGB
  GIMP_GRAY
  GIMP_INDEXED
>;

constant GimpImageType is export := guint32;
our enum GimpImageTypeEnum is export <
  GIMP_RGB_IMAGE
  GIMP_RGBA_IMAGE
  GIMP_GRAY_IMAGE
  GIMP_GRAYA_IMAGE
  GIMP_INDEXED_IMAGE
  GIMP_INDEXEDA_IMAGE
>;

constant GimpInkBlobType is export := guint32;
our enum GimpInkBlobTypeEnum is export <
  GIMP_INK_BLOB_TYPE_CIRCLE
  GIMP_INK_BLOB_TYPE_SQUARE
  GIMP_INK_BLOB_TYPE_DIAMOND
>;

constant GimpIntComboBoxLayout is export := guint32;
our enum GimpIntComboBoxLayoutEnum is export <
  GIMP_INT_COMBO_BOX_LAYOUT_ICON_ONLY
  GIMP_INT_COMBO_BOX_LAYOUT_ABBREVIATED
  GIMP_INT_COMBO_BOX_LAYOUT_FULL
>;

constant GimpIntStoreColumns is export := guint32;
our enum GimpIntStoreColumnsEnum is export <
  GIMP_INT_STORE_VALUE
  GIMP_INT_STORE_LABEL
  GIMP_INT_STORE_ABBREV
  GIMP_INT_STORE_ICON_NAME
  GIMP_INT_STORE_PIXBUF
  GIMP_INT_STORE_USER_DATA
  GIMP_INT_STORE_NUM_COLUMNS
>;

constant GimpInterpolationType is export := guint32;
our enum GimpInterpolationTypeEnum is export <
  GIMP_INTERPOLATION_NONE
  GIMP_INTERPOLATION_LINEAR
  GIMP_INTERPOLATION_CUBIC
  GIMP_INTERPOLATION_NOHALO
  GIMP_INTERPOLATION_LOHALO
>;

constant GimpJoinStyle is export := guint32;
our enum GimpJoinStyleEnum is export <
  GIMP_JOIN_MITER
  GIMP_JOIN_ROUND
  GIMP_JOIN_BEVEL
>;

constant GimpLayerColorSpace is export := guint32;
our enum GimpLayerColorSpaceEnum is export <
  GIMP_LAYER_COLOR_SPACE_AUTO
  GIMP_LAYER_COLOR_SPACE_RGB_LINEAR
  GIMP_LAYER_COLOR_SPACE_RGB_PERCEPTUAL
>;

constant GimpLayerCompositeMode is export := guint32;
our enum GimpLayerCompositeModeEnum is export <
  GIMP_LAYER_COMPOSITE_AUTO
  GIMP_LAYER_COMPOSITE_UNION
  GIMP_LAYER_COMPOSITE_CLIP_TO_BACKDROP
  GIMP_LAYER_COMPOSITE_CLIP_TO_LAYER
  GIMP_LAYER_COMPOSITE_INTERSECTION
>;

constant GimpLayerMode is export := guint32;
our enum GimpLayerModeEnum is export <
  GIMP_LAYER_MODE_NORMAL_LEGACY
  GIMP_LAYER_MODE_DISSOLVE
  GIMP_LAYER_MODE_BEHIND_LEGACY
  GIMP_LAYER_MODE_MULTIPLY_LEGACY
  GIMP_LAYER_MODE_SCREEN_LEGACY
  GIMP_LAYER_MODE_OVERLAY_LEGACY
  GIMP_LAYER_MODE_DIFFERENCE_LEGACY
  GIMP_LAYER_MODE_ADDITION_LEGACY
  GIMP_LAYER_MODE_SUBTRACT_LEGACY
  GIMP_LAYER_MODE_DARKEN_ONLY_LEGACY
  GIMP_LAYER_MODE_LIGHTEN_ONLY_LEGACY
  GIMP_LAYER_MODE_HSV_HUE_LEGACY
  GIMP_LAYER_MODE_HSV_SATURATION_LEGACY
  GIMP_LAYER_MODE_HSL_COLOR_LEGACY
  GIMP_LAYER_MODE_HSV_VALUE_LEGACY
  GIMP_LAYER_MODE_DIVIDE_LEGACY
  GIMP_LAYER_MODE_DODGE_LEGACY
  GIMP_LAYER_MODE_BURN_LEGACY
  GIMP_LAYER_MODE_HARDLIGHT_LEGACY
  GIMP_LAYER_MODE_SOFTLIGHT_LEGACY
  GIMP_LAYER_MODE_GRAIN_EXTRACT_LEGACY
  GIMP_LAYER_MODE_GRAIN_MERGE_LEGACY
  GIMP_LAYER_MODE_COLOR_ERASE_LEGACY
  GIMP_LAYER_MODE_OVERLAY
  GIMP_LAYER_MODE_LCH_HUE
  GIMP_LAYER_MODE_LCH_CHROMA
  GIMP_LAYER_MODE_LCH_COLOR
  GIMP_LAYER_MODE_LCH_LIGHTNESS
  GIMP_LAYER_MODE_NORMAL
  GIMP_LAYER_MODE_BEHIND
  GIMP_LAYER_MODE_MULTIPLY
  GIMP_LAYER_MODE_SCREEN
  GIMP_LAYER_MODE_DIFFERENCE
  GIMP_LAYER_MODE_ADDITION
  GIMP_LAYER_MODE_SUBTRACT
  GIMP_LAYER_MODE_DARKEN_ONLY
  GIMP_LAYER_MODE_LIGHTEN_ONLY
  GIMP_LAYER_MODE_HSV_HUE
  GIMP_LAYER_MODE_HSV_SATURATION
  GIMP_LAYER_MODE_HSL_COLOR
  GIMP_LAYER_MODE_HSV_VALUE
  GIMP_LAYER_MODE_DIVIDE
  GIMP_LAYER_MODE_DODGE
  GIMP_LAYER_MODE_BURN
  GIMP_LAYER_MODE_HARDLIGHT
  GIMP_LAYER_MODE_SOFTLIGHT
  GIMP_LAYER_MODE_GRAIN_EXTRACT
  GIMP_LAYER_MODE_GRAIN_MERGE
  GIMP_LAYER_MODE_VIVID_LIGHT
  GIMP_LAYER_MODE_PIN_LIGHT
  GIMP_LAYER_MODE_LINEAR_LIGHT
  GIMP_LAYER_MODE_HARD_MIX
  GIMP_LAYER_MODE_EXCLUSION
  GIMP_LAYER_MODE_LINEAR_BURN
  GIMP_LAYER_MODE_LUMA_DARKEN_ONLY
  GIMP_LAYER_MODE_LUMA_LIGHTEN_ONLY
  GIMP_LAYER_MODE_LUMINANCE
  GIMP_LAYER_MODE_COLOR_ERASE
  GIMP_LAYER_MODE_ERASE
  GIMP_LAYER_MODE_MERGE
  GIMP_LAYER_MODE_SPLIT
  GIMP_LAYER_MODE_PASS_THROUGH
>;

constant GimpMaskApplyMode is export := guint32;
our enum GimpMaskApplyModeEnum is export <
  GIMP_MASK_APPLY
  GIMP_MASK_DISCARD
>;

constant GimpMergeType is export := guint32;
our enum GimpMergeTypeEnum is export <
  GIMP_EXPAND_AS_NECESSARY
  GIMP_CLIP_TO_IMAGE
  GIMP_CLIP_TO_BOTTOM_LAYER
  GIMP_FLATTEN_IMAGE
>;

constant GimpMessageHandlerType is export := guint32;
our enum GimpMessageHandlerTypeEnum is export <
  GIMP_MESSAGE_BOX
  GIMP_CONSOLE
  GIMP_ERROR_CONSOLE
>;

constant GimpMetadataColorspace is export := guint32;
our enum GimpMetadataColorspaceEnum is export <
  GIMP_METADATA_COLORSPACE_UNSPECIFIED
  GIMP_METADATA_COLORSPACE_UNCALIBRATED
  GIMP_METADATA_COLORSPACE_SRGB
  GIMP_METADATA_COLORSPACE_ADOBERGB
>;

constant GimpMetadataLoadFlags is export := guint32;
our enum GimpMetadataLoadFlagsEnum is export <
  GIMP_METADATA_LOAD_COMMENT
  GIMP_METADATA_LOAD_RESOLUTION
  GIMP_METADATA_LOAD_ORIENTATION
  GIMP_METADATA_LOAD_COLORSPACE
  GIMP_METADATA_LOAD_ALL
>;

constant GimpMetadataSaveFlags is export := guint32;
our enum GimpMetadataSaveFlagsEnum is export <
  GIMP_METADATA_SAVE_EXIF
  GIMP_METADATA_SAVE_XMP
  GIMP_METADATA_SAVE_IPTC
  GIMP_METADATA_SAVE_THUMBNAIL
  GIMP_METADATA_SAVE_COLOR_PROFILE
  GIMP_METADATA_SAVE_COMMENT
  GIMP_METADATA_SAVE_ALL
>;

constant GimpModuleError is export := guint32;
our enum GimpModuleErrorEnum is export <
  GIMP_MODULE_FAILED
>;

constant GimpModuleState is export := guint32;
our enum GimpModuleStateEnum is export <
  GIMP_MODULE_STATE_ERROR
  GIMP_MODULE_STATE_LOADED
  GIMP_MODULE_STATE_LOAD_FAILED
  GIMP_MODULE_STATE_NOT_LOADED
>;

constant GimpOffsetType is export := guint32;
our enum GimpOffsetTypeEnum is export <
  GIMP_OFFSET_BACKGROUND
  GIMP_OFFSET_TRANSPARENT
  GIMP_OFFSET_WRAP_AROUND
>;

constant GimpOrientationType is export := guint32;
our enum GimpOrientationTypeEnum is export <
  GIMP_ORIENTATION_HORIZONTAL
  GIMP_ORIENTATION_VERTICAL
  GIMP_ORIENTATION_UNKNOWN
>;

constant GimpPDBErrorHandler is export := guint32;
our enum GimpPDBErrorHandlerEnum is export <
  GIMP_PDB_ERROR_HANDLER_INTERNAL
  GIMP_PDB_ERROR_HANDLER_PLUGIN
>;

constant GimpPDBProcType is export := guint32;
our enum GimpPDBProcTypeEnum is export <
  GIMP_PDB_PROC_TYPE_INTERNAL
  GIMP_PDB_PROC_TYPE_PLUGIN
  GIMP_PDB_PROC_TYPE_EXTENSION
  GIMP_PDB_PROC_TYPE_TEMPORARY
>;

constant GimpPDBStatusType is export := guint32;
our enum GimpPDBStatusTypeEnum is export <
  GIMP_PDB_EXECUTION_ERROR
  GIMP_PDB_CALLING_ERROR
  GIMP_PDB_PASS_THROUGH
  GIMP_PDB_SUCCESS
  GIMP_PDB_CANCEL
>;

constant GimpPageSelectorTarget is export := guint32;
our enum GimpPageSelectorTargetEnum is export <
  GIMP_PAGE_SELECTOR_TARGET_LAYERS
  GIMP_PAGE_SELECTOR_TARGET_IMAGES
>;

constant GimpPaintApplicationMode is export := guint32;
our enum GimpPaintApplicationModeEnum is export <
  GIMP_PAINT_CONSTANT
  GIMP_PAINT_INCREMENTAL
>;

constant GimpPdbErrorCode is export := guint32;
our enum GimpPdbErrorCodeEnum is export <
  GIMP_PDB_ERROR_FAILED
  GIMP_PDB_ERROR_CANCELLED
  GIMP_PDB_ERROR_PDB_NOT_FOUND
  GIMP_PDB_ERROR_INVALID_ARGUMENT
  GIMP_PDB_ERROR_INVALID_RETURN_VALUE
  GIMP_PDB_ERROR_INTERNAL_ERROR
>;

constant GimpPixbufTransparency is export := guint32;
our enum GimpPixbufTransparencyEnum is export <
  GIMP_PIXBUF_KEEP_ALPHA
  GIMP_PIXBUF_SMALL_CHECKS
  GIMP_PIXBUF_LARGE_CHECKS
>;

constant GimpPrecision is export := guint32;
our enum GimpPrecisionEnum is export <
  GIMP_PRECISION_U8_LINEAR
  GIMP_PRECISION_U8_NON_LINEAR
  GIMP_PRECISION_U8_PERCEPTUAL
  GIMP_PRECISION_U16_LINEAR
  GIMP_PRECISION_U16_NON_LINEAR
  GIMP_PRECISION_U16_PERCEPTUAL
  GIMP_PRECISION_U32_LINEAR
  GIMP_PRECISION_U32_NON_LINEAR
  GIMP_PRECISION_U32_PERCEPTUAL
  GIMP_PRECISION_HALF_LINEAR
  GIMP_PRECISION_HALF_NON_LINEAR
  GIMP_PRECISION_HALF_PERCEPTUAL
  GIMP_PRECISION_FLOAT_LINEAR
  GIMP_PRECISION_FLOAT_NON_LINEAR
  GIMP_PRECISION_FLOAT_PERCEPTUAL
  GIMP_PRECISION_DOUBLE_LINEAR
  GIMP_PRECISION_DOUBLE_NON_LINEAR
  GIMP_PRECISION_DOUBLE_PERCEPTUAL
  GIMP_PRECISION_U8_GAMMA
  GIMP_PRECISION_U16_GAMMA
  GIMP_PRECISION_U32_GAMMA
  GIMP_PRECISION_HALF_GAMMA
  GIMP_PRECISION_FLOAT_GAMMA
  GIMP_PRECISION_DOUBLE_GAMMA
>;

constant GimpProcedureSensitivityMask is export := guint32;
our enum GimpProcedureSensitivityMaskEnum is export <
  GIMP_PROCEDURE_SENSITIVE_DRAWABLE
  GIMP_PROCEDURE_SENSITIVE_DRAWABLES
  GIMP_PROCEDURE_SENSITIVE_NO_DRAWABLES
  GIMP_PROCEDURE_SENSITIVE_NO_IMAGE
  GIMP_PROCEDURE_SENSITIVE_ALWAYS
>;

constant GimpProgressCommand is export := guint32;
our enum GimpProgressCommandEnum is export <
  GIMP_PROGRESS_COMMAND_START
  GIMP_PROGRESS_COMMAND_END
  GIMP_PROGRESS_COMMAND_SET_TEXT
  GIMP_PROGRESS_COMMAND_SET_VALUE
  GIMP_PROGRESS_COMMAND_PULSE
  GIMP_PROGRESS_COMMAND_GET_WINDOW
>;

constant GimpRGBCompositeMode is export := guint32;
our enum GimpRGBCompositeModeEnum is export <
  GIMP_RGB_COMPOSITE_NONE
  GIMP_RGB_COMPOSITE_NORMAL
  GIMP_RGB_COMPOSITE_BEHIND
>;

constant GimpRepeatMode is export := guint32;
our enum GimpRepeatModeEnum is export <
  GIMP_REPEAT_NONE
  GIMP_REPEAT_SAWTOOTH
  GIMP_REPEAT_TRIANGULAR
  GIMP_REPEAT_TRUNCATE
>;

constant GimpRotationType is export := guint32;
our enum GimpRotationTypeEnum is export <
  GIMP_ROTATE_90
  GIMP_ROTATE_180
  GIMP_ROTATE_270
>;

constant GimpRunMode is export := guint32;
our enum GimpRunModeEnum is export <
  GIMP_RUN_INTERACTIVE
  GIMP_RUN_NONINTERACTIVE
  GIMP_RUN_WITH_LAST_VALS
>;

constant GimpSelectCriterion is export := guint32;
our enum GimpSelectCriterionEnum is export <
  GIMP_SELECT_CRITERION_COMPOSITE
  GIMP_SELECT_CRITERION_RGB_RED
  GIMP_SELECT_CRITERION_RGB_GREEN
  GIMP_SELECT_CRITERION_RGB_BLUE
  GIMP_SELECT_CRITERION_HSV_HUE
  GIMP_SELECT_CRITERION_HSV_SATURATION
  GIMP_SELECT_CRITERION_HSV_VALUE
  GIMP_SELECT_CRITERION_LCH_LIGHTNESS
  GIMP_SELECT_CRITERION_LCH_CHROMA
  GIMP_SELECT_CRITERION_LCH_HUE
  GIMP_SELECT_CRITERION_ALPHA
>;

constant GimpSizeEntryUpdatePolicy is export := guint32;
our enum GimpSizeEntryUpdatePolicyEnum is export <
  GIMP_SIZE_ENTRY_UPDATE_NONE
  GIMP_SIZE_ENTRY_UPDATE_SIZE
  GIMP_SIZE_ENTRY_UPDATE_RESOLUTION
>;

constant GimpSizeType is export := guint32;
our enum GimpSizeTypeEnum is export <
  GIMP_PIXELS
  GIMP_POINTS
>;

constant GimpStackTraceMode is export := guint32;
our enum GimpStackTraceModeEnum is export <
  GIMP_STACK_TRACE_NEVER
  GIMP_STACK_TRACE_QUERY
  GIMP_STACK_TRACE_ALWAYS
>;

constant GimpStrokeMethod is export := guint32;
our enum GimpStrokeMethodEnum is export <
  GIMP_STROKE_LINE
  GIMP_STROKE_PAINT_METHOD
>;

constant GimpTextDirection is export := guint32;
our enum GimpTextDirectionEnum is export <
  GIMP_TEXT_DIRECTION_LTR
  GIMP_TEXT_DIRECTION_RTL
  GIMP_TEXT_DIRECTION_TTB_RTL
  GIMP_TEXT_DIRECTION_TTB_RTL_UPRIGHT
  GIMP_TEXT_DIRECTION_TTB_LTR
  GIMP_TEXT_DIRECTION_TTB_LTR_UPRIGHT
>;

constant GimpTextHintStyle is export := guint32;
our enum GimpTextHintStyleEnum is export <
  GIMP_TEXT_HINT_STYLE_NONE
  GIMP_TEXT_HINT_STYLE_SLIGHT
  GIMP_TEXT_HINT_STYLE_MEDIUM
  GIMP_TEXT_HINT_STYLE_FULL
>;

constant GimpTextJustification is export := guint32;
our enum GimpTextJustificationEnum is export <
  GIMP_TEXT_JUSTIFY_LEFT
  GIMP_TEXT_JUSTIFY_RIGHT
  GIMP_TEXT_JUSTIFY_CENTER
  GIMP_TEXT_JUSTIFY_FILL
>;

constant GimpThumbError is export := guint32;
our enum GimpThumbErrorEnum is export <
  GIMP_THUMB_ERROR_OPEN
  GIMP_THUMB_ERROR_OPEN_ENOENT
  GIMP_THUMB_ERROR_MKDIR
>;

constant GimpThumbFileType is export := guint32;
our enum GimpThumbFileTypeEnum is export <
  GIMP_THUMB_FILE_TYPE_NONE
  GIMP_THUMB_FILE_TYPE_REGULAR
  GIMP_THUMB_FILE_TYPE_FOLDER
  GIMP_THUMB_FILE_TYPE_SPECIAL
>;

constant GimpThumbSize is export := guint32;
our enum GimpThumbSizeEnum is export <
  GIMP_THUMB_SIZE_FAIL
  GIMP_THUMB_SIZE_NORMAL
  GIMP_THUMB_SIZE_LARGE
>;

constant GimpThumbState is export := guint32;
our enum GimpThumbStateEnum is export <
  GIMP_THUMB_STATE_UNKNOWN
  GIMP_THUMB_STATE_REMOTE
  GIMP_THUMB_STATE_FOLDER
  GIMP_THUMB_STATE_SPECIAL
  GIMP_THUMB_STATE_NOT_FOUND
  GIMP_THUMB_STATE_EXISTS
  GIMP_THUMB_STATE_OLD
  GIMP_THUMB_STATE_FAILED
  GIMP_THUMB_STATE_OK
>;

constant GimpTransferMode is export := guint32;
our enum GimpTransferModeEnum is export <
  GIMP_TRANSFER_SHADOWS
  GIMP_TRANSFER_MIDTONES
  GIMP_TRANSFER_HIGHLIGHTS
>;

constant GimpTransformDirection is export := guint32;
our enum GimpTransformDirectionEnum is export <
  GIMP_TRANSFORM_FORWARD
  GIMP_TRANSFORM_BACKWARD
>;

constant GimpTransformResize is export := guint32;
our enum GimpTransformResizeEnum is export <
  GIMP_TRANSFORM_RESIZE_ADJUST
  GIMP_TRANSFORM_RESIZE_CLIP
  GIMP_TRANSFORM_RESIZE_CROP
  GIMP_TRANSFORM_RESIZE_CROP_WITH_ASPECT
>;

constant GimpUnit is export := guint32;
our enum GimpUnitEnum is export <
  GIMP_UNIT_PIXEL
  GIMP_UNIT_INCH
  GIMP_UNIT_MM
  GIMP_UNIT_POINT
  GIMP_UNIT_PICA
  GIMP_UNIT_END
  GIMP_UNIT_PERCENT
>;

constant GimpVectorsStrokeType is export := guint32;
our enum GimpVectorsStrokeTypeEnum is export <
  GIMP_VECTORS_STROKE_TYPE_BEZIER
>;

constant GimpWidgetsError is export := guint32;
our enum GimpWidgetsErrorEnum is export <
  GIMP_WIDGETS_PARSE_ERROR
>;

constant GimpZoomType is export := guint32;
our enum GimpZoomTypeEnum is export <
  GIMP_ZOOM_IN
  GIMP_ZOOM_OUT
  GIMP_ZOOM_IN_MORE
  GIMP_ZOOM_OUT_MORE
  GIMP_ZOOM_IN_MAX
  GIMP_ZOOM_OUT_MAX
  GIMP_ZOOM_TO
  GIMP_ZOOM_SMOOTH
  GIMP_ZOOM_PINCH
>;

use NativeCall;

use GLib::Raw::Subs;

class GIMP::Enums::ThumbState {

  method get_type {
    sub gimp_thumb_state_get_type
      returns GType
      is native(gimpthumb)
    { * }

    state ($n, $t);

    unstable_get_type( self.^name, &gimp_thumb_state_get_type, $n, $t );
  }

}
