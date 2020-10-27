OLD_LOCAL_PATH := $(LOCAL_PATH)
LOCAL_PATH := $(call my-dir)

include $(LOCAL_PATH)/../../../common.mk
include $(CLEAR_VARS)

LOCAL_HEADER_LIBRARIES := libhardware_headers
LOCAL_HEADER_LIBRARIES += media_plugin_headers
LOCAL_HEADER_LIBRARIES += ulysse_camera_common_headers

MM_CAM_FILES := \
        src/mm_camera_interface.c \
        src/mm_camera.c \
        src/mm_camera_channel.c \
        src/mm_camera_stream.c \
        src/mm_camera_thread.c \
        src/mm_camera_sock.c

ifeq ($(CAMERA_DAEMON_NOT_PRESENT), true)
else
LOCAL_CFLAGS += -DDAEMON_PRESENT
endif

# System header file path prefix
LOCAL_CFLAGS += -DSYSTEM_HEADER_PREFIX=sys

ifeq ($(strip $(TARGET_USES_ION)),true)
    LOCAL_CFLAGS += -DUSE_ION
endif

ifneq (,$(filter msm8974 msm8916 msm8226 msm8610 msm8916 apq8084 msm8084 msm8994 msm8992 msm8952 msm8937 msm8953 msm8996 msmcobalt msmfalcon, $(TARGET_BOARD_PLATFORM)))
    LOCAL_CFLAGS += -DVENUS_PRESENT
endif

ifneq (,$(filter msm8996 msmcobalt msmfalcon,$(TARGET_BOARD_PLATFORM)))
    LOCAL_CFLAGS += -DUBWC_PRESENT
endif

ifeq ($(TARGET_KERNEL_VERSION),4.9)
    LOCAL_CFLAGS += -DUSE_LEGACY_MSM_CAM_HEADERS
endif

LOCAL_CFLAGS += -D_ANDROID_ -DQCAMERA_REDEFINE_LOG

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/inc \
    $(LOCAL_PATH)/../common \
    system/media/camera/include \

LOCAL_CFLAGS += -DCAMERA_ION_HEAP_ID=ION_IOMMU_HEAP_ID
LOCAL_C_INCLUDES+= $(kernel_includes)
LOCAL_ADDITIONAL_DEPENDENCIES := $(common_deps)

ifneq (1,$(filter 1,$(shell echo "$$(( $(PLATFORM_SDK_VERSION) >= 17 ))" )))
  LOCAL_CFLAGS += -include bionic/libc/kernel/common/linux/socket.h
  LOCAL_CFLAGS += -include bionic/libc/kernel/common/linux/un.h
endif

LOCAL_CFLAGS += -Wall -Wextra -Wno-error -Wno-implicit-function-declaration

LOCAL_SRC_FILES := $(MM_CAM_FILES)

LOCAL_MODULE           := libUCcamera_interface
LOCAL_PRELINK_MODULE   := false
LOCAL_SHARED_LIBRARIES := libdl libcutils liblog libutils
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH_32 := $(TARGET_OUT_VENDOR)/lib

LOCAL_32_BIT_ONLY := $(BOARD_QTI_CAMERA_32BIT_ONLY)
include $(BUILD_SHARED_LIBRARY)

LOCAL_PATH := $(OLD_LOCAL_PATH)
