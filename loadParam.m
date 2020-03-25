%% script containing the parameters of the simulation

num_months = 8;

num_days = 30*num_months;
num_popul = 10000000; %ten milion
print_param = false;
max_number_trial = 1;
dbg_msg = false;

% A1) desease params 
R0 = 2.28;                           % R0 denotes the number of people getting the infection every day from a sick person wondering around 
std_dev_R0 = 0.24/2;
average_days_before_sickness = 7; 
average_day_sickness = 10;
days_of_quarantine = 14;
days_of_heavy_disease = 21;


% A3) Post-processing params
plot_quant = 1000; % plot quantization  