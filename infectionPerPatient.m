function [number_infection] = infectionPerPatient (R0, std_dev_R0)
%INFECTIONPERPATIENT 

flag_generate = true; 
while flag_generate
    number_infection = R0 + std_dev_R0*randn(1);
    
    if number_infection > 0 % value acceptable 
        flag_generate = false;
    end
    
end

end

