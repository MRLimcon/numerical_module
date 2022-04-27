module optimizer
  contains

    function linear_least_squares(matrix, n) result(results)
			implicit none

			integer, intent(in) :: n
			real :: matrix(2, n)
			real :: results(2, 2), Sx, Sy, Sxx, Sxy, Sxy_2, SSxx, mean, line(n)

			Sx = 0.
			Sy = 0.
			Sxx = 0.
			Sxy = 0.

			Sx = sum(matrix(1, :))
			Sy = sum(matrix(2, :))
			Sxx = sum(matrix(1, :)**2)
			Sxy = sum(matrix(1, :)*matrix(2, :))
      mean = Sx/n
      SSxx = sum((matrix(1, :) - mean)**2)

			results(1, 1) = (n*Sxy - Sx*Sy)/(n*Sxx - Sx**2)
			results(1, 2) = (Sxx*Sy - Sxy*Sx)/(n*Sxx - Sx**2)

      line = (results(1, 1)*matrix(1, :)) + results(1, 2)
      Sxy_2 = sum((matrix(2, :)-line)**2)/(n-2)

      results(2, 1) = sqrt(Sxy_2/SSxx)
      results(2, 2) = sqrt(Sxy_2 * ((1/n) + ((mean**2)/SSxx)))

		end function linear_least_squares
    
end module optimizer
