from numpy.distutils.misc_util import Configuration
from numpy.distutils.core import setup as setup
from numpy.distutils.core import Extension
import test_numerical_package


ext_modules = [
    Extension('create_array', sources=['arrays/create_array.f95']),
    Extension("array_operations", sources=['arrays/operations.f95']),
    Extension("solvers", sources=['solvers/pde_solver.f95']),
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
        'pde_solver.py'
    ],
    # url='http://pypi.python.org/pypi/PackageName/',
    license='LICENSE.txt',
    description='An awesome package that does something',
    long_description=open('readme.md').read(),
    configuration=configuration,
    ext_modules=ext_modules,
    install_requires=[
       "numpy",
       "scipy",
       "pandas"
    ]
)