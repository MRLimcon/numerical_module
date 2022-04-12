module solver

  contains

    function free_wave_equation_1d(ic_len, delta_x, delta_t, sol_len, c, ic, iv) result(array)
      implicit none

      integer, intent(in) :: ic_len, sol_len
      real, intent(in) :: ic(ic_len), iv(ic_len), delta_x, delta_t, c
      real :: array(ic_len, sol_len), acceleration(ic_len)
      real :: velocity(ic_len, sol_len), constant
      integer :: i, j

      constant = (c**2)/(delta_x**2)
      array(:, 1) = ic
      velocity(:, 1) = iv

      do i = 2, sol_len, 1

        acceleration(1) = ( array(2, i-1) - array(1, i-1) )
        acceleration(ic_len) = (array(ic_len-1, i-1) - array(ic_len, i-1))
        do j = 2, ic_len-1, 1
          acceleration(j) = ( array(j-1, i-1) + array(j+1, i-1) - (2*array(j, i-1)) )
        end do

        acceleration = acceleration*constant
        velocity(:, i) = velocity(:, i-1) + (acceleration*delta_t)
        array(:, i) = array(:, i-1) + (velocity(:, i)*delta_t)

      end do

    end function free_wave_equation_1d

    function closed_wave_equation_1d(ic_len, delta_x, delta_t, sol_len, c, ic, iv) result(array)
      implicit none

      integer, intent(in) :: ic_len, sol_len
      real, intent(in) :: ic(ic_len), iv(ic_len), delta_x, delta_t, c
      real :: array(ic_len, sol_len), acceleration(ic_len)
      real :: velocity(ic_len, sol_len), constant
      integer :: i, j

      constant = (c**2)/(delta_x**2)
      array(:, 1) = ic
      array(1, 2:sol_len) = spread(array(1, 1), 1, sol_len-1)
      array(ic_len, 2:sol_len) = spread(array(ic_len, 1), 1, sol_len-1)
      velocity(:, 1) = iv

      do i = 2, sol_len, 1

        do j = 2, ic_len-1, 1
          acceleration(j) = ( array(j-1, i-1) + array(j+1, i-1) - (2*array(j, i-1)) )
        end do

        acceleration = acceleration*constant
        velocity(2:ic_len-1, i) = velocity(2:ic_len-1, i-1) + (acceleration(2:ic_len-1)*delta_t)
        array(2:ic_len-1, i) = array(2:ic_len-1, i-1) + (velocity(2:ic_len-1, i)*delta_t)

      end do

    end function closed_wave_equation_1d

    function free_heat_equation_1d(ic_len, delta_x, delta_t, sol_len, c, ic) result(array)
      implicit none

      integer, intent(in) :: ic_len, sol_len
      real, intent(in) :: ic(ic_len), delta_x, delta_t, c
      real :: array(ic_len, sol_len), acceleration(ic_len), constant
      integer :: i, j

      constant = delta_t*c/(delta_x**2)
      array(:, 1) = ic

      do i = 2, sol_len, 1

        acceleration(1) = (array(2, i-1) - array(1, i-1))
        acceleration(ic_len) = (array(ic_len-1, i-1) - array(ic_len, i-1))
        do j = 2, ic_len-1, 1
          acceleration(j) = array(j+1, i-1) - ( 2*array(j, i-1) ) + array(j-1, i-1)
        end do

        array(:, i) = array(:, i-1) + (acceleration*constant)

      end do

    end function free_heat_equation_1d

    function closed_heat_equation_1d(ic_len, delta_x, delta_t, sol_len, c, ic) result(array)
      implicit none

      integer, intent(in) :: ic_len, sol_len
      real, intent(in) :: ic(ic_len), delta_x, delta_t, c
      real :: array(ic_len, sol_len), acceleration(ic_len), constant
      integer :: i, j

      constant = delta_t*c/(delta_x**2)
      array(:, 1) = ic
      array(1, 2:sol_len) = spread(array(1, 1), 1, sol_len-1)
      array(ic_len, 2:sol_len) = spread(array(ic_len, 1), 1, sol_len-1)

      do i = 2, sol_len, 1

        do j = 2, ic_len-1, 1
          acceleration(j) = array(j+1, i-1) - ( 2*array(j, i-1) ) + array(j-1, i-1)
        end do

        array(2:ic_len-1, i) = array(2:ic_len-1, i-1) + (acceleration(2:ic_len-1)*constant)

      end do

    end function closed_heat_equation_1d

end module solver
