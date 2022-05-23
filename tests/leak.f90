

program main
  real(kind=4), dimension(:), allocatable:: A

  allocate(A(100))
  A(1) = 1
  write (*,*) A(1)

  ! deallocate(A)

end program

