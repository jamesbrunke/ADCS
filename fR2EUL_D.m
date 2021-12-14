%%%%  Euler Angles From Transformation Matrix (Function)



% R = [   cos(psi)*cos(theta)     -sin(psi)*cos(phi)+cos(psi)*sin(psi)*sin(phi)      sin(psi)*sin(phi)+cos(psi)*cos(phi)*sin(theta);
%         sin(psi)*cos(theta)     cos(psi)*cos(phi)+sin(phi)*sin(theta)*sin(psi)     -cos(psi)*sin(phi)+sin(theta)*sin(psi)*cos(phi);
%         -sin(theta)             cos(theta)*sin(phi)                                cos(phi)*cos(theta)]


function [EUL_VECT_OUT] = fR2EUL_D(REUL_VAR)



        EUL_PHI_VAR   = atan2( REUL_VAR(3,2) , REUL_VAR(3,3) )*180/pi;
        EUL_THETA_VAR = asin( -REUL_VAR(3,1) )*180/pi;
        EUL_PSI_VAR   = atan2( REUL_VAR(2,1) , REUL_VAR(1,1) )*180/pi;

        EUL_VECT_OUT  = [ EUL_PHI_VAR; EUL_THETA_VAR; EUL_PSI_VAR];
