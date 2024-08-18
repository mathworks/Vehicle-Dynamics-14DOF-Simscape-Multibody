%% Vehicle Dynamics, 14 DOF Model, Varying Surface Friction
% 
% <<sm_vehicle_2axle_heave_roll_mu_modelAnim.png>>
% 
% <matlab:open_system('sm_vehicle_2axle_heave_roll_mu') Open Vehicle, 14 DOF Model, Varying Surface Friction>
%
% (<matlab:web('sm_vehicle_2axle_heave_roll_Overview.html') return to Vehicle Dynamics Overview>)
% 
% This model shows an anti-lock braking system in various stages of
% development. 
% 
% # *Variable Damper*: A variable damper is used to apply braking torque.
% This lets you assess the amount of torque the brakes need to provide so
% you can select a brake type.
% # *Ideal Brake Actuator*: An ideal pressure source applies force to a
% disk caliper.  This lets you calculate the force the caliper actuators need
% to provide so you can size the calipers and pump.
% # *Hydraulic Brake Actuator*: An ideal hydraulic actuator applies force to a
% disk brake.  This lets you size the valves and pumps for the hydraulic
% system.
% # *Valve-Driven Actuator*: Pressure is applied and released via valves in
% open-loop control.  This lets you select the valve sizes.
% # *Closed-Loop Control*: Pressure is applied and released via valves in
% closed-loop control.  This lets you design the control algorithm.
%
% Copyright 2019-2024 The MathWorks, Inc.

%% Model

open_system('sm_vehicle_2axle_heave_roll_mu')

set_param(find_system('sm_vehicle_2axle_heave_roll_mu','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% Vehicle Subsystem
%
% This subsystem models lateral and longitudinal vehicle dynamics, including
% front-rear weight transfer, and tire-road forces.
%
% <matlab:open_system('sm_vehicle_2axle_heave_roll_mu');open_system('sm_vehicle_2axle_heave_roll_mu/Vehicle','force'); Open Subsystem>

set_param('sm_vehicle_2axle_heave_roll_mu/Vehicle','LinkStatus','none')
open_system('sm_vehicle_2axle_heave_roll_mu/Vehicle','force')

%% 1. Variable Damper 
%
% In this configuration, brake torque is applied via a variable damper. The
% damping is a fixed amount and duration, resulting in open-loop control.
% This test is useful to assess the torque required to slow the vehicle.
%

set_param('sm_vehicle_2axle_heave_roll_mu/Brakes','brake_model',0);

%% -- Variable Damper Brake Torque
%
% This subsystem models the brakes as a variable damper. This is a simple
% means of applying braking torque to the axle, and can be used to estimate
% the amount of torque required to stop a vehicle.
%
% <matlab:open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Damper');open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Damper','force'); Open Subsystem>

set_param('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Damper','LinkStatus','none')
open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Damper','force')

%% -- Simulation Results, Right Side Ice Patch
set_param([bdroot '/Vehicle'],'popup_surface_conditions','Right Low Patch');
sm_vehicle_2axle_heave_roll_config_maneuver(bdroot,VehicleData,'plateau');
sim('sm_vehicle_2axle_heave_roll_mu')
sm_vehicle_2axle_heave_roll_plot1whlspd(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu,...
    VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS,...
    VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS);
sm_vehicle_2axle_heave_roll_plot2brktrq(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu)

%% 2. Ideal Caliper Actuator
%
% In this configuration, brake torque is applied via a disc brake model and
% an ideal force actuator applies pressure.  Brake control is still
% open-loop (fixed duration and frequency of pulses).
%

set_param('sm_vehicle_2axle_heave_roll_mu/Brakes','brake_model',1);

%% -- Disk Brakes
%
% This subsystem models the disk brakes on a vehicle.  The actuator can be
% configured for various levels of abstraction.
%
% <matlab:open_system('sm_vehicle_2axle_heave_roll_mu');open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc','force'); Open Subsystem>

set_param('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc','LinkStatus','none')
open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc','force')

%% -- Ideal Actuator for Caliper
%
% This subsystem models the force applied to the brake caliper.  This is an
% ideal actuator with a filter time constant to model actuator dynamics.
%
% <matlab:open_system('sm_vehicle_2axle_heave_roll_mu');open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc/Actuator/Ideal','force'); Open Subsystem>

set_param('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc/Actuator/Ideal','LinkStatus','none')
open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc/Actuator/Ideal','force')

%% -- Simulation Results, Right Side Ice Patch
set_param([bdroot '/Vehicle'],'popup_surface_conditions','Right Low Patch');
sm_vehicle_2axle_heave_roll_config_maneuver(bdroot,VehicleData,'plateau');
sim('sm_vehicle_2axle_heave_roll_mu')
sm_vehicle_2axle_heave_roll_plot1whlspd(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu,...
    VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS,...
    VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS);
sm_vehicle_2axle_heave_roll_plot2brktrq(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu);

%% 3. Hydraulic Brake Actuator
%
% In this configuration, brake torque is applied via a disc brake model and
% separate ideal pressure sources apply pressure at each piston. Brake
% control is still open-loop (fixed duration and frequency of pulses).
% This configuration is used to size the piston and determine flow rates.
%

set_param('sm_vehicle_2axle_heave_roll_mu/Brakes','brake_model',2);

%% -- Hydraulic Network, Ideal Hydraulic Caliper Actuators
%
% This subsystem models an ideal hydraulic actuation system for the caliper
% system. It assumes the necessary pressure is always available for use at
% the caliper.  A filter time constant is included for actuator dynamics.
%
% <matlab:open_system('sm_vehicle_2axle_heave_roll_mu');open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc/Actuator/Hydraulic','force'); Open Subsystem>

set_param('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc/Actuator/Hydraulic','LinkStatus','none')
open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc/Actuator/Hydraulic','force')

%% -- Simulation Results, Right Side Ice Patch
set_param([bdroot '/Vehicle'],'popup_surface_conditions','Right Low Patch');
sm_vehicle_2axle_heave_roll_config_maneuver(bdroot,VehicleData,'plateau');
sim('sm_vehicle_2axle_heave_roll_mu')
sm_vehicle_2axle_heave_roll_plot1whlspd(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu,...
    VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS,...
    VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS);
sm_vehicle_2axle_heave_roll_plot2brktrq(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu);
sm_vehicle_2axle_heave_roll_plot3cylpress1plot(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu);

%% 4. Valve-Driven Actuator, Open-Loop Control 
%
% In this configuration, brake torque is applied via a disc brake model and
% an pressure is applied and released via valves.  An ideal pressure source
% represents the pump. Brake control is still open-loop (fixed duration and
% frequency of pulses).  This configuration is used to size the valves and
% determine flow rates.

set_param('sm_vehicle_2axle_heave_roll_mu/Brakes','brake_model',3);

%% -- Hydraulic Network, Valve-Actuated Calipers
%
% At this level, a single ideal pressure source represents the master
% cylinder. Input signals control the apply and release valves.
%
% <matlab:open_system('sm_vehicle_2axle_heave_roll_mu');open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc/Actuator/Valves','force'); Open Subsystem>

set_param('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc/Actuator/Valves','LinkStatus','none')
open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc/Actuator/Valves','force')

%% -- Apply and Release Valves
%
% Variable orifices represent the apply and release valves, which control
% the flow of hydraulic fluid to and from the brake caliper.
%
% <matlab:open_system('sm_vehicle_2axle_heave_roll_mu');open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc/Actuator/Valves/Valves%20FL','force'); Open Subsystem>

set_param('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc/Actuator/Valves/Valves FL','LinkStatus','none')
open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brakes/Disc/Actuator/Valves/Valves FL','force')

%% -- Simulation Results, Right Side Ice Patch
set_param([bdroot '/Vehicle'],'popup_surface_conditions','Right Low Patch');
sm_vehicle_2axle_heave_roll_config_maneuver(bdroot,VehicleData,'plateau');
sim('sm_vehicle_2axle_heave_roll_mu')
sm_vehicle_2axle_heave_roll_plot1whlspd(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu,...
    VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS,...
    VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS);
sm_vehicle_2axle_heave_roll_plot2brktrq(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu);
sm_vehicle_2axle_heave_roll_plot3cylpress1plot(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu);
sm_vehicle_2axle_heave_roll_plot5valveq(...
    simlog_sm_vehicle_2axle_heave_roll_mu);
simlog_handles = sm_vehicle_2axle_heave_roll_plot6valveqsig(...
    simlog_sm_vehicle_2axle_heave_roll_mu);
set(simlog_handles,'XLim',[1.5 2]);
set(simlog_handles,'YLim',[0 6e-3]);

%% 5. Valve-Driven Actuator, Closed-Loop Control
%
% In this configuration, brake torque is applied via a disc brake model and
% an pressure is applied and released via valves.  An ideal pressure source
% represents the pump. Brake control is still open-loop (fixed duration and
% frequency of pulses).  This configuration is used to size the valves and
% determine flow rates.

set_param('sm_vehicle_2axle_heave_roll_mu/Brakes','brake_model',4);

%% -- Control System for Front Left Valves
%
% This state machine determines if the pressure should be increased,
% released, or held constant. The decision concerning pressure determines
% whether the apply and release values should be open or closed.
%
% <matlab:open_system('sm_vehicle_2axle_heave_roll_mu');open_system('sm_vehicle_2axle_heave_roll_mu/Brake%20Control/Valve%20Closed%20Loop/Valve%20Control%20FL/Logic','force'); Open Subsystem>

try
open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brake Control/Valve Closed Loop/Valve Control FL/Logic')
end
open_system('sm_vehicle_2axle_heave_roll_mu/Brakes/Brake Control/Valve Closed Loop/Valve Control FL/Logic')

%% -- Simulation Results, Right Side Ice Patch
set_param([bdroot '/Vehicle'],'popup_surface_conditions','Right Low Patch');
sm_vehicle_2axle_heave_roll_config_maneuver(bdroot,VehicleData,'plateau');
sim('sm_vehicle_2axle_heave_roll_mu')
sm_vehicle_2axle_heave_roll_plot1whlspd(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu,...
    VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS,...
    VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS);
sm_vehicle_2axle_heave_roll_plot2brktrq(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu);
sm_vehicle_2axle_heave_roll_plot3cylpress1plot(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu);
sm_vehicle_2axle_heave_roll_plot4cylpress4plot(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu);
sm_vehicle_2axle_heave_roll_plot5valveq(...
    simlog_sm_vehicle_2axle_heave_roll_mu);
simlog_handles = sm_vehicle_2axle_heave_roll_plot6valveqsig(...
    simlog_sm_vehicle_2axle_heave_roll_mu);
set(simlog_handles,'XLim',[0 1])

%% -- Simulation Results, Checkerboard, Right Low
set_param([bdroot '/Vehicle'],'popup_surface_conditions','Checker Right');
sm_vehicle_2axle_heave_roll_config_maneuver(bdroot,VehicleData,'plateau');
sim('sm_vehicle_2axle_heave_roll_mu')
sm_vehicle_2axle_heave_roll_plot1whlspd(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu,...
    VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS,...
    VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS);
sm_vehicle_2axle_heave_roll_plot2brktrq(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu);
sm_vehicle_2axle_heave_roll_plot3cylpress1plot(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu);
sm_vehicle_2axle_heave_roll_plot4cylpress4plot(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu);
sm_vehicle_2axle_heave_roll_plot5valveq(...
    simlog_sm_vehicle_2axle_heave_roll_mu);
simlog_handles = sm_vehicle_2axle_heave_roll_plot6valveqsig(...
    simlog_sm_vehicle_2axle_heave_roll_mu);
set(simlog_handles,'XLim',[0 1]);

%%
simlog_handles = sm_vehicle_2axle_heave_roll_plot3cylpress1plot(...
    simlog_sm_vehicle_2axle_heave_roll_mu,...
    logsout_sm_vehicle_2axle_heave_roll_mu);
set(simlog_handles,'XLim',[2 3]);

%%
close all
bdclose all
