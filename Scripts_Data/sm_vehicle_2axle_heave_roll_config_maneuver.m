function sm_vehicle_2axle_heave_roll_config_maneuver(mdl,VehicleData,tire_test)
% sm_vehicle_2axle_heave_roll_config_maneuver(mdl,VehicleData,tire_test)
%   Configure model and data structures to set up vehicle dynamics test
%
%   mdl           Name of Simulink model
%   VehicleData   Data structure with parameters for vehicle
%   tire_test     'slalom','slalomhill','parking','sinewithdwell',
% %               'stepsteer','plateau'
%
% Copyright 2021-2022 The MathWorks, Inc.

% Defaults for vehicle initial position in World coordinate frame
InitVehicle.Vehicle.px = 0;  % m
InitVehicle.Vehicle.py = 0;  % m
InitVehicle.Vehicle.pz = 0;  % m

% Defaults for vehicle initial translational velocity
% Represented in vehicle coordinates: 
%    +vx is forward, +vy is left, +vz is up in initial vehicle frame
InitVehicle.Vehicle.vx  = 20; %m/s
InitVehicle.Vehicle.vy  =  0;  %m/s
InitVehicle.Vehicle.vz  =  0;  %m/s

% Defaults for vehicle initial orientation
% Represented in vehicle coordinates, yaw-pitch-roll applied intrinsically
InitVehicle.Vehicle.yaw   = 0;  % rad
InitVehicle.Vehicle.pitch = 0;  % rad
InitVehicle.Vehicle.roll  = 0;  % rad

% Default is flat road surface in x-y plane
SceneData = evalin('base','SceneData');
SceneData.Reference.yaw   = 0 * pi/180;
SceneData.Reference.pitch = 0 * pi/180;
SceneData.Reference.roll  = 0 * pi/180;

road_surface_type = 'Flat';

% Based on selected maneuver, modify driver inputs and scene
% For some maneuvers, initial state of vehicle is modified
switch lower(tire_test)
    case 'stepsteer'
        scene_type   = 'Grid';
        driver_input = 'StepSteer';
    case 'sinewithdwell'
        scene_type   = 'Grid';
        driver_input = 'SineWithDwell';
    case 'plateau'
        scene_type   = 'Plateau';
        driver_input = 'NoSteer';
        road_surface_type = 'Plateau';
    case 'rough road'
        scene_type   = 'Rough Road';
        driver_input = 'NoSteer';
        road_surface_type = 'Rough Road';
        InitVehicle.Vehicle.vx  = 13.5; %m/s
    case 'parking'
        scene_type   = 'Road';
        driver_input = 'Parking';
        InitVehicle.Vehicle.vx = 0;    % m/s
        InitVehicle.Vehicle.py = -2.7; % m
        InitVehicle.Vehicle.px =  5;   % m
    case 'slalom'
        scene_type   = 'Road';
        driver_input = 'Slalom';
        InitVehicle.Vehicle.py = -2;  % m
    case 'slalomhill'
        scene_type   = 'Road';
        driver_input = 'Slalom';
        InitVehicle.Vehicle.vx    = 15;  % m/s
        InitVehicle.Vehicle.py    = -2;  % m
        SceneData.Reference.pitch = -10 * pi/180;
        InitVehicle.Vehicle.pitch = -10 * pi/180;  % m
    otherwise
        error('Maneuver type not found')
end

% Configure scene and driver input
set_param([mdl '/Vehicle'],'popup_scene',scene_type);
set_param([mdl '/Vehicle'],'popup_road_surface',road_surface_type);
set_param([mdl '/Steering Input'],'LabelModeActiveChoice',driver_input);

% Set initial position and speed of vehicle and wheels
InitVehicle.Wheel.wFL = InitVehicle.Vehicle.vx/VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS; %rad/s
InitVehicle.Wheel.wFR = InitVehicle.Vehicle.vx/VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS; %rad/s
InitVehicle.Wheel.wRL = InitVehicle.Vehicle.vx/VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS; %rad/s
InitVehicle.Wheel.wRR = InitVehicle.Vehicle.vx/VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS; %rad/s

% Update structures in MATLAB workspace
assignin('base',"InitVehicle",InitVehicle)
assignin('base',"SceneData",SceneData)

