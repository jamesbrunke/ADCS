%%%%%   Explicit Filter


clear all
close all
clc


%% Sampling Time
    Ts             = 0.01;

%% True R Matrix (Angle-axis Representation)
    Gain_Theta     = 100; %130
    Ang_axis1      = 0.8;
    Ang_axis2      = 0.6;
    Ang_axis3      = 0.43;
    Gain_axis      = 13;
%     u_axis         = Gain_axis*[cos(Ang_axis1.*0); cos(Ang_axis2.*0); sin(Ang_axis3.*0)];
    u_axis         = [1; 5; 3];
%     u_axis         = [8.2396; 0.0607; 6.4603]
    Theta          = 179.9; % 19.3206
%     Theta          = 19

%% Angular Velocity
    Ang_OM1        = 0.7; % 0.1069
%     Ang_OM1        = 0.1069
    Ang_OM2        = 0.5; % 0.1390
%     Ang_OM2        = 0.1390
    Ang_OM3        = 0.3; % 0.1570
%     Ang_OM3        =  0.1570
    Gain_Om        = 1;   % 0.0617
%     Gain_Om        = 0.0617


%% Control Parameters
    % weights for highest true values of measured vectors
    Ki           = [1, 1, 1];
    kp           = 2;
    k_I          = 2;
    kpE          = 2;
    k_IE         = 2;
    kp           = kpE;
    k_I          = k_IE;

%% Vector True-Value/Bais/Noise
    % Weights Vectors
      K_va       = 1;    K_vm = 10;
%     % Weights Bais/Noise
%       Kba        = 0.01; %% Acc
%       Kbm        = 0.01; %% Mag
%       Kbo        = 0.01; %% Angu
%       Kna        = 0;    %% Acc
%       Knm        = 0.01; %% Mag   % Very small (normally low noise)
%       Kno        = 0.01; %% Angu
%       Angle      = 0.0001*rand(1,7);
%       Bias_shift = rand(1,7);


    % Weights Bais/Noise
    % Weights Vectors
      K_va       = 1/sqrt(3);    K_vm = 1;

    % Weights Bais/Noise (Vector Measurements)
      Percent = 1;
      Factor_Noise = Percent*0.07;
      Factor_Bias  = Percent*0.09;
      Kno        = Percent*0.25;     %% Angu Noise
      Kbo        = Percent*0.1;     %% Angu Bias


      Kba        = (1/sqrt(1))*Factor_Bias; %% Acc Bias
      Kna        = (1/sqrt(1))*Factor_Noise; %% Acc Noise

      Kbm        = Factor_Bias; %% Mag Bias
      Knm        = Factor_Noise; %% Mag   % Very small (normally low noise)
      Angle      = 0.0001*rand(1,7);
      Bias_shift = 0*rand(1,7);
%% Initialization (R & R_est)
    u_axis       = [1; 5; 3];
    R0           = fREXP_D( 179.9, u_axis/norm(u_axis) );
    R0           = [R0(1:3,1); R0(1:3,2); R0(1:3,3)];
    R_est        = eye(3);
    R0_est       = [R_est(1:3,1); R_est(1:3,2); R_est(1:3,3)];

    b0_est       = zeros(3,1);

%% Simin data from Workspace to Simulink
    Tt      = 0 :0.01: 15;   %% Time
    NOISE   = 2*randn(3,1501); %% Data
    NOISE_SIMIN = [Tt;NOISE]';  %% simin plug in
