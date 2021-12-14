%%%%  Transformation Matrix from Euler derivative to Angular Velocity(Function)



%     REULd  = [ 1     0                 -sind(THETA_VAR);
%                0     cosd(PHI_VAR)     -sind(PHI_VAR)*cosd(THETA_VAR);
%                0    -sind(PHI_VAR)      cosd(PHI_VAR)*cosd(THETA_VAR)];

%     Omega = REULd*Eul_dot;

function [REULd_OUT] = fREUL_dot_D(EUL_VECTVAR)

        PHI_VAR      = EUL_VECTVAR(1);
        THETA_VAR    = EUL_VECTVAR(2);
        PSI_VAR      = EUL_VECTVAR(3);

        REULd_OUT    = [ 1     0                 -sind(THETA_VAR);
                         0     cosd(PHI_VAR)      sind(PHI_VAR)*cosd(THETA_VAR);
                         0    -sind(PHI_VAR)      cosd(PHI_VAR)*cosd(THETA_VAR)];
