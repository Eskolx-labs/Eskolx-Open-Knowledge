import math
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "src"))

import pytest
from stateskol.welford_brhanu_kefe import welford

def test_hand_worked_results():
    data=[2, 4, 4, 4, 5, 5, 7, 9]
    count, mean, sample_variance, sample_std_dev, dropped_count = welford(data)

    assert count == 8
    assert math.isclose(mean, 5)
    assert math.isclose(sample_variance, 32/7)
    assert math.isclose(sample_std_dev, math.sqrt(32/7))
    assert dropped_count == 0


def test_empty_boundary_case():
    with pytest.raises(ValueError):
        welford([])

def test_single_value_boundary_case():
    with pytest.raises(ValueError):
        welford([42])

def test_constant_values_case():
    data = [3, 3, 3, 3, 3]
    count, mean, sample_variance, sample_std_dev, dropped_count = welford(data)

    assert count == 5
    assert math.isclose(mean, 3.0)
    assert math.isclose(sample_variance, 0.0)
    assert math.isclose(sample_std_dev, 0.0)
    assert dropped_count == 0

def test_non_numeric_values_case():
    data = [1, 2, None, 4, 5]
    count, mean, sample_variance, sample_std_dev, dropped_count = welford(data)

    assert count == 4
    assert math.isclose(mean, 3.0)
    assert math.isclose(sample_variance, 3.3333333333333335)
    assert math.isclose(sample_std_dev, 1.8257418583505538)
    assert dropped_count == 1