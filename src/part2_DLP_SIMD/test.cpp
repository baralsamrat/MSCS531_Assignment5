#include <immintrin.h>
#include <iostream>
#include <chrono>

void scalar_add(float* a, float* b, float* result, int size) {
    for (int i = 0; i < size; i++) {
        result[i] = a[i] + b[i];
    }
}

void simd_add(float* a, float* b, float* result, int size) {
    for (int i = 0; i < size; i += 8) {
        __m256 vec1 = _mm256_loadu_ps(&a[i]);
        __m256 vec2 = _mm256_loadu_ps(&b[i]);
        __m256 sum = _mm256_add_ps(vec1, vec2);
        _mm256_storeu_ps(&result[i], sum);
    }
}

int main() {
    const int size = 8000000;  // Eight million elements
    float a[size], b[size], result[size];

    // Initialize arrays
    for (int i = 0; i < size; i++) {
        a[i] = i * 1.0f;
        b[i] = i * 2.0f;
    }

    // Scalar addition
    auto start = std::chrono::high_resolution_clock::now();
    scalar_add(a, b, result, size);
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<float> duration = end - start;
    std::cout << "Scalar Addition Time: " << duration.count() << " seconds\n";

    // SIMD addition
    start = std::chrono::high_resolution_clock::now();
    simd_add(a, b, result, size);
    end = std::chrono::high_resolution_clock::now();
    duration = end - start;
    std::cout << "SIMD Addition Time: " << duration.count() << " seconds\n";

    return 0;
}
