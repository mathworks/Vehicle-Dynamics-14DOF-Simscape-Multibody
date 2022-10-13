% Code to plot simulation results from sm_vehicle_2axle_heave_roll
%% Plot Description:
%
% The plot below shows the position of the vehicle during the maneuver.

% Copyright 2021-2022 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_vehicle_2axle_heave_roll', 'var')
    sim('sm_vehicle_2axle_heave_roll')
end

% Reuse figure if it exists, else create new figure
if ~exist('h2_sm_vehicle_2axle_heave_roll', 'var') || ...
        ~isgraphics(h2_sm_vehicle_2axle_heave_roll, 'figure')
    h2_sm_vehicle_2axle_heave_roll = figure('Name', 'sm_vehicle_2axle_heave_roll');
end
figure(h2_sm_vehicle_2axle_heave_roll)
clf(h2_sm_vehicle_2axle_heave_roll)

% Get simulation results
simlog_xVeh = simlog_sm_vehicle_2axle_heave_roll.Vehicle.Body_to_World.Body_World_Joint.Px.p.series.values;
simlog_yVeh = simlog_sm_vehicle_2axle_heave_roll.Vehicle.Body_to_World.Body_World_Joint.Py.p.series.values;

% Plot results
plot(simlog_xVeh, simlog_yVeh, 'LineWidth', 1)
xlabel('X Position (m)')
ylabel('Y Position (m)')
title('Vehicle Position, World Coordinates')
grid on
axis equal
text(0.05,0.05,['Final Position: ' sprintf('%3.2fm, %3.2fm',simlog_xVeh(end),simlog_yVeh(end))],'Color',[0.6 0.6 0.6],'Units','Normalized')

% Remove temporary variables
clear simlog_t simlog_handles
clear simlog_xVeh simlog_yVeh

