function [out1, out2, out3, out4, out5] = tryToInfectNewPersonV2(person, number, infecting_person, tot_infected, num_infected_per_day, iTime, iPeople, dbg_msg)
%%TRYTOINFECTNEWPERSON is called to establish which people are met (and
%%possibly infected) by an already infected person during his incubation
%%period.
%
%   Before showing sympthoms and thus starting the quaratine, each person
%   has the chance to infect same other people. If the person met is healty 
%   and not immune, it gets in turn infected. 
%   
%   original author: Davide Grande
%   date: 19-March-2020
%


out4 = false; % baseline: no patient gets infected

if person.health_status == 1 %if healthy
    
    % updated health state of the infected person
    person.health_status = 2;
    person.day_of_infection = iTime; 
    
    infecting_person.infected_people = infecting_person.infected_people + 1;

    out4 = true; % a person has been infected
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

