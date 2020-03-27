classdef PersonClassV3
%%PERSONCLASSV3 implements a class resembling a person within a population.
%
% It represents a person within the population.
% It improves the PersonClassV2 by clustering the health status
% information in a single attribute (in turn called health_status).
%
%   inputs: [ health_status age ... 
%               potential_infections infected_people time_to_heal time_for_the_desease_to_activate]     
%
%   original author: Davide Grande
%   date: 19-March-2020
%

    properties
        health_status                       % storing the health status of the person: 1 = healthy, 2 = sick, 3 = infective, 4 = sick in isolation, 5 = healing, 6 = hospitalized, 7 = immune, 8 = fatal sickness, 9 = dead
%         age                                 % age of the person 
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
        function obj = PersonClassV3(in1, in2, in3)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here

            if nargin<1
                warning('Class called with no input parameters');   
                obj.health_status = 1;                             
%                 obj.age = setAge;
                obj.potential_infections = 2;
                obj.infected_people = 0;
                obj.time_to_heal = 7;                        
                obj.time_for_the_desease_to_activate = randomActivation(7);
                obj.time_from_infection = 0;
                obj.time_from_desease_activation = 0;
                obj.days_of_transmission = [-1 -1 -1];
                obj.day_of_infection = -1;              % convention: -1 means that the person never get infected 
            else 
                obj.health_status = in1;                                 
                obj.time_to_heal = in2;                              
                obj.time_for_the_desease_to_activate = randomActivation(in3);      
%                 obj.age = setAge();                             % to be overwritten
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

% function age = setAge()
%     % this function randomly draws the age of the patient 
%     
%     age = randi(80, 1);
% end



