module array_operations
  contains

    recursive subroutine quicksort(array)
      ! from 1AdAstra1 gist repo https://gist.github.com/1AdAstra1
      ! file: https://gist.github.com/1AdAstra1/6f7785373efe5bb6c254d2e20c78ccc4
      implicit none

      real, intent(inout) :: array(:)
      real :: x, t
      integer :: first = 1, last, i, j

      last = size(array, 1)
      x = array( (first+last) / 2 )
      i = first
      j = last

      do
         do while (array(i) < x)
            i=i+1
         end do
         do while (x < array(j))
            j=j-1
         end do
         if (i >= j) exit
         t = array(i);  array(i) = array(j);  array(j) = t
         i=i+1
         j=j-1
      end do

      if (first < i-1) call quicksort(array(first : i-1))
      if (j+1 < last)  call quicksort(array(j+1 : last))
    end subroutine quicksort

    function calculate_prob_density(array, len_array, bins) result(result_array)
      implicit none
      integer, intent(in) :: len_array, bins
      real, intent(in) :: array(len_array)
      integer :: i, j, integer_values(bins)
      real :: result_array(2, bins+1), temp_array(len_array), sum_array(len_array)
      real :: min_value, max_value, delta, temp

      temp_array = array
      sum_array = 0
      result_array = 0
      j = 1

      call quicksort(temp_array)

      max_value = temp_array(len_array)
      min_value = temp_array(1)
      delta = (max_value-min_value)/(bins+1)
      temp = j*delta + min_value

      do i = 1, len_array, 1
        if ( temp_array(i) <= temp .and. temp_array(i+1) > temp ) then
          result_array(1, j) = temp_array(i)
          integer_values(j) = i
          j = j+1
          temp = j*delta + min_value
        elseif ( i == len_array ) then
          result_array(1, bins) = temp_array(len_array)
          integer_values(bins) = len_array
        end if
      end do

      result_array(1, 2:bins+1) = result_array(1, 1:bins)
      result_array(2, 1) = 0
      result_array(1, 1) = min_value

      do i = 2, len_array, 1
        sum_array(i) = sum_array(i-1) + 1
      end do
      sum_array = sum_array/maxval(sum_array)

      do i = 1, bins, 1
        j = integer_values(i)
        result_array(2, i+1) = sum_array(j)
      end do

      result_array(2, 2:bins+1) = (result_array(2, 2:bins+1) - result_array(2, 1:bins))&
              / delta


    end function calculate_prob_density

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

      if ( abs(steps - 1) < 0.0001 ) then
        vector = 0
        vector(2:lenx) = x(2:lenx)-x(1:lenx-1)
      else
        vector(1) = x(2)-x(1)
        vector(lenx) = -(x(lenx-1)-x(lenx))
        vector(2:lenx-1) = (x(3:lenx)-x(1:lenx-2))/2
        vector = vector/steps
      end if

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

      vector(1) = ( x(2) - x(1) )
      vector(lenx) = (x(lenx-1) - x(lenx))
      vector(2:lenx-1) = x(3:lenx) + x(1:lenx-2) - (2*x(2:lenx-1))
      vector = vector/(steps**2)
    end function get_acceleration_1d

    function repeat_string(string_val, string_length, length) result(array)
      implicit none
      integer, intent(in) :: length, string_length
      character, intent(in) :: string_val(string_length)
      character :: array(length, string_length)

      array = transpose(spread(string_val, 2, length))

    end function repeat_string

    function repeat_integer(int_val, length) result(array)
      implicit none
      integer, intent(in) :: length, int_val
      integer :: array(length)

      array = spread(int_val, 1, length)

    end function repeat_integer

    function repeat_float(float_val, length) result(array)
      implicit none
      integer, intent(in) :: length
      real, intent(in) :: float_val
      real :: array(length)

      array = spread(float_val, 1, length)

    end function repeat_float

    function repeat_bool(bool_val, length) result(array)
      implicit none
      integer, intent(in) :: length
      logical, intent(in) :: bool_val
      logical :: array(length)

      array = spread(bool_val, 1, length)

    end function repeat_bool

end module array_operations
