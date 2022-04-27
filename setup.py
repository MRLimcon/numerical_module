from numpy.distutils.misc_util import Configuration
from numpy.distutils.core import setup as setup
from numpy.distutils.core import Extension

ext_modules = [
    Extension("simple_numerical_package.fortran_bins.create_array",
              sources=['arrays/create_array.f95']),
    Extension("simple_numerical_package.fortran_bins.array_operations",
              sources=['arrays/operations.f95']),
    Extension("simple_numerical_package.fortran_bins.pde_solver",
              sources=['solvers/pde_solver.f95']),
    Extension("simple_numerical_package.fortran_bins.optimizer",
              sources=['solvers/optimizer.f95']),
]


def configuration(parent_package='', top_path=None):
    config = Configuration('simple_numerical_package')
    return config


setup(
    name='simple_numerical_package',
    version='0.0.1',
    author='MRLimcon',
    scripts=[
        'array_module.py',
        'dataframe_utils.py',
        'pde_solver.py',
        'optimizer.py'
    ],
    url='https://github.com/MRLimcon/numerical_module',
    license='LICENSE.txt',
    description='A simple and fast numerical package.',
    long_description=open('readme.md').read(),
    configuration=configuration,
    ext_modules=ext_modules,
    install_requires=[
       "numpy",
       "scipy",
       "pandas"
    ]
)
