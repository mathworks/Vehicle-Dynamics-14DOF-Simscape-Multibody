function sm_vehicle_2axle_heave_roll_plot_grid_surface(surf_name)

switch(lower(surf_name))
    case('plateau')
        Plateau = evalin('base','SceneData.Plateau');
        grid_surf_x = Plateau.Road.pzLUT.px;
        grid_surf_y = [-4  4];
        grid_surf_z = Plateau.Road.pzLUT.pz;
        viewSettings = [-88, 0.97];
        titlestr = 'Plateau';
        edgeColor = [1 1 1]*0.5;

    case('rough road')
        Rough_Road = evalin('base','SceneData.Rough_Road');
        grid_surf_x = Rough_Road.Road.pzLUT.px;
        grid_surf_y = [-4  -0.5 0 0.5 4];
        grid_surf_z = [...
            Rough_Road.Road.pzLUT.pz(:,2) ...
            Rough_Road.Road.pzLUT.pz(:,2) ...
            sum(Rough_Road.Road.pzLUT.pz,2)/2 ...
            Rough_Road.Road.pzLUT.pz(:,1) ...
            Rough_Road.Road.pzLUT.pz(:,1)];
        viewSettings = [-87, 8];
        titlestr = 'Rough Road';
        edgeColor = 'None';

    otherwise
        error(['Data for ' surf_name ' not known.'])
end
% Reuse figure if it exists, else create new figure
figString = ['h1_' mfilename];
% Only create a figure if no figure exists
figExist = 0;
fig_hExist = evalin('base',['exist(''' figString ''',''var'')']);
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

colormap('parula')
s=surf(grid_surf_x',grid_surf_y,grid_surf_z');
view(viewSettings(1), viewSettings(2))
box on
axis equal
s.EdgeColor = edgeColor;
title([titlestr ' Grid Surface'])
