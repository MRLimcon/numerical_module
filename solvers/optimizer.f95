module optimizer
  contains

    function linear_least_squares(x, y, n) result(results)
			implicit none

			integer, intent(in) :: n
			real :: x(n), y(n)
			real :: results(2, 2), Sx, Sy, Sxx, Sxy, Sxy_2, SSxx, mean, line(n)

			Sx = 0.
			Sy = 0.
			Sxx = 0.
			Sxy = 0.

			Sx = sum(x)
			Sy = sum(y)
			Sxx = sum(x**2)
			Sxy = sum(x*y)
      mean = Sx/n
      SSxx = sum((x - mean)**2)

			results(1, 1) = (n*Sxy - Sx*Sy)/(n*Sxx - Sx**2)
			results(1, 2) = (Sxx*Sy - Sxy*Sx)/(n*Sxx - Sx**2)

      line = (results(1, 1)*x) + results(1, 2)
      Sxy_2 = sum((y-line)**2)/(n-2)

      results(2, 1) = sqrt(Sxy_2/SSxx)
      results(2, 2) = sqrt(Sxy_2 * ((1/n) + ((mean**2)/SSxx)))

		end function linear_least_squares

end module optimizer
