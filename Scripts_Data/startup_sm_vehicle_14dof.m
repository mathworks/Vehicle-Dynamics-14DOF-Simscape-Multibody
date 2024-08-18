%% Copyright 2021-2024 The MathWorks, Inc.

% Add MF-Swift software to path if it can be found
if(exist('sm_vehicle_startupMFSwift.m','file'))
    [~,MFSwifttbx_folders]=sm_vehicle_startupMFSwift;
    assignin('base','MFSwifttbx_folders',MFSwifttbx_folders);
end

% Parameters
sm_vehicle_2axle_heave_roll_abs_param

% Open Overiew
web('sm_vehicle_2axle_heave_roll_Overview.html');

% Open model
sm_vehicle_2axle_heave_roll
