import arrays.create_array as create_array
import arrays.operations as array_operations
import numpy as np


def arange(min: float, max: float, delta: float) -> np.ndarray:
    length = int((max-min)/delta)
    return create_array.create_array.arange(min, length, delta)


def zeros(shape: tuple[int]) -> np.ndarray:
    if isinstance(shape, int):
        return create_array.create_array.zeros_1d(shape)
    elif len(shape) == 1:
        return create_array.create_array.zeros_1d(shape[0])
    elif len(shape) == 2:
        return create_array.create_array.zeros_2d(shape[0], shape[1])


def gaussian(avg: float, std: float, shape: tuple[int]) -> np.ndarray:
    if isinstance(shape, int):
        return create_array.create_array.rand_gaussian_1d(shape, avg, std)
    elif len(shape) == 1:
        return create_array.create_array.rand_gaussian_1d(shape[0], avg, std)
    elif len(shape) == 2:
        return create_array.create_array.rand_gaussian__2d(shape[0], shape[1], avg, std)


def meshgrid(x: np.ndarray, y: np.ndarray) -> tuple[np.ndarray]:
    array = array_operations.array_operations.meshgrid(
        x=x.T, y=y.T, lenx=len(x), leny=len(y))
    return array[:, :, 0], array[:, :, 1]


def get_vector_changes(vector: np.ndarray) -> np.ndarray:
    return array_operations.array_operations.get_vector_changes(x=vector.T, lenx=len(vector))


def random_uniform(min: float, max: float, shape: tuple[int]) -> np.ndarray:
    if isinstance(shape, int):
        return create_array.create_array.rand_uniform_1d(shape, min, max)
    elif len(shape) == 1:
        return create_array.create_array.rand_uniform_1d(shape[0], min, max)
    elif len(shape) == 2:
        return create_array.create_array.rand_uniform_2d(shape[0], shape[1], min, max)
