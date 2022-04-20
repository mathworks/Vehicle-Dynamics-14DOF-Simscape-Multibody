% Code to plot simulation results from sm_vehicle_2axle_heave_roll
%% Plot Description:
%
% The plot below shows the wheel speeds during the maneuver.  The
% rotational wheel speeds are scaled by the unloaded radius so they can be
% compared with the translational speed of the vehicle.

% Copyright 2021 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_vehicle_2axle_heave_roll', 'var')
    sim('sm_vehicle_2axle_heave_roll')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_vehicle_2axle_heave_roll', 'var') || ...
        ~isgraphics(h1_sm_vehicle_2axle_heave_roll, 'figure')
    h1_sm_vehicle_2axle_heave_roll = figure('Name', 'sm_vehicle_2axle_heave_roll');
end
figure(h1_sm_vehicle_2axle_heave_roll)
clf(h1_sm_vehicle_2axle_heave_roll)

% Get simulation results
simlog_t    = simlog_sm_vehicle_2axle_heave_roll.Vehicle.Revolute_FL.Rz.w.series.time;
simlog_vFL  = simlog_sm_vehicle_2axle_heave_roll.Vehicle.Revolute_FL.Rz.w.series.values('rad/s')*VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS;
simlog_vFR  = simlog_sm_vehicle_2axle_heave_roll.Vehicle.Revolute_FR.Rz.w.series.values('rad/s')*VehicleData.TireDataF.param.DIMENSION.UNLOADED_RADIUS;
simlog_vRL  = simlog_sm_vehicle_2axle_heave_roll.Vehicle.Revolute_RL.Rz.w.series.values('rad/s')*VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS;
simlog_vRR  = simlog_sm_vehicle_2axle_heave_roll.Vehicle.Revolute_RR.Rz.w.series.values('rad/s')*VehicleData.TireDataR.param.DIMENSION.UNLOADED_RADIUS;
simlog_Veh  = logsout_sm_vehicle_2axle_heave_roll.get('Vehicle');
simlog_vVeh = simlog_Veh.Values.Body.vx.Data;

% Plot results
plot(simlog_t, simlog_vVeh, 'k--', 'LineWidth', 1)
hold on
plot(simlog_t, simlog_vFL, 'LineWidth', 1)
plot(simlog_t, simlog_vFR, 'LineWidth', 1)
plot(simlog_t, simlog_vRL, 'LineWidth', 1)
plot(simlog_t, simlog_vRR, 'LineWidth', 1)

hold off
ylabel('Speed (m/s)')
xlabel('Time (s)')
title('Wheel Speeds and Vehicle Speed')
grid on
legend({'Vehicle','FL','FR','RL','RR'},'Location','Best');
text(0.05,0.05,'Wheel Speeds estimated with unloaded radius','Units','normalized','Color',[0.6 0.6 0.6])

% Remove temporary variables
clear simlog_t simlog_handles
clear simlog_vFL simlog_vFR simlog_vRL simlog_vRR

