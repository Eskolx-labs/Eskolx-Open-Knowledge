from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "src"))

from stateskol.welford_brhanu_kefe import welford


def main():
    print("==================================================")
    print("      STATESKOL WELFORD QUICKSTART DEMO           ")
    print("==================================================\n")

    # Example 1: Standard numeric dataset
    dataset = [2.0, 4.0, 4.0, 4.0, 5.0, 5.0, 7.0, 9.0]
    count, mean, sample_variance, sample_std_dev, dropped_count = welford(dataset)

    print("1. Standard Dataset Results:")
    print(f"   Input Dataset       : {dataset}")
    print(f"   Processed Count     : {count}")
    print(f"   Mean                : {mean:.4f}")
    print(f"   Sample Variance     : {sample_variance:.4f}")
    print(f"   Sample Std Dev      : {sample_std_dev:.4f}")
    print(f"   Dropped Items       : {dropped_count}\n")

    # Example 2: Non-numeric and invalid value filtering
    mixed_dataset = [10.0, None, 20.0, "corrupted_entry", 30.0]
    m_count, m_mean, m_sample_variance, m_sample_std_dev, m_dropped_count = welford(mixed_dataset)

    print("2. Mixed Data Handling:")
    print(f"   Input Dataset       : {mixed_dataset}")
    print(f"   Valid Entries       : {m_count}")
    print(f"   Calculated Mean     : {m_mean:.4f}")
    print(f"   Dropped Entries     : {m_dropped_count}\n")

    print("==================================================")


if __name__ == "__main__":
    main()