import array_module as create_array
import numpy as np
import pde_solver
# import array as arr
import time
import matplotlib.pyplot as plt

dx = 0.01
dt = 0.01
max_time = 30
steps = (dt, dx, )
start = time.perf_counter()

array1 = np.cos(create_array.arange(-np.pi, np.pi, dx))
length = len(array1)*0.01
array2 = create_array.arange(0, length, dt)
array3 = create_array.get_vector_changes(array1) * (1/dx)
# x, t = create_array.meshgrid(array1, array2)
# print(x.shape)
# array_teste = pde_solver.solve_wave_equation(
#    initial_condition=array1,
#    steps=steps,
#    max_time=max_time,
#    type="free",
#    velocity=1
# )
print(f"tempo para função {time.perf_counter()-start}")
plt.plot(array2, array1)
plt.plot(array2, array3)
plt.show()
# fig: plt.Figure = plt.figure()
# ax: plt.subplot = fig.add_subplot(111, projection='3d')
# ax.plot_surface(x, t, array_teste)
# plt.show()
# start = time.perf_counter()
# array2 = np.random.normal(loc=avg, scale=std, size=shape)
# print(f"tempo para função {time.perf_counter()-start}")
# print(array1)
# print(array1.shape)
# plt.hist(array1, bins=50)
# plt.hist(array2, bins=50)
# plt.show()
# print(np.max(array1))
# print(np.average(array1))
# print(np.std(array1))
