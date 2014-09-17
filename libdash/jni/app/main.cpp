#include <jni.h>
#include <android/log.h>

#include "libdash_networkpart_test.h"
// #include "libdash_segmentpart_test.h"

#define  LOG_TAG    "main"
#define  LOGD(...)  __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)
#define  LOGI(...)  __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define  LOGE(...)  __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

NetworkTest *nTest = NULL;
// SegmentTest *sTest = NULL;

extern "C" JNIEXPORT jboolean JNICALL
Java_com_example_libdash_MainActivity_NetworkTest (JNIEnv * env, jobject obj) {
	nTest = new NetworkTest();
	if (nTest == NULL) return false;

	delete nTest;
	nTest = NULL;

	return true;
}

// extern "C" JNIEXPORT jboolean JNICALL
// Java_com_example_libdash_MainActivity_SegmentTest (JNIEnv * env, jobject obj) {
// 	sTest = new SegmentTest();
// 	return true;
// }