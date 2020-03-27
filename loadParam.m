%% Script containing the parameters of the simulation
%   
%   original author: Davide Grande
%   date: 19-March-2020
%

%% Generic parameters to be edited for the simulation
num_months = 6;                 % [months]: timespan of the simulation 
num_popul = 10000000;           % number of the population (currently 10 milions people)
max_number_trial = 1;           % how many times a person has the chance to infect others: set it to 1 if not sure about what to do with this value
dbg_msg = false;                % set to true for additional printout information
postpro = true;                 % set this variable to true if you need the plots at the end of the simu
saveWs = false;                 % set this to true if you need the workspace to be saved
nameWs = 'ws_1';                % set the name of the worspace to be saved


% A1) desease params - Covid-19 params 
R0 = 2.28;                           % R0 denotes the number of people getting the infection from a sick person wondering around before he starts showing sympthoms and thus starts the quarantine
std_dev_R0 = 0.24/2;                 % standard deviation of R0
average_days_before_sickness = 7;    % average number of days of infected patients before they start showing sympthoms 
average_day_sickness = 10;           % average days of sickness - not currenlty used 
days_of_quarantine = 14;             % recommended days of quarantine after showing the sympthoms 
days_of_heavy_disease = 21;          % days of heavy sickness for the patients getting the virus in the most aggressive forms 


% A3) Post-processing params
plot_quant = 1;                      % plot quantization - variable used to reduce the dimensions of the plots - set it to 1 if not sure what to do with it or if you obtain plots with no data points 


%% Internal params: NOT to be edited 
num_days = 30*num_months;       % [days]: length of the simulation - DO NOT modify it 