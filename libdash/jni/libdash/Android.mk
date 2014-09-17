LOCAL_PATH:= $(call my-dir)

#######################################
# DASH
include $(CLEAR_VARS)

LOCAL_MODULE := dash

Helper_SRC_FILES 	:= $(notdir $(wildcard $(LOCAL_PATH)/source/helpers/*.cpp))
Manager_SRC_FILES 	:= $(notdir $(wildcard $(LOCAL_PATH)/source/manager/*.cpp))
Metrics_SRC_FILES 	:= $(notdir $(wildcard $(LOCAL_PATH)/source/metrics/*.cpp))
Mpd_SRC_FILES 		:= $(notdir $(wildcard $(LOCAL_PATH)/source/mpd/*.cpp))
Network_SRC_FILES 	:= $(notdir $(wildcard $(LOCAL_PATH)/source/network/*.cpp))
Portable_SRC_FILES 	:= $(notdir $(wildcard $(LOCAL_PATH)/source/portable/*.cpp))
Xml_SRC_FILES 		:= $(notdir $(wildcard $(LOCAL_PATH)/source/xml/*.cpp))

LOCAL_SRC_FILES := \
	$(addprefix source/helpers/, $(Helper_SRC_FILES)) \
	$(addprefix source/manager/, $(Manager_SRC_FILES)) \
	$(addprefix source/metrics/, $(Metrics_SRC_FILES)) \
	$(addprefix source/mpd/, $(Mpd_SRC_FILES)) \
	$(addprefix source/network/, $(Network_SRC_FILES)) \
	$(addprefix source/portable/, $(Portable_SRC_FILES)) \
	$(addprefix source/xml/, $(Xml_SRC_FILES))

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/source/helpers \
	$(LOCAL_PATH)/source/manager \
	$(LOCAL_PATH)/source/metrics \
	$(LOCAL_PATH)/source/mpd \
	$(LOCAL_PATH)/source/portable \
	$(LOCAL_PATH)/source/xml \
	$(LOCAL_PATH)/../libcurl/include \
	$(LOCAL_PATH)/../libxml2/include \


LOCAL_STATIC_LIBRARIES := libxml2 libcurl

LOCAL_LDLIBS := -lz -llog

include $(BUILD_SHARED_LIBRARY)
#######################################
