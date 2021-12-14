%%%%  Model R SO3 Attitude Estimation

%%%%  29-12-2019




function [OM_MEAS, V0_MEAS, VB_MEAS] = fMODEL(R_TRUE, V_Adot, V_MAG, OM_BIAS, OM_NOISE, V_A_BIAS, V_A_NOISE, V_M_BIAS, V_M_NOISE, OMEGA)


%% Angular Velcoity
        % Measured
        OM_MEAS   = OMEGA + OM_BIAS + OM_NOISE;

%% Measured Vectors
    % Inertial-frame Vectors (Normalized)
      % Accelerometer
        g0        = [0;0;9.8];
        V01       = V_Adot - g0;
        V_A       = R_TRUE'*V01 + V_A_BIAS + V_A_NOISE;
      % Magnetometer (Digital Compass) ==> Very Low noise
        V02       = V_MAG;
        V_M       = R_TRUE'*V_MAG + V_M_BIAS + V_M_NOISE;

      % Inertial-frame Vectors (Normalized)
        V01_MEAS  = V01/norm(V01,2);
        V02_MEAS  = V02/norm(V02,2);
%         VB2_MEAS  = cross(V_A,V_M)/norm( cross(V_A,V_M), 2);
        V03_MEAS  = cross(V01_MEAS,V02_MEAS)/norm( cross(V01_MEAS,V02_MEAS), 2);
        % Body-frame Vectors (Normalized)
        VB1_MEAS  = V_A/norm(V_A,2);
        VB2_MEAS  = V_M/norm(V_M,2);
%         VB2_MEAS  = cross(V_A,V_M)/norm( cross(V_A,V_M), 2);
        VB3_MEAS  = cross(VB1_MEAS,VB2_MEAS)/norm( cross(VB1_MEAS,VB2_MEAS), 2);
        V0_MEAS   = [V01_MEAS V02_MEAS V03_MEAS];
        VB_MEAS   = [VB1_MEAS VB2_MEAS VB3_MEAS];



%     V01          = V1/norm(V1,2);
%     V02          = V2/norm(V2,2);
%     % Body-frame Vectors (Normalized)
%     VB1_MEAS     = R'*v01 + VB1_NOISE;
%     VB2_MEAS     = R'*v02 + VB2_NOISE;
%     VB1_MEAS     = VB1_MEAS/norm(VB1_MEAS,2);  %% Normalizing Measured Vectors at the body frame
%     VB2_MEAS     = VB2_MEAS/norm(VB2_MEAS,2);  %% Normalizing Measured Vectors at the body frame
