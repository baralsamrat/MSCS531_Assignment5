import numpy as np

# Define two vectors for element-wise addition
v1 = np.array([1, 2, 3, 4])
v2 = np.array([5, 6, 7, 8])

# Function for vector addition leveraging DLP (SIMD capabilities)
def vector_addition(vector1, vector2):
    return np.add(vector1, vector2)

# Perform vector addition
result = vector_addition(v1, v2)
print("Vector Addition Result:", result)
