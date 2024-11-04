from joblib import Parallel, delayed

# Function to process an element (e.g., squaring)
def process_element(i):
    return i * i

# Parallel execution with 4 jobs
results = Parallel(n_jobs=4)(delayed(process_element)(i) for i in range(10))
print("Processed results:", results)

