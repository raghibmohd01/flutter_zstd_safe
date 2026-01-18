#include "zstd/lib/zstd.h"
#include <jni.h>

extern "C" {

JNIEXPORT jbyteArray JNICALL
Java_com_example_flutter_1zstd_1safe_FlutterZstdSafePlugin_compress(
    JNIEnv *env, jobject, jbyteArray input) {

  jsize len = env->GetArrayLength(input);
  jbyte *src = env->GetByteArrayElements(input, nullptr);

  size_t maxSize = ZSTD_compressBound(len);
  jbyteArray out = env->NewByteArray(maxSize);

  jbyte *dst = env->GetByteArrayElements(out, nullptr);

  size_t compressedSize = ZSTD_compress(dst, maxSize, src, len, 3);

  env->ReleaseByteArrayElements(input, src, JNI_ABORT);

  if (ZSTD_isError(compressedSize)) {
    env->ReleaseByteArrayElements(out, dst, JNI_ABORT);
    return nullptr;
  }

  env->ReleaseByteArrayElements(out, dst, 0);

  jbyteArray finalOut = env->NewByteArray(compressedSize);
  env->SetByteArrayRegion(finalOut, 0, compressedSize, dst);

  return finalOut;
}

JNIEXPORT jbyteArray JNICALL
Java_com_example_flutter_1zstd_1safe_FlutterZstdSafePlugin_decompress(
    JNIEnv *env, jobject, jbyteArray input) {

  jsize len = env->GetArrayLength(input);
  jbyte *src = env->GetByteArrayElements(input, nullptr);

  unsigned long long const decompressedSize =
      ZSTD_getFrameContentSize(src, len);

  if (decompressedSize == ZSTD_CONTENTSIZE_ERROR ||
      decompressedSize == ZSTD_CONTENTSIZE_UNKNOWN) {
    env->ReleaseByteArrayElements(input, src, JNI_ABORT);
    return nullptr;
  }

  jbyteArray out = env->NewByteArray(decompressedSize);
  jbyte *dst = env->GetByteArrayElements(out, nullptr);

  size_t const result = ZSTD_decompress(dst, decompressedSize, src, len);

  env->ReleaseByteArrayElements(input, src, JNI_ABORT);

  if (ZSTD_isError(result)) {
    env->ReleaseByteArrayElements(out, dst, JNI_ABORT);
    return nullptr;
  }

  env->ReleaseByteArrayElements(out, dst, 0);

  return out;
}
}
