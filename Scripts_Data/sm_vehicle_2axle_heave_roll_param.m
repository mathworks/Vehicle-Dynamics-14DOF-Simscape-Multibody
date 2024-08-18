% Parameters for example sm_vehicle_2axle_heave_roll.slx
% Copyright 2021-2024 The MathWorks, Inc.

% Vehicle body parameters
% Vehicle reference point is point directly between 
%         tire contact patches on front wheels
VehicleData.Body.FA = 0;               % m
VehicleData.Body.RA = -3;              % m
VehicleData.Body.CG = [-1.5 0 0.6147]; % m
VehicleData.Body.Geometry = [1.25 0.9850 -0.2353]; % m
VehicleData.Body.Mass          = 1600;            % kg
VehicleData.Body.Inertias      = [600 3000 3200]; % kg*m^2
VehicleData.Body.Color     = [0.4 0.6 1.0]; % RGB
VehicleData.Body.Color_2   = [0.87 0.57 0.14]; % RGB
VehicleData.Body.Opacity = 1.0;

% Front suspension parameters
% Two degrees of freedom for axle (heave, roll), spin DOF for wheels
% Ackermann steering
VehicleData.SuspF.Heave.Stiffness = 40000;  % N/m
VehicleData.SuspF.Heave.Damping   = 3500;   % N/m
VehicleData.SuspF.Heave.EqPos     = -0.2;   % m
VehicleData.SuspF.Heave.Height    = 0.1647; % m
VehicleData.SuspF.Roll.Stiffness  = 66000;  % N*m/rad
VehicleData.SuspF.Roll.Damping    = 2050;   % N*m/(rad/s)
VehicleData.SuspF.Roll.Height     = 0.0647; % m
VehicleData.SuspF.Roll.EqPos      = 0;      % rad

% Separation of wheels on this axle
VehicleData.SuspF.Track           = 1.6;    % m

% Unsprung mass - radius and length for visualization only
VehicleData.SuspF.UnsprungMass.Mass = 95;         % kg
VehicleData.SuspF.UnsprungMass.Inertia = [1 1 1]; % kg*m^2
VehicleData.SuspF.UnsprungMass.Height = 0.355;    % m
VehicleData.SuspF.UnsprungMass.Radius = 0.1;      % m
VehicleData.SuspF.UnsprungMass.Length = 1.6;      % m

% Hub height should be synchronized with tire parameters
VehicleData.TireDataF.filename = 'KT_MF_Tool_245_60_R16.tir';
VehicleData.TireDataF.param    = simscape.multibody.tirread(which(VehicleData.TireDataF.filename));
VehicleData.SuspF.Hub.Height   = VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS; % m
% Rim mass and inertia typically not part of .tir file
VehicleData.RimF.Mass          = 10;    % kg
VehicleData.RimF.Inertia       = [1 2]; % kg*m^2

VehicleData.SuspF.SteerRatio = 16; % m

% Rear suspension parameters
% Two degrees of freedom for axle (heave, roll), spin DOF for wheels
VehicleData.SuspR.Heave.Stiffness  = 50000;  % N/m
VehicleData.SuspR.Heave.Damping    = 3500;   % N/m
VehicleData.SuspR.Heave.EqPos      = -0.16;  % m
VehicleData.SuspR.Heave.Height     = 0.1647; % m
VehicleData.SuspR.Roll.Stiffness   = 27500;  % N*m/rad
VehicleData.SuspR.Roll.Damping     = 2050;   % N*m/(rad/s)
VehicleData.SuspR.Roll.Height      = 0.1147; % m
VehicleData.SuspR.Roll.EqPos      = 0;      % rad

% Separation of wheels on this axle
VehicleData.SuspR.Track            = 1.6;    % m

% Unsprung mass - radius and length for visualization only
VehicleData.SuspR.UnsprungMass.Mass    = 90;      % kg
VehicleData.SuspR.UnsprungMass.Inertia = [1 1 1]; % kg*m^2
VehicleData.SuspR.UnsprungMass.Height  = 0.355;   % m
VehicleData.SuspR.UnsprungMass.Length  = 1.6;     % m
VehicleData.SuspR.UnsprungMass.Radius  = 0.1;     % m

% Hub height should be synchronized with tire parameters
VehicleData.TireDataR.filename = 'KT_MF_Tool_245_60_R16.tir';
VehicleData.TireDataR.param    = simscape.multibody.tirread(which(VehicleData.TireDataR.filename));
VehicleData.SuspR.Hub.Height   = VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS; % m

% Rim mass and inertia typically not part of .tir file
VehicleData.RimR.Mass          = 10;    % kg
VehicleData.RimR.Inertia       = [1 2]; % kg

%% Maneuver data
% Sine with Dwell

swd.tDelay = 3;
swd.tvec   = 0:0.01:10;
swd.Amplitude = 116 *(pi/180);
swd.HalfPeriod = 0.7;
swd.DwellDuration = 0.5;
swd.aStrWheel = ...
    swd.Amplitude*(sin(2*pi*swd.HalfPeriod*(swd.tvec-swd.tDelay)).*...
    (swd.tvec>=swd.tDelay & swd.tvec<=(swd.tDelay+3/4*1/swd.HalfPeriod)) ...
    + -1.*(swd.tvec>(swd.tDelay+3/4*1/swd.HalfPeriod) & swd.tvec<(swd.tDelay+swd.DwellDuration+3/4*1/swd.HalfPeriod)) ...
    + sin(2*pi*swd.HalfPeriod*(swd.tvec-swd.tDelay-swd.DwellDuration)).*(swd.tvec>=(swd.tDelay+swd.DwellDuration+3/4*1/swd.HalfPeriod) & swd.tvec<=(swd.tDelay+swd.DwellDuration+1/swd.HalfPeriod)));

Maneuver.SineWithDwell = swd;
clear swd

% Parking
Maneuver.Parking.Steer.tvec         = [0 1   3   6  7   7.3   8.6  9  10];
Maneuver.Parking.Steer.aSteerWheel  = [0 0 400 400  0 -90   -90    0   0]*pi/180;

Maneuver.Parking.Wheel.tvec  = [0 4 5  6  7  8  9  10];
Maneuver.Parking.Wheel.trqFL = [0 0 5  10 12 15 15 15]*35;
Maneuver.Parking.Wheel.trqFR = Maneuver.Parking.Wheel.trqFL;

%% Camera data
Camera =  sm_vehicle_camera_frames_car_3m;
