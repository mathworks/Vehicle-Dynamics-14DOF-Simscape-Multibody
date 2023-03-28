brk_cyc = 1;
brk_dc  = 5;

valve_maxA = 0.25*pi*1^1;
valve_maxO = 0.005;
valve_leak = 1e-12;
valve_x0   = 0;
valve_ts   = 0.001;

wheel_rad  = 0.3;
wheel_mus  = 0.2;
wheel_muk  = 0.15;
wheel_vth  = 0.01;

brake_rad  = 0.04;  % m
brake_muk  = 0.3*2;
brake_mus  = 0.35*2;

brake_pistA = 0.25*pi*40^2; % mm^2
brake_x0    = 1; % mm
brake_p0    = 0; % Pa

brake_trqTs = 0.01;


pump_mtrw   = 1000           *15; % RPM
pump_mtrTs  = 1/20;
pump_chkv_Amax = 0.25*pi*4.33*2; % mm^2
pump_chkv_crkP = 2376.85   /2; % Pa
pump_chkv_maxP = 3e5       /2; % Pa
pump_orifP = 0.25*pi*(0.015)^2;

mc_area = 0.25*pi*30^2;

road_mus = 0.7;
road_muk = 0.65;

MFormulaCoeff.DryTarmac = [10 1.9 1 0.97];
MFormulaCoeff.WetTarmac = [12 2.3 0.82 1];
MFormulaCoeff.Snow      = [5 2 0.3 1];
MFormulaCoeff.Ice       = [4 2 0.1 1];

