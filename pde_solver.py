import solvers.pde_solver as pde_solver
import numpy as np


def solve_wave_equation(
    initial_condition: np.ndarray,
    steps: tuple[float],
    max_time: float,
    type: str,
    velocity: float = 1.
) -> np.ndarray:
    length = int(max_time/steps[0])
    ic_len = len(initial_condition)
    if type == "free":
        array = pde_solver.solver.free_wave_equation_1d(
            ic=initial_condition,
            c=velocity,
            sol_len=length,
            delta_t=steps[1],
            delta_x=steps[0],
            ic_len=ic_len,
        )
    return array
