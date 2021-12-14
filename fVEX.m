%%%%  VEX Function




% X = [ X(1,1)  X(1,2)  X(1,3)                X = [  0     -x(3)   x(2)
%       X(2,1)  X(2,2)  X(2,3)                       x(3)   0     -x(1)
%       X(3,1)  X(3,2)  X(3,3) ];                   -x(2)   x(1)   0 ];

% VEX(X) = [ X(3,2)                      VEX(X) = [ x(1)
%            X(1,3)                                 x(2)
%            X(2,1) ];                              x(3)

function [VEX_OUT] = fVEX(XX_VAR)

        VEX_OUT = [ XX_VAR(3,2)
                    XX_VAR(1,3)
                    XX_VAR(2,1) ];
