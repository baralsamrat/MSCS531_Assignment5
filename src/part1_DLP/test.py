import numpy as np
import time

# Function for vector addition
def vector_addition(vector1, vector2):
    return np.add(vector1, vector2)

# Generate large vectors to test performance
v1 = np.random.rand(1000000)  # One million elements
v2 = np.random.rand(1000000)

# Measure execution time
start_time = time.time()
result = vector_addition(v1, v2)
end_time = time.time()

print("Vector Addition Result (first 10 elements):", result[:10])
print("Execution Time:", end_time - start_time, "seconds")
