#include <cuda_runtime.h>
#include <iostream>

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
    int n = 16;
    float a[n * n], b[n * n], result[n * n];
    // Initialize 'a' and 'b' with values here

    float *d_a, *d_b, *d_result;
    cudaMalloc(&d_a, n * n * sizeof(float));
    cudaMalloc(&d_b, n * n * sizeof(float));
    cudaMalloc(&d_result, n * n * sizeof(float));

    cudaMemcpy(d_a, a, n * n * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, n * n * sizeof(float), cudaMemcpyHostToDevice);

    dim3 threadsPerBlock(n, n);
    matrixMultiply<<<1, threadsPerBlock>>>(d_a, d_b, d_result, n);

    cudaMemcpy(result, d_result, n * n * sizeof(float), cudaMemcpyDeviceToHost);
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_result);

    std::cout << "Matrix Multiplication Result:" << std::endl;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            std::cout << result[i * n + j] << " ";
        }
        std::cout << std::endl;
    }

    return 0;
}
