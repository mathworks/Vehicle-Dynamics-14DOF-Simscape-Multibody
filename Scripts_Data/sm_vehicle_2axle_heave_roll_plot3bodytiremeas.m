function sm_vehicle_2axle_heave_roll_plot3bodytiremeas(logsoutRes)
% Code to plot simulation results from sm_vehicle_2axle_heave_roll
%% Plot Description:
%
% The plots below shows the body roll and pitch angles, as well as the
% normal forces on the tires.

% Copyright 2021-2024 The MathWorks, Inc.

% Reuse figure if it exists, else create new figure
figString = ['h1_' mfilename];
% Only create a figure if no figure exists
figExist = 0;
fig_hExist = evalin('base',['exist(''' figString ''')']);
if (fig_hExist)
    figExist = evalin('base',['ishandle(' figString ') && strcmp(get(' figString ', ''type''), ''figure'')']);
end
if ~figExist
    fig_h = figure('Name',figString);
    assignin('base',figString,fig_h);
else
    fig_h = evalin('base',figString);
end
figure(fig_h)
clf(fig_h)

% Get simulation results
simlog_Veh  = logsoutRes.get('Vehicle');
simlog_t    = simlog_Veh.Values.Body.aRoll.Time;
simlog_rollVeh  = simlog_Veh.Values.Body.aRoll.Data(:);
simlog_pitchVeh = simlog_Veh.Values.Body.aPitch.Data(:);

simlog_f_t     = simlog_Veh.Values.TireFL.Fz.Time;
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
plot(simlog_f_t, simlog_fnFL, 'LineWidth', 1,'DisplayName','FL')
hold on
plot(simlog_f_t, simlog_fnFR, 'LineWidth', 1,'DisplayName','FR')
plot(simlog_f_t, simlog_fnRL, 'LineWidth', 1,'DisplayName','RL')
plot(simlog_f_t, simlog_fnRR, 'LineWidth', 1,'DisplayName','RR')
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

