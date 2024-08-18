function sm_vehicle_2axle_heave_roll_plot2brktrq(simlogRes,logsoutRes)
% Code to plot simulation results from sm_vehicle_2axle_heave_roll_mu
%% Plot Description:
%
% Plot of torque applied by braking system.
%
% Copyright 2016-2024 The MathWorks, Inc.

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

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_vVeh    = simlogRes.Vehicle.Body_to_World.Body_World_Joint.Px.v.series.values('m/s');

simlog_brkMeas = logsoutRes.get('BrkBus');
simlog_xVeh    = simlogRes.Vehicle.Body_to_World.Body_World_Joint.Px.p.series.values('m');
simlog_brkPed  = logsoutRes.get('BrkPedal');

index_brkstart = find(simlog_brkPed.Values.Data>0,1);

simlog_brakingDist = simlog_xVeh(end)-simlog_xVeh(index_brkstart);

% Plot results
simlog_handles(1) = subplot(1, 1, 1);
plot(...
    simlog_brkMeas.Values.FL.trq.Time, -simlog_brkMeas.Values.FL.trq.Data,...
    simlog_brkMeas.Values.FR.trq.Time, -simlog_brkMeas.Values.FR.trq.Data,...
    simlog_brkMeas.Values.RL.trq.Time, -simlog_brkMeas.Values.RL.trq.Data,...
    simlog_brkMeas.Values.RR.trq.Time, -simlog_brkMeas.Values.RR.trq.Data,...
    'LineWidth', 1)
hold off
grid on
title('Brake Torque (N*m)')
ylabel('Torque (N*m)')
legend({'FL','FR','RL','RR'},'Location','Best');
xlabel('Time (s)');


