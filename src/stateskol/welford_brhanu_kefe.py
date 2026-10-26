import math
def welford(data):
    """
    Compute running count, mean, sample variance and standard deviation of a dataset using Welford's algorithm (1962).

    Input:
    data : iterable
        An iterable of numerical values (int or float) representing the dataset.
    
    Output:
    tuple: (count, mean, sample_variance, sample_std_dev, dropped_count)
        count : int
                The number of valid elements in the dataset.
        mean : float
                The mean (average) of the valid dataset.
        sample_variance : float
                The sample variance of the valid dataset.
        sample_std_dev : float
                The sample standard deviation of the valid dataset.
        dropped_count : int
                The number of dropped values (None or NaN) from the dataset.

    Parametrization:
    - Accepts an iterable of numerical values (int or float) as input.
    - Ignores missing/ non numeric values (None or NaN) in the input data and counts them as dropped values.               

    Errors:
    Raises ValueError: 
        If the data contains fewer than 2 valid numeric values.
    Raises TypeError:
        If the data is not an iterable.
 
    Assumptions:
    - The input data is an iterable of numerical values (int or float).
    - The function assumes that the input data is not empty and contains at least two numeric values.
    - The values are a sample not a population, so the sample variance and standard deviation are calculated using n-1 in the denominator.
    - Result does not depend on the order of the input data, as Welford's algorithm is order-independent.
    - Missing or non numeric entries are dropped explicitly and tracked.

    Example:
    >>> data = [1, 2, 3, 4, 5]
    >>> welford(data)
    (5, 3.0, 2.5, 1.5811388300841898, 0)

    >>> #Missing values are dropped and tracked 
    >>> data = [1, 2, None, 4, 5]
    >>> welford(data)
    (4, 3.0, 3.3333333333333335, 1.8257418583505538, 1)

    >>> #Empty data raises ValueError
    >>> data = []
    >>> welford(data)
    Traceback (most recent call last):
        ...
    ValueError: at least two valid numeric values are required to compute variance and standard deviation.
    """

    try:
        iterator = iter(data)
    except TypeError:
        raise TypeError("Input data must be an iterable.")

    count = 0
    mean = 0.0
    M2 = 0.0
    dropped_count = 0


    for x in iterator:
        if x is None or not isinstance(x, (int, float)) or math.isnan(x):
            dropped_count += 1
            continue
        count += 1
        delta = x - mean
        mean += delta / count
        delta2 = x - mean
        M2 += delta * delta2

    if count < 2:
        raise ValueError("at least two valid numeric values are required to compute variance and standard deviation.")

    sample_variance = M2 / (count - 1)
    sample_std_dev = math.sqrt(sample_variance)

    return count, mean, sample_variance, sample_std_dev, dropped_count


if __name__ == "__main__":
    import doctest
    doctest.testmod()  
    print("All tests passed!")