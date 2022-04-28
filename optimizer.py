import simple_numerical_package.fortran_bins.optimizer as optimizer
import numpy as np


def simple_fit(x: np.ndarray, y: np.ndarray, type: str = "linear") -> tuple[np.ndarray]:
    """
        A simple and fast linear, and log, 1d fit
        x and y are 1d arrays of the same size
        type is the selected fit,
            "linear" is the classical y = a*x + b
            "log" is for functions like y = b * x^a
        returns a tuple of the results and errors, on the order [a, b]
    """
    if type == "linear":
        result = optimizer.optimizer.linear_least_squares(
            x=x, y=y, n=len(x))
    elif type == "log":
        new_x = np.log(x)
        new_y = np.log(y)
        result = optimizer.optimizer.linear_least_squares(
            x=new_x, y=new_y, n=len(x))
        result[:, 1] = np.exp(result[:, 1])
    return result[0], result[1]
