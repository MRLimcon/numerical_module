import solvers.pde_solver as pde_solver
import numpy as np


def solve_wave_equation(
    initial_condition: np.ndarray,
    steps: tuple[float],
    max_time: float,
    type: str,
    constant: float = 1.,
    initial_velocities: np.ndarray = None,
) -> np.ndarray:
    length = int(max_time/steps[1])
    ic_len = len(initial_condition)
    if initial_velocities is None:
        initial_velocities = np.zeros([ic_len])
    if type == "free":
        array = pde_solver.solver.free_wave_equation_1d(
            ic=initial_condition,
            iv=initial_velocities,
            c=constant,
            sol_len=length,
            delta_x=steps[0],
            delta_t=steps[1],
            ic_len=ic_len,
        )
    return array


def solve_heat_equation(
    initial_condition: np.ndarray,
    steps: tuple[float],
    max_time: float,
    type: str,
    constant: float = 1.
) -> np.ndarray:
    length = int(max_time/steps[1])
    ic_len = len(initial_condition)
    if type == "free":
        array = pde_solver.solver.free_heat_equation_1d(
            ic=initial_condition,
            c=constant,
            sol_len=length,
            delta_x=steps[0],
            delta_t=steps[1],
            ic_len=ic_len,
        )
    return array
