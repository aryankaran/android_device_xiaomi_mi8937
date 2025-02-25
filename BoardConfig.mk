#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from common msm8937-common
include device/xiaomi/msm8937-common/BoardConfigCommon.mk

DEVICE_PATH := device/xiaomi/mi8937

# Asserts
TARGET_OTA_ASSERT_DEVICE := mi8937,landtoni,land,santoni,prada,ulova,ulysse,ugglite,ugg,rova,rolex,riva

# Camera
TARGET_PROCESS_SDK_VERSION_OVERRIDE := \
    /vendor/bin/land_mm-qcamera-daemon=23 \
    /vendor/bin/prada_mm-qcamera-daemon=23

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):init_xiaomi_mi8937
TARGET_RECOVERY_DEVICE_MODULES := init_xiaomi_mi8937

# Kernel
TARGET_KERNEL_CONFIG := mi8937_defconfig

# Power
TARGET_TAP_TO_WAKE_NODE := "/proc/sys/dev/dt2w"

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Security patch level
VENDOR_SECURITY_PATCH := 2019-08-01

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/biometrics/sepolicy

# Inherit from the proprietary version
include vendor/xiaomi/mi8937/BoardConfigVendor.mk

# Include system.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

