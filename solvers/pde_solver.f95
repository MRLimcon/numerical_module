module solver

  contains

    function free_wave_equation_1d(ic_len, delta_x, delta_t, sol_len, c, ic) result(array)
      implicit none

      integer, intent(in) :: ic_len, sol_len
      real, intent(in) :: ic(ic_len), delta_x, delta_t, c
      real :: array(ic_len, sol_len), acceleration(ic_len), velocity(ic_len, sol_len)
      integer :: i, j

      array(:, 1) = ic

      do i = 2, sol_len, 1

        acceleration(1) = (array(2, i-1) - array(1, i-1))
        acceleration(ic_len) = (array(ic_len-1, i-1) - array(ic_len, i-1))
        do j = 2, ic_len-1, 1
          acceleration(j) = (array(j-1, i-1)-array(j, i-1)) &
            + (array(j+1, i-1)-array(j, i-1))
        end do

        acceleration = acceleration*(c**2)/(delta_x**2)
        velocity(:, i) = velocity(:, i-1) + (acceleration*delta_t)
        array(:, i) = array(:, i-1) + (velocity(:, i)*delta_t)

      end do

    end function free_wave_equation_1d

end module solver
