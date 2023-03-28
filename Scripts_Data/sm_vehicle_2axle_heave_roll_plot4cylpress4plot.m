function sm_vehicle_2axle_heave_roll_plot4cylpress4plot(simlogRes,logsoutRes)
% Code to plot simulation results from sm_vehicle_2axle_heave_roll_mu
%% Plot Description:
%
% Plot caliper pressure and master cylinder pressure on a four separate plots.
%
% Copyright 2019-2023 The MathWorks, Inc.

% Only plot pressures if pressure data is present
% (not present in variable-damper brake model)
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

    simlog_brkMeas = logsoutRes.get('BrkBus');
    simlog_pFL = simlog_brkMeas.Values.FL.p.Data;
    simlog_pFR = simlog_brkMeas.Values.FR.p.Data;
    simlog_pRL = simlog_brkMeas.Values.RL.p.Data;
    simlog_pRR = simlog_brkMeas.Values.RR.p.Data;

    simlog_Actuator_Children = simlogRes.Brakes.Brakes.Disc.Actuator.childIds;

    % Only plot Master Cylinder pressure if it was logged
    % (only in Valves variant of Brake Actuator)
    if(~isempty(find(strcmp(simlog_Actuator_Children,'Valves'), 1)))
        simlog_pMCL = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_FL.Orifice_Apply.A.p.series.values('psi');
        simlog_pMCR = simlogRes.Brakes.Brakes.Disc.Actuator.Valves.Valves_FR.Orifice_Apply.A.p.series.values('psi');
    else
        simlog_pMCL = [];
        simlog_pMCR = [];
    end

    % Plot results
    simlog_handles(1) = subplot(2, 2, 1);

    if(~isempty(simlog_pMCL))
        plot(simlog_t,simlog_pMCL,'k--','LineWidth',2);
        hold on
    end
    plot(simlog_t, simlog_pFL,'Color',temp_colororder(1,:),'LineWidth',1);
    grid on
    title('Front Left')
    ylabel('Pressure (psi)')

    simlog_handles(2) = subplot(2, 2, 2);

    if(~isempty(simlog_pMCL))
        plot(simlog_t,simlog_pMCL,'k--','LineWidth',2);
        hold on
    end

    plot(simlog_t, simlog_pFR,'Color',temp_colororder(1,:),'LineWidth',1);
    grid on
    title('Front Right')

    simlog_handles(3) = subplot(2, 2, 3);

    if(~isempty(simlog_pMCL))
        plot(simlog_t,simlog_pMCL,'k--','LineWidth',2);
        hold on
    end

    plot(simlog_t, simlog_pRL,'Color',temp_colororder(1,:),'LineWidth',1);
    grid on
    title('Rear Left')
    ylabel('Pressure (psi)')
    xlabel('Time (s)');

    simlog_handles(4) = subplot(2, 2, 4);

    if(~isempty(simlog_pMCL))
        plot(simlog_t,simlog_pMCL,'k--','LineWidth',2);
        hold on
    end

    plot(simlog_t, simlog_pRR,'Color',temp_colororder(1,:),'LineWidth',1);
    grid on
    title('Rear Right')
    xlabel('Time (s)');

    linkaxes(simlog_handles, 'xy')

else
    msgbox('No valve data - select a different configuration.','Data Not Present')
end
