%%%%%   Explicit Filter

%%%%%   29-12-2016

function [sys,x0,str,ts,simStateCompliance] = f_Explicit_Filter(t,x,u,flag,Ki,kp,k_I)             %%%%%%%%%%%%%

switch flag,

  case 0
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;

  case 3
    sys=mdlOutputs(t,x,u,Ki,kp,k_I);

  case { 1, 2, 4, 9 }
    sys=[];

  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end


%
function [sys,x0,str,ts,simStateCompliance] = mdlInitializeSizes()
sizes = simsizes;
sizes.NumContStates    = 0;
sizes.NumDiscStates    = 0;
sizes.NumOutputs       = 34;  % dynamically sized
sizes.NumInputs        = 48;  % dynamically sized
sizes.DirFeedthrough   = 1;   % has direct feedthrough
sizes.NumSampleTimes   = 1;

sys = simsizes(sizes);
str = [];
x0  = [];
ts  = [-1 0];   % inherited sample time


simStateCompliance = 'DefaultSimState';

function sys = mdlOutputs(~,~,u,Ki,kp,k_I)

%% True Omega and R Matrix
    R_True(1:3,1)               = u(1:3);
    R_True(1:3,2)               = u(4:6);
    R_True(1:3,3)               = u(7:9);
    Omega(1:3,1)                = u(10:12);


%% Measured Vectors Inertial Frame (Accelerometer & Magnometer)
    va_dot(1:3,1)               = u(13:15);
    vm(1:3,1)                   = u(16:18);

%% Bias Components (Omega & Accelerometer & Magnometer)
    Om_Bias(1:3,1)              = u(19:21);
    Acc_Bias(1:3,1)             = u(22:24);
    Mag_Bias(1:3,1)             = u(25:27);

%% Noise Components (Omega & Accelerometer & Magnometer)
    Om_Noise(1:3,1)             = u(28:30);
    Acc_Noise(1:3,1)            = u(31:33);
    Mag_Noise(1:3,1)            = u(34:36);

%% Estimated Bias
    b_est(1:3,1)                = u(37:39);

%% Estimated Transformation Matrix
    R_est(1:3,1)                = u(40:42);
    R_est(1:3,2)                = u(43:45);
    R_est(1:3,3)                = u(46:48);


%% True Euler-Angles for Plotting
    Euler_True                  = fR2EUL_D(R_True);

%% Estimated Euler-Angles for Plotting
    Euler_est                   = fR2EUL_D(R_est);

%% Extraction vectors in body Frmae and Omega
    [Omega_Meas, V0, VB] = fMODEL(R_True, va_dot, vm, Om_Bias, Om_Noise, Acc_Bias, Acc_Noise, Mag_Bias, Mag_Noise, Omega);


%% Recovering Vectors
    VB1        = VB(:,1);          VB2   = VB(:,2);          VB3   = VB(:,3);
    V01        = V0(:,1);          V02   = V0(:,2);          V03   = V0(:,3);


%% Defining Estimated Vectors
    VB1_est                     = R_est'*V01;
    VB2_est                     = R_est'*V02;
    VB3_est                     = R_est'*V03;


%%  Roderigous parameter
    MB      = Ki(1)*VB1*VB1' + Ki(2)*VB2*VB2' + Ki(3)*VB3*VB3';
    L1      = inv(MB)*( VB1*VB1_est' + VB2*VB2_est' + VB3*VB3_est' );
    L2      = 0.25*trace( eye(3) - L1 );
    %% rho = v
    v       = fVEX(fPA(L1))/(2*(1-L2));

    VR_True     = fR2ROD(R_True);
    VR_est      = fR2ROD(R_est);

    %% Euclidean R_til
    Rtil_EUC = 0.25*trace( eye(3) - R_True'*R_est );

% %% Correction Factor Evaluation
%     W_corr                      = Ki(1)*cross(VB1, VB1_est) + Ki(2)*cross(VB2, VB2_est) + Ki(3)*cross(VB3, VB3_est);
%
%
% %% Estimated Bias
%     b_est_dot                   = -k_IE*W_corr;
%
%
% %% Estimated Transformation Matrix
%     R_est_dot                   = R_est*( fSKEW(Omega_Meas - b_est) + kp*fSKEW(W_corr) );

%% Other case
%% Correction Factor Evaluation
    W_corr                      = Ki(1)*cross(VB1_est, VB1) + Ki(2)*cross(VB2_est, VB2) + Ki(3)*cross(VB3_est, VB3);
%% Estimated Bias
    b_est_dot                   = k_I*W_corr;
%% Estimated Transformation Matrix
    R_est_dot                   = R_est*( fSKEW(Omega_Meas - b_est) - kp*fSKEW(W_corr) );


sys  = [Euler_True; Euler_est; Omega_Meas; b_est_dot; R_est_dot(1:3,1); R_est_dot(1:3,2); R_est_dot(1:3,3); v; W_corr; VR_True; VR_est;Rtil_EUC];
