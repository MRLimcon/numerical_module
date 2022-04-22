# simple_numerical_module
## The FORTRAN Intrinsics In Python

  A project trying to bring fast implementations of usual, but slow functions.

# Dependencies
- gcc (gfortran) or MSVC (ifortran)
- Numpy
- Pandas

# Installation
- Clone this repo: `git clone https://github.com/MRLimcon/numerical_module.git`
- Enter the folder, build and install:
  - `cd numerical_module && python setup.py build && sudo python setup.py install`

# Using this module
- Import the main files:
  - array_module.py: `import simple_numerical_module.array_module as simple_array_module`
  - pde_solver.py: `import simple_numerical_module.pde_solver as simple_pde_solver`
  - dataframe_utils.py: `import simple_numerical_module.dataframe_utils as simple_dataframe_utils`
- Explore the built functions

# Warning
- This repo is still in development and other functions are going to be added
- Feel free to suggest new functions!
