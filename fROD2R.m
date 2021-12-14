%%%%  From Transformation matrix to SO3 Vector




function [RHO_OUT] = fROD2R(RSO3_INP)

        RHO_OUT    =  ( eye(3,3) - RSO3_INP )*inv( eye(3,3)+ RSO3_INP );
        RHO_OUT    =  fVEX(RHO_OUT);

      %% Same solution
%         ROD_SO3 = ( 1/( 1+ RHO_OUT'*RHO_OUT) )*( (1-(RHO_OUT'*RHO_OUT))*eye(3,3) + 2*(RHO_OUT*RHO_OUT') + 2*fSKEW(RHO_OUT) )
%         ROD_SO3 = ( 1/( 1+ RHO_OUT'*RHO_OUT) )*( eye(3,3) + RHO_OUT*RHO_OUT' + 2*fSKEW(RHO_OUT) + fSKEW(RHO_OUT)^2 )



      %% The following line should be transposed
%       ROD_SO3    =  ( eye(3,3) + fSKEW(RHO_OUT) )*inv( eye(3,3) - fSKEW(RHO_OUT) );
