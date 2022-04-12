import arrays.create_array as create_array
import arrays.operations as array_operations
import numpy as np


def range(min: float, max: float, delta: float) -> np.ndarray:
    """
        Create range from the min, to the max, with an step of delta
    """
    length = int((max-min)/delta)
    return create_array.create_array.arange(min, length, delta)


def zeros(shape: tuple[int]) -> np.ndarray:
    """
        Create an zeroed array with the shape of the tuple
    """
    if isinstance(shape, int):
        return create_array.create_array.zeros_1d(shape)
    elif len(shape) == 1:
        return create_array.create_array.zeros_1d(shape[0])
    elif len(shape) == 2:
        return create_array.create_array.zeros_2d(shape[0], shape[1])


def repeat(obj: any, amount_of_times: int) -> np.ndarray:
    """
        Create an array of size 'amount_of_times' with the repetition of 'obj'
    """
    if isinstance(obj, str):
        array = array_operations.array_operations.repeat_string(
            string_val=obj, string_length=len(obj), length=amount_of_times)
        return [bytes(val).decode() for val in array]
    elif isinstance(obj, int):
        return array_operations.array_operations.repeat_integer(
            int_val=obj, length=amount_of_times)
    elif isinstance(obj, float):
        return array_operations.array_operations.repeat_float(
            float_val=obj, length=amount_of_times)
    elif isinstance(obj, bool):
        return array_operations.array_operations.repeat_bool(
            bool_val=obj, length=amount_of_times)


def gaussian(avg: float, std: float, shape: tuple[int]) -> np.ndarray:
    """
        Create an array with values ranging inside an gaussian distribution,
        of average of avg, standard deviation of std and an shape of shape
    """
    if isinstance(shape, int):
        return create_array.create_array.rand_gaussian_1d(shape, avg, std)
    elif len(shape) == 1:
        return create_array.create_array.rand_gaussian_1d(shape[0], avg, std)
    elif len(shape) == 2:
        return create_array.create_array.rand_gaussian__2d(shape[0], shape[1], avg, std)


def meshgrid(x: np.ndarray, y: np.ndarray) -> tuple[np.ndarray]:
    """
        Create a meshgrid of two arrays
    """
    array = array_operations.array_operations.meshgrid(
        x=x.T, y=y.T, lenx=len(x), leny=len(y))
    return array[:, :, 0], array[:, :, 1]


def get_zvalue(x: np.ndarray) -> tuple[np.ndarray, float, float]:
    """
        Transform an array into a representation of its z-values
    """
    avg = np.average(x)
    std = np.std(x)
    array = array_operations.array_operations.get_zvalue_1d(
        vector=x, lenx=len(x)
    )
    return array, avg, std


def get_derivative(vector: np.ndarray, steps: float = 1.) -> np.ndarray:
    """
        Create a vector with the derivative of the input vector,
        if you don't need the derivative per se, just the differences,
        the steps variable is optional
    """
    return array_operations.array_operations.get_vector_changes(
        x=vector.T, lenx=len(vector), steps=steps)


def get_acceleration(vector: np.ndarray, steps: float = 1.) -> np.ndarray:
    """
        Create a vector with the acceleration of the input vector,
        if you don't need the derivative per se, just the differences,
        the steps variable is optional
    """
    return array_operations.array_operations.get_acceleration_1d(
        x=vector.T, lenx=len(vector), steps=steps)


def random_uniform(min: float, max: float, shape: tuple[int]) -> np.ndarray:
    """
        Create an random array with minimum value of min and maximum value of max,
        with shape of shape
    """
    if isinstance(shape, int):
        return create_array.create_array.rand_uniform_1d(shape, min, max)
    elif len(shape) == 1:
        return create_array.create_array.rand_uniform_1d(shape[0], min, max)
    elif len(shape) == 2:
        return create_array.create_array.rand_uniform_2d(shape[0], shape[1], min, max)
