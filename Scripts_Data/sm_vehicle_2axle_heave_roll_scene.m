% Parameters used in scenes of sm_vehicle_2axle_heave_roll.slx

color = simmechanics.demohelpers.colors;
SceneData.Reference.yaw   = 0; % rad
SceneData.Reference.pitch = 0; % rad
SceneData.Reference.roll  = 0; % rad

%% Grid %%
SceneData.Grid.length       = 400;  % m
SceneData.Grid.width        = 400;  % m
SceneData.Grid.depth        = 0.02; % m
SceneData.Grid.linewidth    = 0.08; % m
SceneData.Grid.numsquaresx  = 40; % m
SceneData.Grid.numsquaresy  = 40; % m
SceneData.Grid.linecolor    = [1 1 1]; % [RGB]
SceneData.Grid.planecolor   = [0.8 0.8 0.8]; % [RGB]


%% Road %%
SceneData.Road.markings.segmentLength = 3;     % m
SceneData.Road.markings.segmentWidth  = 0.15;  % m
SceneData.Road.markings.segmentDepth  = 0.005; % m
SceneData.Road.markings.spacing       = 9;     % m
SceneData.Road.markings.numMarkings   = 36;
SceneData.Road.markings.color = color.white;

SceneData.Road.length = SceneData.Road.markings.segmentLength + ...
  (SceneData.Road.markings.numMarkings - 1) * (SceneData.Road.markings.segmentLength + SceneData.Road.markings.spacing);
SceneData.Road.width  = 7.2; % m
SceneData.Road.depth  = 0.1; % m
SceneData.Road.dim    = [SceneData.Road.length SceneData.Road.width SceneData.Road.depth];
SceneData.Road.color  = color.grey;

SceneData.Road.markings.extrusion = roadMarkingsExtrusion(SceneData.Road);

SceneData.Plateau = sm_car_scenedata_rdf_plateau;
SceneData.Rough_Road = sm_car_scenedata_rdf_rough_road;

%% Grass Verge %%

SceneData.Road.verge.length = SceneData.Road.length;
SceneData.Road.verge.width  = 5;                 % m
SceneData.Road.verge.depth  = SceneData.Road.depth - 0.05; % m
SceneData.Road.verge.dim    = [SceneData.Road.verge.length SceneData.Road.verge.width SceneData.Road.verge.depth];
SceneData.Road.verge.color  = [0.8 1.0 0.8];


%% Road Markings Extrusion Helper Function %%

function extrusion = roadMarkingsExtrusion(road)

extrusion = [0 0; road.length 0; road.length road.depth + road.markings.segmentDepth];

nextMarking_y1 = road.depth + road.markings.segmentDepth;
nextMarking_y2 = 0.5 * road.depth;
nextMarking_y3 = nextMarking_y2;
nextMarking_y4 = nextMarking_y1;

for i = 1:road.markings.numMarkings-1
  nextMarking_x1 = extrusion(end, 1) - road.markings.segmentLength;
  nextMarking_x2 = nextMarking_x1;
  nextMarking_x3 = extrusion(end, 1) - road.markings.segmentLength - road.markings.spacing;
  nextMarking_x4 = nextMarking_x3;
  nextMarking = [nextMarking_x1, nextMarking_y1; 
                 nextMarking_x2, nextMarking_y2;
                 nextMarking_x3, nextMarking_y3; 
                 nextMarking_x4, nextMarking_y4];
  extrusion = [extrusion; nextMarking]; %#ok<AGROW>
end

extrusion(end + 1, 1) = 0;
extrusion(end, 2) = road.depth + road.markings.segmentDepth;

end


