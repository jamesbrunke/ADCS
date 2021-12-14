%%%%  SKEW Function



% XX = [ XX(1)
%        XX(2)
%        XX(3)]

function [SKEW_OUT] = fSKEW(XX_VAR)

        SKEW_OUT =  [  0          -XX_VAR(3)   XX_VAR(2)
                       XX_VAR(3)   0          -XX_VAR(1)
                      -XX_VAR(2)   XX_VAR(1)   0 ];
