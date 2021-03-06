module calculations
  use formatting
  implicit none

contains
  
  subroutine interpolationlin(npoints, xmin, xmax, base, potvec)

    integer, intent(in) :: npoints
    real(dp), intent(in) :: xmin, xmax
    real(dp), allocatable, intent(in) :: base(:,:)
    real(dp), allocatable, intent(out) :: potvec(:)
    integer :: ii, jj, nn, iipoints, xtemp
    real(dp) :: deltax, deltay
    real(dp), allocatable :: fullbase(:,:)
    logical :: stepcase

    deltax = (xmax - xmin) / npoints
    nn = size(base(1,:),dim=1)
    allocate(fullbase(2,nn+2))
    fullbase(:,1) = (/xmin, 0.0_dp/)
    fullbase(:,nn+2) = (/xmax, 0.0_dp/)
    fullbase(:,2:nn+1) = base

    xtemp = 1
    allocate(potvec(npoints))
    potvec(1) = 0
    
    do jj=1,nn+1
      stepcase = (fullbase(1,jj+1) - fullbase(1,jj)) == 0
      
      if (stepcase) then
        iipoints = xtemp
        deltay = (fullbase(2,jj+1) - fullbase(2,jj))
      else
        iipoints = floor((fullbase(1,jj+1) - fullbase(1,1)) / deltax)
        deltay = (fullbase(2,jj+1) - fullbase(2,jj)) / (iipoints-xtemp+1)
      end if
      
      do ii=xtemp, iipoints
        if (jj==1) then
          potvec(ii) = deltay
        else
          potvec(ii) = potvec(ii-1) + deltay
        end if
      end do
      
      xtemp = iipoints+1
    end do
    
  end subroutine interpolationlin
  
  

end module calculations
