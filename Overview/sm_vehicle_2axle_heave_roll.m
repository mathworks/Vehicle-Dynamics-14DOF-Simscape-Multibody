%% Vehicle Dynamics, 14 DOF Model (Heave and Roll DOFs Per Axle)
% 
% <<sm_vehicle_2axle_heave_roll_modelAnim.png>>
% 
% <matlab:open_system('sm_vehicle_2axle_heave_roll') Open Vehicle Dynamics, 14 DOF Model>
%
% (<matlab:web('sm_vehicle_2axle_heave_roll_Overview.html') return to Vehicle Dynamics Overview>)
% 
% This example models vehicle dynamics using a vehicle model that has 14
% degrees of freedom.  The driver inputs and scene where the vehicle is
% driving can be configured as you select one of the maneuvers.
% 
% The vehicle model includes a six degree-of-freedom body model, two
% axles each with heave and roll degrees of freedom, and four wheels that
% rotate.  The front wheels are steered using the Ackermann steering
% equation.  Many of the vehicle parameters can be modified using MATLAB.
%
% The tire model is the Magic Formula Tire Force and Torque block from
% Simscape Multibody.  You can plot the forces and torques at the contact
% patch from the simulation results.
%
% Explore the <https://www.mathworks.com/matlabcentral/fileexchange/79484
% Simscape Vehicle Templates> for more customizable models of battery-electric
% vehicles, hybrid-electric, and multi-axle vehicles.
%
% *Acknowledgements:* MathWorks would like to thank M V Krishna Teja, PhD,
% <https://prof-rkkumar.wixsite.com/iitm-vpg-lab Virtual Proving Ground and
% Simulation Lab>, Raghupati Singhania Centre of Excellence at the Indian
% Institute of Technology, Madras for providing the tire parameters for
% this example.
%
% Copyright 2021-2023 The MathWorks, Inc.


%% Model

open_system('sm_vehicle_2axle_heave_roll')

set_param(find_system('sm_vehicle_2axle_heave_roll','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% Vehicle Model

set_param('sm_vehicle_2axle_heave_roll/Vehicle','LinkStatus','none')
open_system('sm_vehicle_2axle_heave_roll/Vehicle','force')

%% Tire Model

set_param('sm_vehicle_2axle_heave_roll/Vehicle/Wheel FL','LinkStatus','none')
open_system('sm_vehicle_2axle_heave_roll/Vehicle/Wheel FL','force')

%% Simulation Results from Simscape Logging, Step Steer
%%
%
% The plot below shows the wheel speeds during the maneuver.  The
% rotational wheel speeds are scaled by the unloaded radius so they can be
% compared with the translational speed of the vehicle. Additional plots
% below show vehicle position, body roll angle, body pitch angle, and tire
% normal forces.


sm_vehicle_2axle_heave_roll_config_maneuver('sm_vehicle_2axle_heave_roll',VehicleData,'stepsteer')
sim('sm_vehicle_2axle_heave_roll')

sm_vehicle_2axle_heave_roll_plot1whlspd(...
    simlog_sm_vehicle_2axle_heave_roll,...
    logsout_sm_vehicle_2axle_heave_roll,...
    VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS,...
    VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS);

sm_vehicle_2axle_heave_roll_plot2bodypos(simlog_sm_vehicle_2axle_heave_roll);
sm_vehicle_2axle_heave_roll_plot3bodytiremeas(logsout_sm_vehicle_2axle_heave_roll);

%% Simulation Results from Simscape Logging, Sine with Dwell
%%
%
% The plot below shows the wheel speeds during the maneuver.  The
% rotational wheel speeds are scaled by the unloaded radius so they can be
% compared with the translational speed of the vehicle. Additional plots
% below show vehicle position, body roll angle, body pitch angle, and tire
% normal forces.

sm_vehicle_2axle_heave_roll_config_maneuver('sm_vehicle_2axle_heave_roll',VehicleData,'sinewithdwell')
sim('sm_vehicle_2axle_heave_roll')

sm_vehicle_2axle_heave_roll_plot1whlspd(...
    simlog_sm_vehicle_2axle_heave_roll,...
    logsout_sm_vehicle_2axle_heave_roll,...
    VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS,...
    VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS);

sm_vehicle_2axle_heave_roll_plot2bodypos(simlog_sm_vehicle_2axle_heave_roll);
sm_vehicle_2axle_heave_roll_plot3bodytiremeas(logsout_sm_vehicle_2axle_heave_roll);

%% Simulation Results from Simscape Logging, Slalom
%%
%
% The plot below shows the wheel speeds during the maneuver.  The
% rotational wheel speeds are scaled by the unloaded radius so they can be
% compared with the translational speed of the vehicle. Additional plots
% below show vehicle position, body roll angle, body pitch angle, and tire
% normal forces.

sm_vehicle_2axle_heave_roll_config_maneuver('sm_vehicle_2axle_heave_roll',VehicleData,'slalom')
sim('sm_vehicle_2axle_heave_roll')

sm_vehicle_2axle_heave_roll_plot1whlspd(...
    simlog_sm_vehicle_2axle_heave_roll,...
    logsout_sm_vehicle_2axle_heave_roll,...
    VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS,...
    VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS);

sm_vehicle_2axle_heave_roll_plot2bodypos(simlog_sm_vehicle_2axle_heave_roll);
sm_vehicle_2axle_heave_roll_plot3bodytiremeas(logsout_sm_vehicle_2axle_heave_roll);

%% Simulation Results from Simscape Logging, Slalom on Hill
%%
% In this maneuver, the vehicle is in motion at the start of the
% simulation.  It coasts up a hill, and when its momentum cannot carry it
% any further it rolls back down the hill.  The driver moves the steering
% wheel back and forth.  This tests the tire model on a hill with a slope,
% at low speeds, and in both forward and reverse directions.
% 
% The plot below shows the wheel speeds during the maneuver.  The
% rotational wheel speeds are scaled by the unloaded radius so they can be
% compared with the translational speed of the vehicle. An additional plot
% below shows vehicle position.
%

sm_vehicle_2axle_heave_roll_config_maneuver('sm_vehicle_2axle_heave_roll',VehicleData,'slalomhill')
sim('sm_vehicle_2axle_heave_roll')

sm_vehicle_2axle_heave_roll_plot1whlspd(...
    simlog_sm_vehicle_2axle_heave_roll,...
    logsout_sm_vehicle_2axle_heave_roll,...
    VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS,...
    VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS);
sm_vehicle_2axle_heave_roll_plot2bodypos(simlog_sm_vehicle_2axle_heave_roll);

%% Simulation Results from Simscape Logging, Plateau
%%
% In this maneuver, the vehicle is in motion at the start of the
% simulation.  It coasts up a hill, rolls across the top, and then coasts
% down the hill on the other side. 
% 
% The plot below shows the wheel speeds during the maneuver.  The
% rotational wheel speeds are scaled by the unloaded radius so they can be
% compared with the translational speed of the vehicle.  The vehicle speed
% drops as it climbs the hill, and then it increases again as it coasts
% down the other side.  This shows that the tire model takes into account
% the slope of the road. Additional plots below show body roll angle, body
% pitch angle, and tire normal forces.
%

sm_vehicle_2axle_heave_roll_config_maneuver('sm_vehicle_2axle_heave_roll',VehicleData,'plateau')
sim('sm_vehicle_2axle_heave_roll')

sm_vehicle_2axle_heave_roll_plot1whlspd(...
    simlog_sm_vehicle_2axle_heave_roll,...
    logsout_sm_vehicle_2axle_heave_roll,...
    VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS,...
    VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS);
sm_vehicle_2axle_heave_roll_plot3bodytiremeas(logsout_sm_vehicle_2axle_heave_roll);

%% Simulation Results from Simscape Logging, Rough Road
%%
% In this maneuver, the vehicle is in motion at the start of the
% simulation.  It coasts along an uneven road which exercises the
% suspension and causes the car to pitch and roll. Additional plots below
% show body roll angle, body pitch angle, and tire normal forces.
%

sm_vehicle_2axle_heave_roll_config_maneuver('sm_vehicle_2axle_heave_roll',VehicleData,'rough road')
sim('sm_vehicle_2axle_heave_roll')

sm_vehicle_2axle_heave_roll_plot1whlspd(...
    simlog_sm_vehicle_2axle_heave_roll,...
    logsout_sm_vehicle_2axle_heave_roll,...
    VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS,...
    VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS);
sm_vehicle_2axle_heave_roll_plot3bodytiremeas(logsout_sm_vehicle_2axle_heave_roll);


%% Simulation Results from Simscape Logging, Parking
%%
% In this maneuver, the vehicle is resting at the side of the road.  The
% driver steers the wheels before accelerating away from the side of the
% road. This tests the tire turning on the spot, as well as accelerating
% away from rest.
% 
% The plot below shows the wheel speeds during the maneuver.  The
% rotational wheel speeds are scaled by the unloaded radius so they can be
% compared with the translational speed of the vehicle.  Additional plots
% below show body roll angle, body pitch angle, and tire normal forces.
%

sm_vehicle_2axle_heave_roll_config_maneuver('sm_vehicle_2axle_heave_roll',VehicleData,'parking')
sim('sm_vehicle_2axle_heave_roll')

sm_vehicle_2axle_heave_roll_plot1whlspd(...
    simlog_sm_vehicle_2axle_heave_roll,...
    logsout_sm_vehicle_2axle_heave_roll,...
    VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS,...
    VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS);
sm_vehicle_2axle_heave_roll_plot3bodytiremeas(logsout_sm_vehicle_2axle_heave_roll);

                        
%%

%clear all
close all
bdclose all
