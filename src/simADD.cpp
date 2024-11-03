// Run: g++ -mavx simADD.cpp -o simADD

#include <immintrin.h> // For AVX instructions
#include <iostream>

void simADD(float* a, float* b, float* result, int size) {
    for (int i = 0; i < size; i += 8) {
        // Load 8 floats from each array into AVX registers
        __m256 vec1 = _mm256_loadu_ps(&a[i]);
        __m256 vec2 = _mm256_loadu_ps(&b[i]);
        
        // Perform SIMD addition
        __m256 sum = _mm256_add_ps(vec1, vec2);
        
        // Store result in result array
        _mm256_storeu_ps(&result[i], sum);
    }
}

int main() {
    const int size = 8;
    float a[size] = {1, 2, 3, 4, 5, 6, 7, 8};
    float b[size] = {8, 7, 6, 5, 4, 3, 2, 1};
    float result[size];

    simADD(a, b, result, size);

    std::cout << "Result of SIMD addition: ";
    for (int i = 0; i < size; ++i) {
        std::cout << result[i] << " ";
    }
    std::cout << std::endl;

    return 0;
}
