%%%%%   Explicit Filter


function [sys,x0,str,ts,simStateCompliance] = fR_Dyn(t,x,u,flag)             %%%%%%%%%%%%%

switch flag

  case 0
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;

  case 3
    sys=mdlOutputs(t,x,u);

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
sizes.NumOutputs       = 9;  % dynamically sized
sizes.NumInputs        = 12;  % dynamically sized
sizes.DirFeedthrough   = 1;   % has direct feedthrough
sizes.NumSampleTimes   = 1;

sys = simsizes(sizes);
str = [];
x0  = [];
ts  = [-1 0];   % inherited sample time


simStateCompliance = 'DefaultSimState';

function sys = mdlOutputs(~,~,u)

%% True R Matrix
    R_True(1:3,1)                = u(1:3);
    R_True(1:3,2)                = u(4:6);
    R_True(1:3,3)                = u(7:9);
%% True Omega
    Omega_True(1:3,1)            = u(10:12);


%% Dynamic
    Rdot_True                    = R_True*fSKEW(Omega_True);




sys  = [Rdot_True(1:3,1); Rdot_True(1:3,2); Rdot_True(1:3,3)];
