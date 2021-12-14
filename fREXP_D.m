%%%%  Exponential expression for SO3




function [REXP_SO3] = fREXP_D(Theta_IN, Omega_IN)

        REXP_SO3    =  eye(3,3) + fSKEW(Omega_IN)*sind(Theta_IN) + ( fSKEW(Omega_IN)^2 )*( 1 - cosd(Theta_IN) );
