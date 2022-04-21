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
    """
        Solution to 1d wave equation, initial_condition is an 1d array of floats,
        initial_velocities is an 1d array of floats,
        constant is the speed constant (wave speed, light speed, etc),
        steps is an tuple of the format (dx, dt, ), remember to always put dt < 100*c²/dx²,
        max_time is the max time for the solution, remember to scale with dt to allocate enough memory,
        type is the type of the solution, "free" is the solution with two free edges, "closed" is the solution with two unmovable edges
    """
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
    elif type == "closed":
        array = pde_solver.solver.closed_wave_equation_1d(
            ic=initial_condition,
            iv=initial_velocities,
            c=constant,
            sol_len=length,
            delta_x=steps[0],
            delta_t=steps[1],
            ic_len=ic_len,
        )
    return array.T


def solve_heat_equation(
    initial_condition: np.ndarray,
    steps: tuple[float],
    max_time: float,
    type: str,
    constant: float = 1.
) -> np.ndarray:
    """
        Solution to 1d heat equation, initial_condition is an 1d array of floats,
        constant is the dissipation constant,
        steps is an tuple of the format (dx, dt, ), remember to always put dt < 100*c/dx²,
        max_time is the max time for the solution, remember to scale with dt to allocate enough memory,
        type is the type of the solution, "free" is the solution with two free edges, "closed" is the solution with two unmovable edges
    """
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
    elif type == "closed":
        array = pde_solver.solver.closed_heat_equation_1d(
            ic=initial_condition,
            c=constant,
            sol_len=length,
            delta_x=steps[0],
            delta_t=steps[1],
            ic_len=ic_len,
        )
    return array.T


def solve_transport_equation(
    initial_condition: np.ndarray,
    steps: tuple[float],
    max_time: float,
    type: str,
    constant: float = 1.
) -> np.ndarray:
    """
        Solution to 1d transport equation, initial_condition is an 1d array of floats,
        constant is the speed constant,
        steps is an tuple of the format (dx, dt, ), remember to always put dt < 100*c/dx²,
        max_time is the max time for the solution, remember to scale with dt to allocate enough memory,
        type is the type of the solution, "free" is the solution with two free edges, "closed" is the solution with two unmovable edges
    """
    length = int(max_time/steps[1])
    ic_len = len(initial_condition)
    if type == "free":
        array = pde_solver.solver.free_transport_equation_1d(
            ic=initial_condition,
            c=constant,
            sol_len=length,
            delta_x=steps[0],
            delta_t=steps[1],
            ic_len=ic_len,
        )
    elif type == "closed":
        array = pde_solver.solver.closed_transport_equation_1d(
            ic=initial_condition,
            c=constant,
            sol_len=length,
            delta_x=steps[0],
            delta_t=steps[1],
            ic_len=ic_len,
        )
    return array.T
