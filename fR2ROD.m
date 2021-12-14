%%%%  From Exponential to Rodrigus Vector and SO3




function [RHO_OUT] = fR2ROD(RSO3_IN)

        RHO_OUT    =  (1/( 1+trace(RSO3_IN)) )*[ (RSO3_IN(3,2)-RSO3_IN(2,3)) ; (RSO3_IN(1,3)-RSO3_IN(3,1)) ; (RSO3_IN(2,1)-RSO3_IN(1,2)) ];
%        Same Answer
%         RHO_OUT    =  fVEX( ( RSO3_IN - eye(3,3) )*inv( RSO3_IN + eye(3,3)) )
%         RHO_OUT    =  fVEX( inv( RSO3_IN + eye(3,3))*( RSO3_IN - eye(3,3) ) )
%       Corresponding R
%         ROD_SO3    =  inv( eye(3,3) - fSKEW(RHO_OUT) )*( eye(3,3) + fSKEW(RHO_OUT) )
%         ROD_SO3    =  ( eye(3,3) + fSKEW(RHO_OUT) )*inv( eye(3,3) - fSKEW(RHO_OUT) )

      %% Same solution
%         ROD_SO3 = ( 1/( 1+ RHO_OUT'*RHO_OUT) )*( (1-(RHO_OUT'*RHO_OUT))*eye(3,3) + 2*(RHO_OUT*RHO_OUT') + 2*fSKEW(RHO_OUT) )
%         ROD_SO3 = ( 1/( 1+ RHO_OUT'*RHO_OUT) )*( eye(3,3) + RHO_OUT*RHO_OUT' + 2*fSKEW(RHO_OUT) + fSKEW(RHO_OUT)^2 )



      %% The following line should be transposed
%       ROD_SO3    =  ( eye(3,3) + fSKEW(RHO_OUT) )*inv( eye(3,3) - fSKEW(RHO_OUT) );
