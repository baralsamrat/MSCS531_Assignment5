import numpy as np
import time

# Optimized vector addition function with error checking
def vector_addition_safe(v1, v2):
    if len(v1) != len(v2):
        raise ValueError("Vectors must be of the same length")
    return np.add(v1, v2)

# Test with large vectors
size = 1000000  # Large size for performance testing
v1 = np.random.rand(size)
v2 = np.random.rand(size)

# Timing the optimized vector addition
start_time = time.time()
result = vector_addition_safe(v1, v2)
end_time = time.time()

print("First 10 elements of Vector Addition Result:", result[:10])
print("Execution Time:", end_time - start_time, "seconds")
