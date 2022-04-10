module array_operations
  contains

    function meshgrid(x, lenx, y, leny) result(array)
      implicit none
      integer, intent(in) :: lenx, leny
      integer :: i
      real, intent(in) :: x(lenx), y(leny)
      real :: array(lenx, leny, 2)

      array(:, :, 1) = transpose(spread(y, 2, lenx))
      array(:, :, 2) = spread(x, 2, leny)
    end function meshgrid

    function get_vector_changes(x, lenx) result(vector)
      implicit none
      integer, intent(in) :: lenx
      real, intent(in) :: x(lenx)
      real :: vector(lenx), next(lenx-1), last(lenx-1)

      last = x(1:lenx-1)
      next = x(2:lenx)

      vector(2:lenx) = next-last
    end function get_vector_changes
end module array_operations
