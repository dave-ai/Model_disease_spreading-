%% Master script to be launched for a simulation run
%   The script simulates the spread of a disease in a population with a
%   single infected person.
%   
%   1) The parameters are stored in the 'loadParam' script.
%   2) The post-processing is carried on in the 'postProcessing' script. 
%   
%   original author: Davide Grande
%   date: 19-March-2020
%


clc
clear all
close all


%% A - general parameters
disp('log: loading parameters');
tic
loadParam;


%% B - initializing variables
% B2) post-processing variables
num_infected_cumulative = zeros(1,num_days);        % infested cumulative
num_healed_cumulative = zeros(1,num_days);          % healed cumulativd 
num_dead_cumulative = zeros(1,num_days);            % dead cumulative 
num_hospitalized_cumulative = zeros(1, num_days);   % cumulative in hospital

num_currently_in_hospital = zeros(1,num_days);      % numer of patients in hospitals
num_currently_sick_in_isolation = zeros(1,num_days);% number of patients currently sick all isolation forms
num_currently_sick_tot = zeros(1,num_days);         % number of patients currently sick (even the ones not aware)


tot_healing = 0;
tot_hospitalized = 0;
tot_fatal_sickness = 0;
tot_dead = 0;
tot_immune = 0;
tot_infected = 1; 
num_infected_per_day = zeros(1,num_days);           % infected per day
num_healed_per_day = zeros(1,num_days);             % healed per day
num_hospitalized_per_day = zeros(1,num_days);       % hospitalized per day 
num_fatally_sick_per_day = zeros(1,num_days);       % new fatally sick per day
num_dead_per_day = zeros(1,num_days);               % dead per day 
num_immuned_per_day = zeros(1,num_days);            % become immune per day


% initializing first value of infection
num_infected_per_day(1,1) = 1; 
num_infected_cumulative(1,1) = 1;
num_currently_sick_tot(1,1) = 1;
toc

%% C - initializing people 
disp('log: initializing population');
tic
struct_people = repmat(PersonClassV3(1, 14, 7), [1,num_popul]);
toc

disp('log: resetting day of activation');
tic
% C1) reset day to activation
std_dev = 2.3;
b = average_days_before_sickness;
for iPeople = 1:num_popul
    
    flag_iteration = true;
    while flag_iteration
        struct_people(1,iPeople).time_for_the_desease_to_activate = ceil(std_dev.*randn(1) + b);
        if struct_people(1,iPeople).time_for_the_desease_to_activate >= 1 
            flag_iteration = false; % the value is meaningful 
        end
    end
    
end
toc

% C2) reset age and potential_infections
disp('log: resetting age and infective days');
tic
for iPeople = 1:num_popul
        struct_people(1,iPeople).age = randi(80, 1);
        number_infections = infectionPerPatient (R0, std_dev_R0); 
        struct_people(1,iPeople).potential_infections = round(number_infections);

end

% C3) init case 0
struct_people(1,1) = PersonClassV3(2, 14, 7);
struct_people(1,1).day_of_infection = 0; % gets infected on day 0

% C4) days in which the person is infective  
for iPeople = 1:num_popul
    
    for iInfections = 1:struct_people(1,iPeople).potential_infections
        struct_people(1,iPeople).days_of_transmission(1,iInfections) = randi(struct_people(1,iPeople).time_for_the_desease_to_activate,1);

    end
end
toc

%% D - simulation 
tic
for iTime = 1:num_days
    message1 = ['log: day #', num2str(iTime)];
    disp(message1);
       
    diff_in_hospital = 0;
    diff_sick_in_isolation = 0;
    diff_infective_tot = 0;
    
    for iPeople = 1:num_popul
        % from sick to infective
        if struct_people(1,iPeople).health_status == 2 && struct_people(1,iPeople).time_from_infection == 1
            struct_people(1,iPeople).health_status = 3; %infective
            
            diff_infective_tot = diff_infective_tot + 1;
        end
        
        % the person can infect
        if struct_people(1,iPeople).health_status == 3 
            if dbg_msg
                msg2 = ['Person #', num2str(iPeople), ' is infective'];
                disp(msg2);
            end
            
            % determine the possible new infections 
            if struct_people(1,iPeople).infected_people >= struct_people(1,iPeople).potential_infections
                % do nothing 
            else %still potential infections 
                % check if today is one day of possible infections
                for iInfection = 1:struct_people(1,iPeople).potential_infections
                    if struct_people(1,iPeople).time_from_infection == struct_people(1,iPeople).days_of_transmission(1,iInfection)

                        new_infection = false;
                        number_trial = 0;

                        while number_trial < max_number_trial && new_infection == false
                              contact_with = randi(num_popul, 1); % choosing the possible person 
                              [struct_people(1,contact_with), tot_infected, num_infected_per_day(1,iTime), new_infection, struct_people(1,iPeople)] = ...
                                    tryToInfectNewPersonV2(struct_people(1,contact_with), contact_with, struct_people(1,iPeople), tot_infected, ...
                                    num_infected_per_day(1,iTime), iTime, iPeople, dbg_msg);
                                if new_infection == false % nobody has been infected
                                    number_trial = number_trial + 1;
                                end
                        end       
                    end
                end
            end

            
            % from infective to sick in isolation
            if struct_people(1,iPeople).time_from_infection >= struct_people(1,iPeople).time_for_the_desease_to_activate

                struct_people(1,iPeople).health_status = 4; %sick in isolation
                
                diff_infective_tot = diff_infective_tot - 1;
                diff_sick_in_isolation = diff_sick_in_isolation + 1;
                
                if dbg_msg
                   msg3 = ['Person #', num2str(iPeople), ' , after ', num2str(struct_people(1,iPeople).time_from_infection), ' days of infection (out of ' , num2str(struct_people(1,iPeople).time_for_the_desease_to_activate) , ') feels sick and gets in isolation'];
                   disp(msg3);
                end
            end
            
        % establishing which course of the desease 
        elseif struct_people(1,iPeople).health_status == 4
            
%             struct_people(1,iPeople).sick_in_isolation = false;
            
            if dbg_msg
                msgDeb1 = ['Establishing disease severity for person #', num2str(iPeople)];
                disp(msgDeb1);
            end
            
            % establishing which course of the desease 
            struct_people(1,iPeople) = deseaseCourseV2(struct_people(1,iPeople));
            if struct_people(1,iPeople).health_status == 5 
                if dbg_msg
                    msgDeb1 = ['Person #', num2str(iPeople), ' has a standard course of the desease'];
                    disp(msgDeb1);
                end
                num_healed_per_day(1,iTime) = num_healed_per_day(1,iTime) + 1;
                tot_healing = tot_healing + 1;
            elseif struct_people(1,iPeople).health_status == 6
                num_hospitalized_per_day(1,iTime) = num_hospitalized_per_day(1,iTime) + 1;
                tot_hospitalized = tot_hospitalized + 1;
                diff_in_hospital = diff_in_hospital + 1;
                if dbg_msg
                    msgDeb1 = ['Person #', num2str(iPeople), ' gets hospitalized'];
                    warning(msgDeb1);
                end
            elseif struct_people(1,iPeople).health_status == 8
                num_fatally_sick_per_day(1,iTime) = num_fatally_sick_per_day(1,iTime) + 1;
                tot_fatal_sickness = tot_fatal_sickness + 1;
                if dbg_msg
                    msgDeb1 = ['Person #', num2str(iPeople), ' gets a fatal infection'];
                    warning(msgDeb1);
                end
            end
                  
        % healing people    
        elseif struct_people(1,iPeople).health_status == 5
            if struct_people(1,iPeople).time_from_desease_activation >= days_of_quarantine
                struct_people(1,iPeople).health_status = 7;
                num_immuned_per_day(1,iTime) = num_immuned_per_day(1,iTime) + 1;
                tot_immune = tot_immune + 1;
                diff_sick_in_isolation = diff_sick_in_isolation - 1;

                if dbg_msg
                    msgDeb1 = ['Person #', num2str(iPeople), ' was healing. After ', num2str(struct_people(1,iPeople).time_from_desease_activation), ' days, gets outside and immune.'];
                    disp(msgDeb1);
                end
            end
            
        % hospitalized people
        elseif struct_people(1,iPeople).health_status == 6
            if struct_people(1,iPeople).time_from_desease_activation >= days_of_heavy_disease
                struct_people(1,iPeople).health_status = 7;
                num_immuned_per_day(1,iTime) = num_immuned_per_day(1,iTime) + 1;
                diff_in_hospital = diff_in_hospital -1 ;
                tot_immune = tot_immune + 1;
                diff_sick_in_isolation = diff_sick_in_isolation - 1;

                if dbg_msg
                    msgDeb1 = ['Person #', num2str(iPeople), ' was in hospital. After ', num2str(struct_people(1,iPeople).time_from_desease_activation), ' days,gets outside and immune.'];
                    warning(msgDeb1);
                end

            end    
                
        % fatally infected people    
        elseif struct_people(1,iPeople).health_status == 8
            if struct_people(1,iPeople).time_from_desease_activation >= days_of_quarantine
                struct_people(1,iPeople).health_status = 9;
                num_dead_per_day(1,iTime) = num_dead_per_day(1,iTime) + 1;
                tot_dead = tot_dead + 1;
                diff_sick_in_isolation = diff_sick_in_isolation - 1;

                
                if dbg_msg
                    msgDeb1 = ['Person #', num2str(iPeople), ' was having a fatal infection. After ', num2str(struct_people(1,iPeople).time_from_desease_activation), ' days, dies.'];
                    warning(msgDeb1);
                end
            end
        end
        
        
    end %ends cycles over people 
    
    if iTime > 1 %excludes day 1 
        num_infected_cumulative(1,iTime) = num_infected_cumulative(1,iTime-1) + num_infected_per_day(1,iTime);
        num_healed_cumulative(1,iTime) = num_healed_cumulative(1,iTime-1) + num_healed_per_day(1,iTime);
        num_dead_cumulative(1,iTime) = num_dead_cumulative(1,iTime-1) + num_dead_per_day(1,iTime);
        num_hospitalized_cumulative(1, iTime) = num_hospitalized_cumulative(1,iTime-1) + num_hospitalized_per_day(1,iTime);
        num_currently_in_hospital(1, iTime) = num_currently_in_hospital(1, iTime-1) + diff_in_hospital;  
        num_currently_sick_in_isolation(1, iTime) =  num_currently_sick_in_isolation(1, iTime-1) + diff_sick_in_isolation;
        num_currently_sick_tot(1, iTime) = num_currently_sick_tot(1, iTime-1) + diff_sick_in_isolation + diff_infective_tot;
    end    
    
    
    % incrementing timing counters 
    for iPeople = 1:num_popul
        
        % time from infections 
        if struct_people(1,iPeople).health_status == 2 || struct_people(1,iPeople).health_status == 3
            struct_people(1,iPeople).time_from_infection = struct_people(1,iPeople).time_from_infection + 1;
        end
        
        % times from sickness (for all the people who are sick_in_isolation
        % (i.e. alive, healing or hospitalized)
        if (struct_people(1,iPeople).health_status == 5 || struct_people(1,iPeople).health_status == 6 || ...
                struct_people(1,iPeople).health_status == 8 ) 
            struct_people(1,iPeople).time_from_desease_activation = struct_people(1,iPeople).time_from_desease_activation + 1;
        end
        
        
    end 
    
    
end %ends cycle over days 
toc % toc of the simulation duration 

%% save workspace
if saveWs
    save(nameWs); 
end

%% E - post-processing 
if postpro
    postProcessing; 
end

