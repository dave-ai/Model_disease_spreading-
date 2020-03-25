function [out1, out2, out3, out4, out5] = tryToInfectNewPerson(person, number, infecting_person, tot_infected, num_infected_per_day, iTime, iPeople, dbg_msg)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

out4 = false; % baseline: no patient infected

if person.healty == true && person.immune == false
    
    % updated health state of the infected person
    person.healty = false;
    person.sick = true;
    person.day_of_infection = iTime; 
    
    infecting_person.infected_people = infecting_person.infected_people + 1;

    out4 = true; % the person has been infected
    tot_infected = tot_infected + 1;
    num_infected_per_day = num_infected_per_day + 1;
    
    
    if dbg_msg
        message = ['New infection: person #', num2str(iPeople),  ' infects #', num2str(number) ];  
        warning(message);
    end
end

out1 = person;
out2 = tot_infected;
out3 = num_infected_per_day;
out5 = infecting_person;

end

