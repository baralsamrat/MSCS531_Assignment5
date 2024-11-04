#include <immintrin.h>
#include <iostream>
#include <chrono>
#include <cstdlib>

// Aligned memory allocation
float* aligned_alloc(size_t alignment, size_t size) {
    void* ptr;
    if (posix_memalign(&ptr, alignment, size * sizeof(float))) throw std::bad_alloc();
    return (float*)ptr;
}

// SIMD addition with remainder handling
void simd_add(float* a, float* b, float* result, int size) {
    int simd_size = size - (size % 8);
    for (int i = 0; i < simd_size; i += 8) {
        __m256 vec1 = _mm256_load_ps(&a[i]);
        __m256 vec2 = _mm256_load_ps(&b[i]);
        __m256 sum = _mm256_add_ps(vec1, vec2);
        _mm256_store_ps(&result[i], sum);
    }
    // Handle remainder
    for (int i = simd_size; i < size; i++) {
        result[i] = a[i] + b[i];
    }
}

int main() {
    const int size = 8000000;  // Large size for testing
    float *a = aligned_alloc(32, size);
    float *b = aligned_alloc(32, size);
    float *result = aligned_alloc(32, size);

    for (int i = 0; i < size; ++i) {
        a[i] = i * 1.0f;
        b[i] = i * 2.0f;
    }

    auto start = std::chrono::high_resolution_clock::now();
    simd_add(a, b, result, size);
    auto end = std::
