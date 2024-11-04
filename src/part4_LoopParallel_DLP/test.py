from joblib import Parallel, delayed
import time

# Sample processing function
def process_element(i):
    return i ** 2

# Sequential execution
start_time = time.time()
sequential_results = [process_element(i) for i in range(10000)]
end_time = time.time()
print("Sequential Execution Time:", end_time - start_time, "seconds")

# Parallel execution
start_time = time.time()
parallel_results = Parallel(n_jobs=4)(delayed(process_element)(i) for i in range(10000))
end_time = time.time()
print("Parallel Execution Time:", end_time - start_time, "seconds")
