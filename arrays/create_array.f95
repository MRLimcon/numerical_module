module create_array
  contains

    function arange(min_val, lenx, delta_val) result(array)
      implicit none
      real, intent(in) :: min_val, delta_val
      integer, intent(in) :: lenx
      integer :: i
      real :: array(lenx)

      do i = 1, lenx, 1
        array(i) = min_val + (delta_val*(i-1))
      end do
    end function arange

    function zeros_1d(lenx) result(array)
      implicit none
      integer, intent(in) :: lenx
      real :: array(lenx)

      array = 0

    end function zeros_1d

    function zeros_2d(lenx, leny) result(array)
      implicit none
      integer, intent(in) :: lenx, leny
      real :: array(leny, lenx)

      array = 0

    end function zeros_2d

    function rand_uniform_1d(lenx, min, max) result(array)
      implicit none
      integer, intent(in) :: lenx
      real, intent(in) :: min, max
      real :: array(lenx)

      call RANDOM_NUMBER(array)
      array = (array*(max-min)) + min
    end function rand_uniform_1d

    function rand_uniform_2d(lenx, leny, min, max) result(array)
      implicit none
      integer, intent(in) :: lenx, leny
      real, intent(in) :: min, max
      real :: array(leny, lenx)

      call RANDOM_NUMBER(array)
      array = (array*(max-min)) + min
    end function rand_uniform_2d

    function rand_gaussian_1d(lenx, avg, std) result(array)
      implicit none
      integer, intent(in) :: lenx
      integer :: i
      real, intent(in) :: avg, std
      real :: array(lenx), u(lenx), v(lenx)

      call random_number(u)
      call random_number(v)

      array = sqrt(-2*log((u*0.99999)+0.00001))*cos(6.283185*v)

      array = (array*std) + avg
    end function rand_gaussian_1d

    function rand_gaussian_2d(lenx, leny, avg, std) result(array)
      implicit none
      integer, intent(in) :: lenx, leny
      real, intent(in) :: avg, std
      real :: array(leny, lenx), u(leny, lenx), v(leny, lenx)

      call random_number(u)
      call random_number(v)

      array = sqrt(-2*log((u*0.99999)+0.00001))*cos(6.283185*v)

      array = (array*std) + avg
    end function rand_gaussian_2d

end module create_array
