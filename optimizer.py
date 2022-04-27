import simple_numerical_package.fortran_bins.optimizer as optimizer
import numpy as np


def simple_fit(array: np.ndarray, type: str = "linear") -> tuple[np.ndarray]:
    """
        A simple and fast linear, and log, 1d fit
        array is an (2, n) shaped array, with x on (0, :) and y on (1, :)
        type is the selected fit,
            "linear" is the classical y = a*x + b
            "log" is for functions like y = b * x^a
        returns a tuple of the results and errors, on the order [a, b]
    """
    if type == "linear":
        result = optimizer.optimizer.linear_least_squares(
            matrix=array, n=array.shape[1])
    elif type == "log":
        init_array = np.log(array)
        result = optimizer.optimizer.linear_least_squares(
            matrix=init_array, n=array.shape[1])
    return result[0], result[1]
