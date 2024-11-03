from joblib import Parallel, delayed
import numpy as np

# Function to process an element
def process_element(i):
    return i * i

# Array of elements to process
elements = np.arange(1, 11)

# Process elements in parallel
results = Parallel(n_jobs=4)(delayed(process_element)(i) for i in elements)
print("Processed results:", results)
