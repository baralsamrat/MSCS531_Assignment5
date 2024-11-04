#include <cuda_runtime.h>
#include <iostream>

__global__ void matrixMultiplyOptimized(float *a, float *b, float *result, int n) {
    __shared__ float sharedA[16][16];
    __shared__ float sharedB[16][16];

    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    float sum = 0;

    for (int i = 0; i < n / 16; i++) {
        sharedA[threadIdx.y][threadIdx.x] = a[row * n + (i * 16 + threadIdx.x)];
        sharedB[threadIdx.y][threadIdx.x] = b[(i * 16 + threadIdx.y) * n + col];
        __syncthreads();

        for (int k = 0; k < 16; k++) {
            sum += sharedA[threadIdx.y][k] * sharedB[k][threadIdx.x];
        }
        __syncthreads();
    }

    result[row * n + col] = sum;
}

int main() {
    int n = 1024;
    float *a, *b, *result;
    size_t size = n * n * sizeof(float);

    cudaMallocManaged(&a, size);
    cudaMallocManaged(&b, size);
    cudaMallocManaged(&result, size);

    for (int i = 0; i < n * n; ++i) {
        a[i] = 1.0f; 
        b[i] = 2.0f;
    }

    dim3 threadsPerBlock(16, 16);
    dim3 blocksPerGrid(n / threadsPerBlock.x, n / threadsPerBlock.y);

    matrixMultiplyOptimized<<<blocksPerGrid, threadsPerBlock>>>(a, b, result, n);
    cudaDeviceSynchronize();

    cudaFree(a);
    cudaFree(b);
    cudaFree(result);

    return 0;
}
