function [mu_surface, p1, p2] = sm_vehicle_2axle_heave_roll_mu_config_icepatch(patch_config)

patch_depth = 0.011;

switch(lower(patch_config))
    case('right_low_patch')
        mu_surface = 1;
        p1.mu = 0.5;
        p1.xstart =  15;
        p1.xend   =  25;
        p1.ystart = -10;
        p1.yend   =   0;
        p1.opc    =   1;
        p2.mu     =   1;
        p2.xstart = -25;
        p2.xend   = -15;
        p2.ystart =   0;
        p2.yend   =  10;
        p2.opc    =   0;
    case('right_low_split')
        mu_surface = 1;
        p1.mu = 0.5;
        p1.xstart =  15;
        p1.xend   = 100;
        p1.ystart = -10;
        p1.yend   =   0;
        p1.opc    =   1;
        p2.mu     =   1;
        p2.xstart = -25;
        p2.xend   = -15;
        p2.ystart =   0;
        p2.yend   =  10;
        p2.opc    =   0;
    case('low_to_high')
        mu_surface= 1;
        p1.mu     = 0.5;
        p1.xstart =   0;
        p1.xend   =  25;
        p1.ystart = -10;
        p1.yend   =  10;
        p1.opc    =   1;
        p2.mu     =   1;
        p2.xstart = -25;
        p2.xend   = -15;
        p2.ystart =   0;
        p2.yend   =  10;
        p2.opc    =   0;
    case('high_to_low')
        mu_surface= 1;
        p1.mu     =   1;
        p1.xstart =   0;
        p1.xend   =  25;
        p1.ystart = -10;
        p1.yend   =  10;
        p1.opc    =   0;
        p2.mu     =   0.5;
        p2.xstart =  25;
        p2.xend   = 100;
        p2.ystart = -10;
        p2.yend   =  10;
        p2.opc    =   1;
    case('checker_right')
        mu_surface = 1;
        p1.mu     = 0.3;
        p1.xstart =  15;
        p1.xend   =  25;
        p1.ystart = -10;
        p1.yend   =   0;
        p1.opc    =   1;
        p2.mu     = 0.3;
        p2.xstart =  25;
        p2.xend   =  35;
        p2.ystart =   0;
        p2.yend   =  10;
        p2.opc    =   1;
end

p1.dim    = [p1.xend-p1.xstart p1.yend-p1.ystart patch_depth];
p1.offset = [(p1.xend+p1.xstart)/2 (p1.yend+p1.ystart)/2 0];

p2.dim    = [p2.xend-p2.xstart p2.yend-p2.ystart patch_depth];
p2.offset = [(p2.xend+p2.xstart)/2 (p2.yend+p2.ystart)/2 0];


