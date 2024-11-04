#include <stdio.h>
#define N 16  // Define matrix size

// CUDA kernel for matrix multiplication
__global__ void matrixMulKernel(float *a, float *b, float *c, int n) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    
    if (row < n && col < n) {
        float sum = 0;
        for (int k = 0; k < n; k++) {
            sum += a[row * n + k] * b[k * n + col];
        }
        c[row * n + col] = sum;
    }
}

int main() {
    int size = N * N * sizeof(float);
    float a[N * N], b[N * N], c[N * N];
    float *d_a, *d_b, *d_c;

    // Initialize input matrices with some values
    for (int i = 0; i < N * N; i++) {
        a[i] = i;
        b[i] = i;
    }

    cudaMalloc((void **)&d_a, size);
    cudaMalloc((void **)&d_b, size);
    cudaMalloc((void **)&d_c, size);

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

    dim3 threadsPerBlock(16, 16);
    dim3 blocksPerGrid((N + 15) / 16, (N + 15) / 16);

    matrixMulKernel<<<blocksPerGrid, threadsPerBlock>>>(d_a, d_b, d_c, N);

    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

    printf("Result of matrix multiplication:\n");
    for (int i = 0; i < N * N; i++) {
        printf("%0.2f ", c[i]);
        if ((i + 1) % N == 0) printf("\n");
    }

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}
