libdash on Android
==================
This project is teaching how to port libdash, which is DASH clinet, to Android device.
libdash is used libcurl and libxml2 for its dependent library, so we need to port libcurl and libxml2 on Android first.

## Environment:
* OS: Ubuntu 12.04 64-bit
* NDK verion: r9d

## Download Source Code
* libcurl download from [here](http://curl.haxx.se/download.html).
* libxml2 download by git `git clone git://git.gnome.org/libxml2`.
* libdash download by git `git clone git://github.com/bitmovin/libdash.git`.

First, we create android project by Eclipse (Ex: **${libdash_project}**).
Create libcurl, libxml2, and libdash folders under **${libdash_project}/jni/**.

### libcurl
1. Set two environment variable **SYSROOT** and **CC**.

    ````
    export SYSROOT=${NDK}/platforms/android-14/arch-arm
    export CC=”$NDK/toolchains/arm-linux-androideabi-4.6/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gcc --sysroot=$SYSROOT”
    ````
1. Run configuration with android toolchain.
 
    ````
    cd ${LIBCURL_SOURCE}/
    ./configure --with-sysroot=$SYSROOT --host=arm
    ````
1. Copy files into **${libdash_project}/jni/libcurl/**

    ````
    cp -r ${LIBCURL_SOURCE}/lib ${libdash_project}/jni/libcurl/
    cp -r ${LIBCURL_SOURCE}/src ${libdash_project}/jni/libcurl/
    cp -r ${LIBCURL_SOURCE}/include ${libdash_project}/jni/libcurl/
    ````
1. Copy **${LIBCURL_SOURCE}/packages/Android/Android.mk** to **${libdash_project}/jni/libcurl/**
1. Modify **${libdash_project}/jni/libcurl/Android.mk**
    1. Set `LOCAL_PATH := $(call my-dir)` (line 52).
    1. Change `LOCAL_MODULE := libcurl` (line 79) and `LOCAL_STATIC_LIBRARIES` (line 102) to other name (Ex: `curl-library`) 
    1. Add **$(LOCAL_PATH)/lib** to `LOCAL_C_INCLUDES` (line 73)
        
        i.e.,`LOCAL_C_INCLUDES += $(LOCAL_PATH)/include/ $(LOCAL_PATH)/lib`.
    1. Change last line `include $(BUILD_EXECUTABLE)` to `include $(BUILD_SHARED_LIBRARY)`

