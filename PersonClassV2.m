classdef PersonClassV2
%%PERSONCLASSV2 implements a class resembling a person within a population
%
% It represents a person within the population
%   inputs: [ healty sick infective sick_in_isolation ...
%              fatal_sickness hospitalized healing dead immune age ... 
%               potential_infections infected_people time_to_heal time_for_the_desease_to_activate]     
%
%   original author: Davide Grande
%   date: 19-March-2020
%

    properties
        healty                              % = true
        sick                                % = false
        infective                           % = false
        sick_in_isolation                   % = false
        fatal_sickness                      % = false
        hospitalized                        % = false
        healing                             % = false
        dead                                % = false 
        immune                              % = false;
        age                                 % age of the person 
        potential_infections                % how many people can this person infect 
        infected_people                     % how many people has this person infected
        time_to_heal                        % [days]
        time_for_the_desease_to_activate    % [days]
        time_from_infection                 % [days]
        time_from_desease_activation        % [days]
        days_of_transmission                % array containing in which day the person will transmit the infection
        day_of_infection                    % day in which the person gets infected
      
    end
    
    methods
        function obj = PersonClassV2(in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here

            if nargin<1
                warning('Class called with no input parameters');   
                obj.healty = true;                             
                obj.sick = false;                                
                obj.infective = false;                          
                obj.sick_in_isolation = false; 
                obj.fatal_sickness = false;
                obj.hospitalized = false; 
                obj.healing = false;
                obj.dead = false;                               
                obj.immune = false; 
                obj.age = setAge;
                obj.potential_infections = 2;
                obj.infected_people = 0;
                obj.time_to_heal = 7;                        
                obj.time_for_the_desease_to_activate = randomActivation(7);
                obj.time_from_infection = 0;
                obj.time_from_desease_activation = 0;
                obj.days_of_transmission = [-1 -1 -1];
                obj.day_of_infection = -1;              % convention: -1 means that the person never get infected 
            else 
                obj.healty = in1;                              
                obj.sick = in2;                                    
                obj.infective = in3;                            
                obj.sick_in_isolation = in4;
                obj.fatal_sickness = in5;
                obj.hospitalized = in6; 
                obj.healing = in7;
                obj.dead = in8;                                     
                obj.immune = in9;       
                obj.time_to_heal = in10;                              
                obj.time_for_the_desease_to_activate = randomActivation(in11);      
                obj.age = setAge();                             % to be overwritten
                obj.potential_infections = 2;                   % to be overwritten
                obj.infected_people = 0;                  
                obj.time_from_infection = 0;
                obj.time_from_desease_activation = 0;
                obj.day_of_infection = -1;              % convention: -1 means that the person never get infected 

            end
            
        end
        
    end
end

function r = randomActivation(inputArg)
    % this function draws a random activation time of the desease: it represents
    % the time in which a patien has not sympthoms and therefore keeps
    % infecting surronding people 
    flag_iteration = true;
    while flag_iteration
        r = ceil(inputArg+2.3*randn(1));
        if r >= 0 
            flag_iteration = false; % the value is meaningful 
        end
    end
end

function age = setAge()
    % this function randomly draws the age of the patient 
    
    age = randi(80, 1);
end



