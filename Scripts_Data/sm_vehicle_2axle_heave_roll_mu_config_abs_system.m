function sm_vehicle_2axle_heave_roll_mu_config_abs_system(b_h,brk_index)
% Copyright 2019-2024 The MathWorks, Inc.

switch brk_index
    case 1 % 'damper'
        set_param(b_h,'control_mode','Mode');
        set_param(b_h,'brake_type','Damper');
        set_param(b_h,'AttributesFormatString','Damper');
    case 2 % 'ideal'
        set_param(b_h,'control_mode','Mode');
        set_param(b_h,'brake_type','Disc');
        set_param(b_h,'actuator_type','Ideal');
        set_param(b_h,'AttributesFormatString','Disc, Ideal');
    case 3 % 'hydraulic'
        set_param(b_h,'control_mode','Mode');
        set_param(b_h,'brake_type','Disc');
        set_param(b_h,'actuator_type','Hydraulic');
        set_param(b_h,'AttributesFormatString','Disc, Pressure');
    case 4 % 'valves'
        set_param(b_h,'control_mode','Valve Open-Loop');
        set_param(b_h,'brake_type','Disc');
        set_param(b_h,'actuator_type','Valves');
        set_param(b_h,'AttributesFormatString','Disc, Valves, Open-Loop');
    case 5 % 'control'
        set_param(b_h,'control_mode','Valve Closed-Loop');
        set_param(b_h,'brake_type','Disc');
        set_param(b_h,'actuator_type','Valves');
        set_param(b_h,'AttributesFormatString','Disc, Valves, Closed-Loop');
end
