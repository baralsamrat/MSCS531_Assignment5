import numpy as np

# Simulating a vector processing task (element-wise multiplication)
vector1 = np.array([1, 2, 3, 4, 5, 6, 7, 8])
vector2 = np.array([2, 4, 6, 8, 10, 12, 14, 16])

# Vectorized multiplication
def vector_multiplication(v1, v2):
    return np.multiply(v1, v2)

result = vector_multiplication(vector1, vector2)
print("Vector Multiplication Result:", result)

# Array and scalar value for SIMD-style scaling
data = np.array([10, 20, 30, 40])
scale_factor = 2

# SIMD-style scaling operation (element-wise multiplication)
scaled_data = data * scale_factor
print("Scaled Data:", scaled_data)
