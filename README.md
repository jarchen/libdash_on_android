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
1. Set two environment variables **SYSROOT** and **CC**.

    ````
    export SYSROOT=$NDK/platforms/android-14/arch-arm
    export CC="$NDK/toolchains/arm-linux-androideabi-4.6/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gcc --sysroot=$SYSROOT"
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
    1. Change `LOCAL_MODULE` (line 79) and `LOCAL_STATIC_LIBRARIES` (line 102) from `libcurl` to other name (Ex: `curl-library`).
    1. Add **$(LOCAL_PATH)/lib** to `LOCAL_C_INCLUDES` (line 73),
        
        i.e.,`LOCAL_C_INCLUDES += $(LOCAL_PATH)/include/ $(LOCAL_PATH)/lib`.
    1. Change last line `include $(BUILD_EXECUTABLE)` to `include $(BUILD_STATIC_LIBRARY)`.

### libxml2
1. Install tools for building libxml2

    ````
    sudo apt-get install autoconf libtool
    ````
1. Set two environment variables **SYSROOT** and **CC**.

    ````
    export SYSROOT=$NDK/platforms/android-14/arch-arm
    export CC="$NDK/toolchains/arm-linux-androideabi-4.6/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gcc --sysroot=$SYSROOT"
    ````
1. Configure with Android toolchain
    
    ````
    ./autogen.sh
    ./configure --with-sysroot=$SYSROOT --host=arm
    ````
1. Copy files from **${LIBXML2_SOURCE}** to **${libdash_project}/jni/libxml2**

    ````
    find . -maxdepth 1 -name "*.[c|h]" -exec cp {} ${libdash_project}/jni/libxml2/ \;
    ````
1. Create Android.mk for libxml2 under **${libdash_project}/jni/libxml2/**. This makefile very simple, just include all .c and .h files and build for **STATIC_LIBRARY**.

### libdash
1. Copy files into **${libdash_project}/jni/libdash/**

    ````
    cp -r ${LIBDASH_SOURCE}/libdash/libdash/include ${libdash_project}/jni/libdash/
    cp -r ${LIBDASH_SOURCE}/libdash/libdash/source ${libdash_project}/jni/libdash/
    ````
1. Create Android.mk for libdash under **${libdash_project}/jni/libdash/**. 

There are the some files under **${LIBDASH_SOURCE}/libdash/qtsampleplayer**, such as libdashframework, and DASH manager. You can resue them if you need.

### Building shared library for Android
1. Create makefiles, Android.mk and Application.mk for ndk buiding.
    1. **Android.mk** only one line `include $(call all-subdir-makefiles)`. It means to find makefile for each subdirectory.
    1. **Application.mk** defined two variables `APP_STL` and `APP_ABI`.
1. Bulding by NDK tool.

    ````
    cd ${libdash_project}/
    ${NDK}/ndk-build
    ````
    After building, you will get the libdash.so.
    
### Examples for libcurl (Optional)
I create a folder for testing, called **app**. After building, you will get two shared libraries (i.e., .so file), libdash.so and libapp.so.
Reference to **${libdash_project}/jni/app/libdash_networkpart_test.cpp**
