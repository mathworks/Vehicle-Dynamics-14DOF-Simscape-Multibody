function scene_data = sm_car_scenedata_rdf_rough_road
%% RDF Rough Road parameters
% Copyright 2018-2022 The MathWorks, Inc.

scene_data.Name           = 'RDF_Rough_Road';
scene_data.Road.filename  = 'Rough_Road.rdf';
scene_data.Road.depth     = 0.1;                % m
[xy_data_L, xy_data_R] = Extr_Data_RDF(scene_data.Road.filename,scene_data.Road.depth);
scene_data.Road.extr_data_L   = xy_data_L;    % m
scene_data.Road.extr_data_R   = xy_data_R;    % m
scene_data.Road.w           = 0.7;          % m

scene_data.Road.clr      = [0.2 0.4 0.6]; % [R G B]
scene_data.Road.opc      = 1;           % (0-1)
scene_data.Road.x   = 0;           % m
scene_data.Road.profile_separation = 2.0;           % m
scene_data.Road.z   = 0;           % m
scene_data.Road.yaw      = 0;           % rad

scene_data.Road.pzLUT.px = flipud(xy_data_L(end/2+1:end,1));
scene_data.Road.pzLUT.pz(:,1) = flipud(xy_data_L(end/2+1:end,2));
scene_data.Road.pzLUT.pz(:,2) = flipud(xy_data_R(end/2+1:end,2));

x = scene_data.Road.pzLUT.px;
z_L = scene_data.Road.pzLUT.pz(:,1);
z_R = scene_data.Road.pzLUT.pz(:,2);

offset = 2;
vlen = length(z_L);
roadslope_L = atan2((z_L(offset:end)-z_L(1:(vlen-offset+1))),(x(offset:end)-x(1:(vlen-offset+1))));
roadslope_R = atan2((z_R(offset:end)-z_R(1:(vlen-offset+1))),(x(offset:end)-x(1:(vlen-offset+1))));

scene_data.Road.qyLUT.px = x;
scene_data.Road.qyLUT.qy(:,1) = -[0 ;roadslope_L];
scene_data.Road.qyLUT.qy(:,2) = -[0 ;roadslope_R];
