from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent.parent/"src"))

import numpy as np
from stateskol.welford_brhanu_kefe import welford

def run_numpy_comparison():
    print("=========================================")
    print(" Welford vs Numpy controlled comparison  ")
    print("=========================================\n")

    data = [2, 4, 4, 4, 5, 5, 7, 9]

    ATOL = 1e-9

    count, mean, sample_variance, sample_std_dev, dropped_count = welford(data)

    np_arr=np.array(data)
    np_mean = float(np.mean(np_arr))
    np_sample_variance = float(np.var(np_arr, ddof=1))
    np_sample_std_dev = float(np.std(np_arr, ddof=1))

    mean_match = np.isclose(mean, np_mean, atol=ATOL)
    variance_match = np.isclose(sample_variance, np_sample_variance, atol=ATOL)
    std_dev_match = np.isclose(sample_std_dev, np_sample_std_dev, atol=ATOL)

    print(f"Dataset: {data}")
    print(f"Absolute Tolerance : {ATOL}\n")
    print(f"{'Metric':<20} | {'Welford':<15} | {'Numpy (ddof=1)':<15} | {'Match?'}")
    print("-" * 65)
    print(f"{'Mean':<20} | {mean:<15.6f} | {np_mean:<15.6f} | {mean_match}")
    print(f"{'Sample Variance':<20} | {sample_variance:<15.6f} | {np_sample_variance:<15.6f} | {variance_match}")
    print(f"{'Sample Std Dev':<20} | {sample_std_dev:<15.6f} | {np_sample_std_dev:<15.6f} | {std_dev_match}")
    print(f"\n========================================")



def run_numerical_stability_test():

    print("=========================================")
    print(" Numerical Stability Test for Welford's Algorithm ")
    print("=========================================\n")
    
    base = 1e9
    large_dataset = [base+ 1.0, base + 2.0, base + 3.0]    
    true_variance = 1.0

    def naive_variance(data):
        n = len(data)
        sum_data = sum(data)
        sum_sq_data = sum(x ** 2 for x in data)
        return (sum_sq_data - (sum_data ** 2) / n) / (n - 1)
    naive_result = naive_variance(large_dataset)
    _, _, welford_variance, _, _ = welford(large_dataset)
    np_variance = float(np.var(large_dataset, ddof=1))

    print(f"Dataset: [10^9 + 1, 10^9 + 2, 10^9 + 3]")
    print(f"True Sample Variance: {true_variance:.6f}\n")
    print(f"{'Method':<25} | {'Calculated Variance':<20} | {'Absolute Error':<15}")
    print("-" * 65)
    print(f"{'Naive (Two-Pass Formula)':<25} | {naive_result:<20.6f} | {abs(naive_result - true_variance):<15.6e}")
    print(f"{'Welford Algorithm':<25} | {welford_variance:<20.6f} | {abs(welford_variance - true_variance):<15.6e}")
    print(f"{'NumPy (ddof=1)':<25} | {np_variance:<20.6f} | {abs(np_variance - true_variance):<15.6e}")
    print()


def main():
    print("==================================================")
    print("  WELFORD'S ALGORITHM REFERENCE DEMO              ")
    print("==================================================\n")

    run_numpy_comparison()
    run_numerical_stability_test()

    print("==================================================")


if __name__ == "__main__":
    main()