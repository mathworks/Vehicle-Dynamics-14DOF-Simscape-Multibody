function simlog_handles = sm_vehicle_2axle_heave_roll_plot6valveqsig(simlogRes)
% Code to plot simulation results from sm_vehicle_2axle_heave_roll_mu

%% Plot Description:
%
% Plot flow rate through valves and valve command signals.
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
    simlog_qFLa = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_FL.Orifice_Apply.q_A.series.values('lpm');
    simlog_qFLr = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_FL.Orifice_Release.q_A.series.values('lpm');
    simlog_SFLa = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_FL.Orifice_Apply.S.series.values('m');
    simlog_SFLr = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_FL.Orifice_Release.S.series.values('m');
    
    simlog_qFRa = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_FR.Orifice_Apply.q_A.series.values('lpm');
    simlog_qFRr = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_FR.Orifice_Release.q_A.series.values('lpm');
    simlog_SFRa = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_FR.Orifice_Apply.S.series.values('m');
    simlog_SFRr = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_FR.Orifice_Release.S.series.values('m');
    
    simlog_qRLa = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_RL.Orifice_Apply.q_A.series.values('lpm');
    simlog_qRLr = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_RL.Orifice_Release.q_A.series.values('lpm');
    simlog_SRLa = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_RL.Orifice_Apply.S.series.values('m');
    simlog_SRLr = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_RL.Orifice_Release.S.series.values('m');
    
    simlog_qRRa = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_RR.Orifice_Apply.q_A.series.values('lpm');
    simlog_qRRr = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_RR.Orifice_Release.q_A.series.values('lpm');
    simlog_SRRa = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_RR.Orifice_Apply.S.series.values('m');
    simlog_SRRr = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_RR.Orifice_Release.S.series.values('m');
    
    % Plot results
    simlog_handles(1) = subplot(4, 1, 1);
    yyaxis left
    plot(simlog_t, simlog_qFLa, simlog_t, simlog_qFLr,'LineWidth', 1)
    ylabel('Flow (lpm)')
    yyaxis right
    plot(simlog_t, simlog_SFLa, simlog_t, simlog_SFLr,'LineWidth', 1)
    grid on
    ylabel('Spool (m)')
    title('Front Left')
    legend({'qApply','qRelease','SApply','SRelease'},'Location','Best');
    
    simlog_handles(2) = subplot(4, 1, 2);
    yyaxis left
    plot(simlog_t, simlog_qFRa, simlog_t, simlog_qFRr,'LineWidth', 1)
    ylabel('Flow (lpm)')
    yyaxis right
    plot(simlog_t, simlog_SFRa, simlog_t, simlog_SFRr,'LineWidth', 1)
    grid on
    ylabel('Spool (m)')
    title('Front Right')
    
    simlog_handles(3) = subplot(4, 1, 3);
    yyaxis left
    plot(simlog_t, simlog_qRLa, simlog_t, simlog_qRLr,'LineWidth', 1)
    ylabel('Flow (lpm)')
    yyaxis right
    plot(simlog_t, simlog_SRLa, simlog_t, simlog_SRLr,'LineWidth', 1)
    grid on
    ylabel('Spool (m)')
    title('Rear Left')
    
    simlog_handles(4) = subplot(4, 1, 4);
    yyaxis left
    plot(simlog_t, simlog_qRRa, simlog_t, simlog_qRRr,'LineWidth', 1)
    ylabel('Flow (lpm)')
    yyaxis right
    plot(simlog_t, simlog_SRRa, simlog_t, simlog_SRRr,'LineWidth', 1)
    grid on
    ylabel('Spool (m)')
    title('Rear Right')
    xlabel('Time (s)');
    
    linkaxes(simlog_handles, 'x')
    
    
    % Remove temporary variables
    %clear simlog_t simlog_handles
    
else
    msgbox('No valve data - select a different configuration.')
    simlog_handles = -1;
end
