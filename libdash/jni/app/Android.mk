LOCAL_PATH := $(call my-dir)
#######################################
# JNI in this
include $(CLEAR_VARS)

LOCAL_MODULE := app

# For Test libdash
# ############################
NETWORK_TEST_SRC_FILES 	:= $(notdir $(wildcard $(LOCAL_PATH)/libdash_networkpart_test/*.cpp))
SEGMENT_TEST_SRC_FILES 	:= $(notdir $(wildcard $(LOCAL_PATH)/libdash_segmentpart_test/*.cpp))

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/../libdash/include \
	$(LOCAL_PATH)/../libdash/source/helpers \
	$(LOCAL_PATH)/../libdash/source/manager \
	$(LOCAL_PATH)/../libdash/source/metrics \
	$(LOCAL_PATH)/../libdash/source/mpd \
	$(LOCAL_PATH)/../libdash/source/network \
	$(LOCAL_PATH)/../libdash/source/protable \
	$(LOCAL_PATH)/../libdash/source/xml \
	$(LOCAL_PATH)/../libcurl/include \
	$(LOCAL_PATH)/../libxml2/include \
	$(LOCAL_PATH)/libdash_networkpart_test \
	$(LOCAL_PATH)/libdash_segmentpart_test \
	$(LOCAL_PATH)/libdash_networkpart_test

LOCAL_SRC_FILES += \
	$(addprefix libdash_networkpart_test/, $(NETWORK_TEST_SRC_FILES)) \
	main.cpp


### Need to include libdash framework first ###
# LOCAL_C_INCLUDES += $(LOCAL_PATH)/libdash_segmentpart_test
# LOCAL_SRC_FILES += $(addprefix libdash_segmentpart_test/, $(SEGMENT_TEST_SRC_FILES))

LOCAL_SHARED_LIBRARIES := dash
LOCAL_LDLIBS := -llog -lz -g

include $(BUILD_SHARED_LIBRARY)
#######################################
