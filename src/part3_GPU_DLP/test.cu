#include <cuda_runtime.h>
#include <iostream>
#include <chrono>

__global__ void matrixMultiply(float *a, float *b, float *result, int n) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    float sum = 0;

    for (int i = 0; i < n; i++) {
        sum += a[row * n + i] * b[i * n + col];
    }
    result[row * n + col] = sum;
}

int main() {
    int n = 1024;  // Large matrix size
    float *a, *b, *result;
    size_t size = n * n * sizeof(float);

    // Allocate and initialize matrices
    cudaMallocManaged(&a, size);
    cudaMallocManaged(&b, size);
    cudaMallocManaged(&result, size);
    for (int i = 0; i < n * n; ++i) {
        a[i] = 1.0f; b[i] = 2.0f;
    }

    // Configure CUDA grid and block dimensions
    dim3 threadsPerBlock(16, 16);
    dim3 blocksPerGrid(n / threadsPerBlock.x, n / threadsPerBlock.y);

    auto start = std::chrono::high_resolution_clock::now();
    matrixMultiply<<<blocksPerGrid, threadsPerBlock>>>(a, b, result, n);
    cudaDeviceSynchronize();
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<float> duration = end - start;

    std::cout << "Matrix Multiplication Execution Time: " << duration.count() << " seconds\n";

    cudaFree(a);
    cudaFree(b);
    cudaFree(result);

    return 0;
}
