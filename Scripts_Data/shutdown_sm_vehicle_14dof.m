%% Copyright 2021-2024 The MathWorks, Inc.
% Add shutdown commands here

if(exist('MFSwifttbx_folders','var'))
    if (~isempty(MFSwifttbx_folders))
        disp('Removing MF-Swift from path');
        for mfs_i = 1:length(MFSwifttbx_folders)
            rmpath(MFSwifttbx_folders{mfs_i})
        end
    end
    clear MFSwifttbx_folders
end