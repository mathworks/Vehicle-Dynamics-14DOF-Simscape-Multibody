function simlog_handles = sm_vehicle_2axle_heave_roll_plot5valveq(simlogRes)
% Code to plot simulation results from sm_vehicle_2axle_heave_roll_mu
%% Plot Description:
%
% Plot flow rate through apply and release valves
%
% Copyright 2019-2024 The MathWorks, Inc.

% Only plot valve measurements if data is present
% (only present in valve actuator model)
simlog_Brakes_Children = simlogRes.Brakes.Brakes.childIds;
if(~isempty(find(strcmp(simlog_Brakes_Children,'Disc'), 1)))
    
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
    simlog_t = simlogRes.Vehicle.Revolute_FL.Rz.w.series.time;
    
    simlog_Brakes_Children = simlogRes.Brakes.Brakes.childIds;
    
    simlog_qFLa = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_FL.Orifice_Apply.q_A.series.values('lpm');
    simlog_qFLr = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_FL.Orifice_Release.q_A.series.values('lpm');
    
    simlog_qFRa = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_FR.Orifice_Apply.q_A.series.values('lpm');
    simlog_qFRr = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_FR.Orifice_Release.q_A.series.values('lpm');
    
    simlog_qRLa = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_RL.Orifice_Apply.q_A.series.values('lpm');
    simlog_qRLr = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_RL.Orifice_Release.q_A.series.values('lpm');
    
    simlog_qRRa = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_RR.Orifice_Apply.q_A.series.values('lpm');
    simlog_qRRr = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_RR.Orifice_Release.q_A.series.values('lpm');
    
    % Plot results
    simlog_handles(1) = subplot(2, 2, 1);
    plot(simlog_t, simlog_qFLa, simlog_t, simlog_qFLr,'LineWidth', 1)
    grid on
    title('Front Left')
    ylabel('Flow Rate (lpm)')
    legend({'Apply','Release'},'Location','Best');
    
    simlog_handles(2) = subplot(2, 2, 2);
    plot(simlog_t, simlog_qFRa, simlog_t, simlog_qFRr,'LineWidth', 1)
    grid on
    legend({'Apply','Release'},'Location','Best');
    title('Front Right')
    
    simlog_handles(3) = subplot(2, 2, 3);
    plot(simlog_t, simlog_qRLa, simlog_t, simlog_qRLr,'LineWidth', 1)
    grid on
    legend({'Apply','Release'},'Location','Best');
    title('Rear Left')
    ylabel('Flow Rate (lpm)')
    xlabel('Time (s)');
    
    simlog_handles(4) = subplot(2, 2, 4);
    plot(simlog_t, simlog_qRRa, simlog_t, simlog_qRRr,'LineWidth', 1)
    grid on
    legend({'Apply','Release'},'Location','Best');
    title('Rear Right')
    xlabel('Time (s)');
    
    linkaxes(simlog_handles, 'xy')
    
    
    % Remove temporary variables
    %clear simlog_t simlog_handles
else
    msgbox('No valve data - select a different configuration.');
    simlog_handles = -1;
end
