%%%%  PA Function




% PA(M) = (1/2)*( M - M')  Anti-symmetric


function [PA_OUT] = fPA(XX_VAR)

        PA_OUT = (1/2)*( XX_VAR - XX_VAR' );
