function [output] = diseaseCourseV2(person)
%DISEASECOURSE establish what is the course of the disease of each patient;
% it is based on the statistics data for Covid-19 available at March the
% 19th 2020.
%
% The infected person might get a standard course of the disease with mild
% sympthoms, might required to get hospitalized or might die
%
%   
%   original author: Davide Grande
%   date: 19-March-2020
%


    outcome = randi(100,1);
    if outcome <= 80
        person.health_status = 5;
    elseif outcome >= 96
        person.health_status = 8;
    else
        person.health_status = 6;
    end

    % person.sick_in_isolation = false;

    output = person;
end




