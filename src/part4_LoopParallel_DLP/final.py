from joblib import Parallel, delayed
import multiprocessing
import time

# Detect available cores
num_cores = multiprocessing.cpu_count()

# Function with error handling
def process_element_with_error_handling(i):
    try:
        return i ** 2
    except Exception as e:
        return f"Error: {e}"

# Timing sequential execution
start_time = time.time()
sequential_results = [process_element_with_error_handling(i) for i in range(10000)]
end_time = time.time()
print("Sequential Execution Time:", end_time - start_time, "seconds")

# Timing parallel execution
start_time = time.time()
parallel_results = Parallel(n_jobs=num_cores)(delayed(process_element_with_error_handling)(i) for i in range(10000))
end_time = time.time()
print("Parallel Execution Time:", end_time - start_time, "seconds")
