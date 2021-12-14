%%%%  Exponential expression for SO3




function [REXP_SO3] = fREXP_R(Theta_IN, Omega_IN)

        REXP_SO3    =  eye(3,3) + fSKEW(Omega_IN)*sin(Theta_IN) + ( fSKEW(Omega_IN)^2 )*( 1 - cos(Theta_IN) );
