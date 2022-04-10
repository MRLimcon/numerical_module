module array_operations
  contains

    function get_zvalue_1d(vector, lenx) result(transformed_vector)
      implicit none
      integer, intent(in) :: lenx
      real, intent(in) :: vector(lenx)
      real :: transformed_vector(lenx), avg, std

      avg = sum(vector)/lenx
      std = sqrt( (sum(vector**2)/lenx) - (avg**2) )
      transformed_vector = (vector-avg)/std

    end function get_zvalue_1d

    function remove_outliers(vector, lenx, std_in) result(bool_vector)
      implicit none
      integer, intent(in) :: lenx
      real, intent(in) :: vector(lenx), std_in
      real :: transformed_vector(lenx), avg, std
      logical :: bool_vector(lenx)

      avg = sum(vector)/lenx
      std = sqrt( (sum(vector**2)/lenx) - (avg**2) )
      transformed_vector = (vector-avg)/std

      bool_vector = (transformed_vector < std_in) .and. &
        (transformed_vector > -std_in)

    end function remove_outliers

    function meshgrid(x, lenx, y, leny) result(array)
      implicit none
      integer, intent(in) :: lenx, leny
      integer :: i
      real, intent(in) :: x(lenx), y(leny)
      real :: array(lenx, leny, 2)

      array(:, :, 1) = transpose(spread(y, 2, lenx))
      array(:, :, 2) = spread(x, 2, leny)
    end function meshgrid

    function get_vector_changes(x, lenx, steps) result(vector)
      implicit none
      integer, intent(in) :: lenx
      real, intent(in) :: x(lenx), steps
      real :: vector(lenx)

      vector = 0
      vector(2:lenx) = x(2:lenx)-x(1:lenx-1)
      vector = vector/steps
    end function get_vector_changes

    function get_gradient_2d(x, lenx, leny, stepsx, stepsy) result(array)
      implicit none
      integer, intent(in) :: lenx, leny
      real, intent(in) :: x(leny, lenx), stepsx, stepsy
      real :: array(leny, lenx, 2)

      array = 0
      array(:, 2:lenx, 1) = (x(:, 2:lenx) - x(:, 1:lenx-1))/stepsx
      array(2:leny, :, 2) = (x(2:leny, :) - x(1:leny-1, :))/stepsy
    end function get_gradient_2d

    function get_acceleration_1d(x, lenx, steps) result(vector)
      implicit none
      integer, intent(in) :: lenx
      integer :: i
      real, intent(in) :: x(lenx), steps
      real :: vector(lenx)

      vector(1) = (x(2) - x(1))/steps
      vector(lenx) = (x(lenx-1) - x(lenx))/steps
      do i = 2, lenx-1, 1
        vector(i) = (x(i+1) + x(i-1) - (2*x(i)))/(steps**2)
      end do
      vector = vector
    end function get_acceleration_1d

    function repeat_string(string_val, string_length, length) result(array)
      implicit none
      integer, intent(in) :: length, string_length
      integer :: i
      character, intent(in) :: string_val(string_length)
      character :: array(length, string_length)

      array = transpose(spread(string_val, 2, length))

    end function repeat_string

    function repeat_integer(int_val, length) result(array)
      implicit none
      integer, intent(in) :: length, int_val
      integer :: i
      integer :: array(length)

      array = spread(int_val, 1, length)

    end function repeat_integer

    function repeat_float(float_val, length) result(array)
      implicit none
      integer, intent(in) :: length
      real, intent(in) :: float_val
      integer :: i
      real :: array(length)

      array = spread(float_val, 1, length)

    end function repeat_float

    function repeat_bool(bool_val, length) result(array)
      implicit none
      integer, intent(in) :: length
      logical, intent(in) :: bool_val
      integer :: i
      logical :: array(length)

      array = spread(bool_val, 1, length)

    end function repeat_bool

end module array_operations
