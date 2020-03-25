function [number_infection] = infectionPerPatient (R0, std_dev_R0)
%INFECTIONPERPATIENT establishes how many people is the current infected
%person going to infect. 
%
% The number of new infections associated for each person is generated
% within a gaussian distribution of means R0 and standard dev = std_dev_R0
%

flag_generate = true; 
while flag_generate
    number_infection = R0 + std_dev_R0*randn(1);
    
    if number_infection > 0         %if the value is acceptable 
        flag_generate = false;
    end
    
end

end

