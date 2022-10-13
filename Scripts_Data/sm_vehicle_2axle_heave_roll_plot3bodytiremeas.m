% Code to plot simulation results from sm_vehicle_2axle_heave_roll
%% Plot Description:
%
% The plots below shows the body roll and pitch angles, as well as the
% normal forces on the tires.

% Copyright 2021-2022 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_vehicle_2axle_heave_roll', 'var')
    sim('sm_vehicle_2axle_heave_roll')
end

% Reuse figure if it exists, else create new figure
if ~exist('h3_sm_vehicle_2axle_heave_roll', 'var') || ...
        ~isgraphics(h3_sm_vehicle_2axle_heave_roll, 'figure')
    h3_sm_vehicle_2axle_heave_roll = figure('Name', 'sm_vehicle_2axle_heave_roll');
end
figure(h3_sm_vehicle_2axle_heave_roll)
clf(h3_sm_vehicle_2axle_heave_roll)

% Get simulation results
simlog_Veh  = logsout_sm_vehicle_2axle_heave_roll.get('Vehicle');
simlog_t    = simlog_Veh.Values.Body.aRoll.Time;
simlog_rollVeh  = simlog_Veh.Values.Body.aRoll.Data(:);
simlog_pitchVeh = simlog_Veh.Values.Body.aPitch.Data(:);
simlog_fnFL     = simlog_Veh.Values.TireFL.Fz.Data;
simlog_fnFR     = simlog_Veh.Values.TireFR.Fz.Data;
simlog_fnRL     = simlog_Veh.Values.TireRL.Fz.Data;
simlog_fnRR     = simlog_Veh.Values.TireRR.Fz.Data;

% Plot results
ah(1) = subplot(2,1,1);
plot(simlog_t, simlog_rollVeh, 'LineWidth', 1, 'DisplayName','Roll')
hold on
plot(simlog_t, simlog_pitchVeh, 'LineWidth', 1, 'DisplayName','Pitch')
hold off

ylabel('Angle (rad)')
xlabel('Time (s)')
title('Body Angles')
grid on
legend('Location','Best');

ah(2) = subplot(2,1,2);
plot(simlog_t, simlog_fnFL, 'LineWidth', 1,'DisplayName','FL')
hold on
plot(simlog_t, simlog_fnFR, 'LineWidth', 1,'DisplayName','FR')
plot(simlog_t, simlog_fnRL, 'LineWidth', 1,'DisplayName','RL')
plot(simlog_t, simlog_fnRR, 'LineWidth', 1,'DisplayName','RR')
hold off

ylabel('Force (N)')
xlabel('Time (s)')
title('Tire Normal Forces')
grid on
legend('Location','Best');

% Remove temporary variables
clear simlog_t simlog_handles
clear simlog_rollVeh simlog_pitchVeh simlog_Veh 
clear simlog_fnFL simlog_fnFR simlog_fnRL simlog_fnRR

