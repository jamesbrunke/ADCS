%Initialise J2

%mu-> grav_parameter
%e_Radius-> earthRadius
%we->earth_rot
%theta -> True_anom
%h -> angMomentum
%a -> sm_axis
%epoch-> jd_Fraction
%Db-> Ballistic_Coeff
%T-> period
%e->eccentricity
%i->inclination
%omega-> Arg_periapsis
%M-> avg_anomaly
%n-> avg_motion
%define parameters
grav_parameter = 398600.4415;  %in km^3/s^2
earthRadius = 6378.137; % in km
J2 = 0.0010836;
earth_rot = 360*(1 + 1/365.25)/(3600*24);  % Earth's rotation [deg/s]

%read in 
fname = 'CubeSatTLE.txt';    % TLE file name
% Open the TLE file and read TLE elements
fid = fopen(fname, 'rb');

%while not at end of file
while ~(feof(fid))
% read data form two-line element set for cubesat orbit 
D1 = fscanf(fid,'%23c%*s',1);
D2 = fscanf(fid,'%d%6d%*c%5d%*3c%*2f%f%f%5d%*c%*d%5d%*c%*d%d%5d',[1,9]);
D3 = fscanf(fid,'%d%6d%f%f%f%f%f%f%f%f',[1,9]);
jd_Fraction = D2(1,4)*24*3600; % Epoch Date and Julian Date Fraction
Ballistic_Coeff = D2(1,5); 
inclination = D3(1,3); %in degrees
RAAN = D3(1,4);  %Right Ascension of Ascending Node in degrees
eccentricity = D3(1,5)/1e7; 
Arg_periapsis = D3(1,6); %in degrees
avg_anomaly = D3(1,7); %in degrees
avg_motion = D3(1,8); % in revolutions per day


% defineing Orbital parametres
sm_axis = (grav_parameter/(avg_motion*2*pi/(24*3600))^2)^(1/3);%kilometers
period = 2*pi*sqrt(sm_axis^3/grav_parameter); % in minutes
rp = sm_axis*(1-eccentricity);
AngMomentum = (grav_parameter*rp*(1 + eccentricity))^0.5; 
E = keplerEq(avg_anomaly*pi/180,eccentricity,2^(-52));
True_anom =  acos((cos(E) -eccentricity)/(1 - eccentricity*cos(E)))...
    *180/pi; %in degrees

E = 2*atan(tand(True_anom/2)*((1-eccentricity)/(1+eccentricity))^0.5);
avg_anomaly = E  - eccentricity*sin(E);
t0 = avg_anomaly/(2*pi)*period;
end
