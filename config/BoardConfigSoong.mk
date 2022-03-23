PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE))

# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_SOURCE \
    TARGET_KERNEL_HEADERS

SOONG_CONFIG_NAMESPACES += customVarsPlugin

SOONG_CONFIG_customVarsPlugin :=

define addVar
  SOONG_CONFIG_customVarsPlugin += $(1)
  SOONG_CONFIG_customVarsPlugin_$(1) := $$(subst ",\",$$($1))
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

SOONG_CONFIG_NAMESPACES += customGlobalVars
SOONG_CONFIG_customGlobalVars += \
    aapt_version_code \
    additional_gralloc_10_usage_bits \
    camera_needs_client_info \
    camera_needs_client_info_lib \
    disable_bluetooth_le_read_buffer_size_v2 \
    disable_bluetooth_le_set_host_feature \
    bootloader_message_offset \
    gralloc_handle_has_custom_content_md_reserved_size \
    gralloc_handle_has_reserved_size \
    needs_camera_boottime \
    target_health_charging_control_charging_path \
    target_health_charging_control_charging_enabled \
    target_health_charging_control_charging_disabled \
    target_health_charging_control_deadline_path \
    target_health_charging_control_supports_bypass \
    target_health_charging_control_supports_deadline \
    target_health_charging_control_supports_toggle \
    target_init_vendor_lib \
    target_inputdispatcher_skip_event_key \
    target_ld_shim_libs \
    target_surfaceflinger_udfps_lib \
    target_trust_usb_control_path \
    target_trust_usb_control_enable \
    target_trust_usb_control_disable \
    target_uses_prebuilt_dynamic_partitions \
    uses_legacy_fd_fbdev \
    uses_egl_display_array \
    needs_oplus_tag

SOONG_CONFIG_NAMESPACES += customNvidiaVars
SOONG_CONFIG_customNvidiaVars += \
    uses_nvidia_enhancements

SOONG_CONFIG_NAMESPACES += customQcomVars
SOONG_CONFIG_customQcomVars += \
    supports_extended_compress_format \
    uses_pre_uplink_features_netmgrd 

# Only create display_headers_namespace var if dealing with UM platforms to avoid breaking build for all other platforms
ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_customQcomVars += \
    qcom_display_headers_namespace
endif

# Soong bool variables
SOONG_CONFIG_customGlobalVars_camera_needs_client_info := $(TARGET_CAMERA_NEEDS_CLIENT_INFO)
SOONG_CONFIG_customGlobalVars_camera_needs_client_info_lib := $(TARGET_CAMERA_NEEDS_CLIENT_INFO_LIB)
SOONG_CONFIG_customGlobalVars_needs_camera_boottime := $(TARGET_CAMERA_BOOTTIME_TIMESTAMP)
SOONG_CONFIG_customGlobalVars_uses_egl_display_array := $(TARGET_USES_EGL_DISPLAY_ARRAY)
SOONG_CONFIG_customGlobalVars_target_uses_prebuilt_dynamic_partitions := $(TARGET_USES_PREBUILT_DYNAMIC_PARTITIONS)
SOONG_CONFIG_customGlobalVars_needs_oplus_tag := $(TARGET_NEEDS_OPLUS_VENDOR_TAG)
SOONG_CONFIG_customNvidiaVars_uses_nvidia_enhancements := $(NV_ANDROID_FRAMEWORK_ENHANCEMENTS)
SOONG_CONFIG_customQcomVars_supports_extended_compress_format := $(AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT)
SOONG_CONFIG_customQcomVars_uses_pre_uplink_features_netmgrd := $(TARGET_USES_PRE_UPLINK_FEATURES_NETMGRD)
SOONG_CONFIG_customGlobalVars_uses_legacy_fd_fbdev := $(TARGET_USES_LEGACY_FD_FBDEV)
SOONG_CONFIG_customGlobalVars_gralloc_handle_has_reserved_size := $(TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE)
SOONG_CONFIG_customGlobalVars_gralloc_handle_has_custom_content_md_reserved_size := $(TARGET_GRALLOC_HANDLE_HAS_CUSTOM_CONTENT_MD_RESERVED_SIZE)

# Set default values
BOOTLOADER_MESSAGE_OFFSET ?= 0
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS ?= 0
TARGET_GRALLOC_HANDLE_HAS_CUSTOM_CONTENT_MD_RESERVED_SIZE ?= false
TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE ?= false
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED ?= 1
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED ?= 0
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS ?= true
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE ?= false
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE ?= true
TARGET_INIT_VENDOR_LIB ?= vendor_init
TARGET_INPUTDISPATCHER_SKIP_EVENT_KEY ?= 0
TARGET_SURFACEFLINGER_UDFPS_LIB ?= surfaceflinger_udfps_lib
TARGET_TRUST_USB_CONTROL_PATH ?= /proc/sys/kernel/deny_new_usb
TARGET_TRUST_USB_CONTROL_ENABLE ?= 1
TARGET_TRUST_USB_CONTROL_DISABLE ?= 0

# Soong value variables
SOONG_CONFIG_customGlobalVars_aapt_version_code := $(shell date -u +%Y%m%d)
SOONG_CONFIG_customGlobalVars_additional_gralloc_10_usage_bits := $(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS)
SOONG_CONFIG_customGlobalVars_bootloader_message_offset := $(BOOTLOADER_MESSAGE_OFFSET)
SOONG_CONFIG_customGlobalVars_disable_bluetooth_le_read_buffer_size_v2 := $(TARGET_DISABLE_BLUETOOTH_LE_READ_BUFFER_SIZE_V2)
SOONG_CONFIG_customGlobalVars_disable_bluetooth_le_set_host_feature := $(TARGET_DISABLE_BLUETOOTH_LE_SET_HOST_FEATURE)
SOONG_CONFIG_customGlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
SOONG_CONFIG_customGlobalVars_target_ld_shim_libs := $(subst $(space),:,$(TARGET_LD_SHIM_LIBS))
SOONG_CONFIG_customGlobalVars_target_surfaceflinger_udfps_lib := $(TARGET_SURFACEFLINGER_UDFPS_LIB)
SOONG_CONFIG_customGlobalVars_target_health_charging_control_charging_path := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH)
SOONG_CONFIG_customGlobalVars_target_health_charging_control_charging_enabled := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED)
SOONG_CONFIG_customGlobalVars_target_health_charging_control_charging_disabled := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED)
SOONG_CONFIG_customGlobalVars_target_health_charging_control_deadline_path := $(TARGET_HEALTH_CHARGING_CONTROL_DEADLINE_PATH)
SOONG_CONFIG_customGlobalVars_target_health_charging_control_supports_bypass := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS)
SOONG_CONFIG_customGlobalVars_target_health_charging_control_supports_deadline := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE)
SOONG_CONFIG_customGlobalVars_target_health_charging_control_supports_toggle := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE)
SOONG_CONFIG_customGlobalVars_target_trust_usb_control_path := $(TARGET_TRUST_USB_CONTROL_PATH)
SOONG_CONFIG_customGlobalVars_target_trust_usb_control_enable := $(TARGET_TRUST_USB_CONTROL_ENABLE)
SOONG_CONFIG_customGlobalVars_target_trust_usb_control_disable := $(TARGET_TRUST_USB_CONTROL_DISABLE)
SOONG_CONFIG_customGlobalVars_target_inputdispatcher_skip_event_key := $(TARGET_INPUTDISPATCHER_SKIP_EVENT_KEY)

ifneq ($(filter $(QSSI_SUPPORTED_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_customQcomVars_qcom_display_headers_namespace := vendor/qcom/opensource/commonsys-intf/display
else
SOONG_CONFIG_customQcomVars_qcom_display_headers_namespace := $(QCOM_SOONG_NAMESPACE)/display
endif

ifneq ($(TARGET_USES_NQ_NFC),true)
PRODUCT_SOONG_NAMESPACES += hardware/nxp
endif #TARGET_USES_NQ_NFC
