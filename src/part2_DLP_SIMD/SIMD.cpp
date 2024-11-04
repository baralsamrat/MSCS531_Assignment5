#include <immintrin.h>
#include <iostream>

void simd_add(float* a, float* b, float* result, int size) {
    for (int i = 0; i < size; i += 8) {
        __m256 vec1 = _mm256_loadu_ps(&a[i]);
        __m256 vec2 = _mm256_loadu_ps(&b[i]);
        __m256 sum = _mm256_add_ps(vec1, vec2);
        _mm256_storeu_ps(&result[i], sum);
    }
}

int main() {
    float a[8] = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0};
    float b[8] = {8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0};
    float result[8];

    simd_add(a, b, result, 8);

    std::cout << "SIMD Addition Result: ";
    for (int i = 0; i < 8; ++i) {
        std::cout << result[i] << " ";
    }
    std::cout << std::endl;

    return 0;
}
