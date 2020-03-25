function [output] = deseaseCourse(person)
%DESEASECOURSE establish what is the course of the desease of each patient;
% it is based on the statistics data for Covid-19 available at March the
% 19th 2020.
%
% The infected person might get a standard course of the desease with mild
% sympthoms, might required to get hospitalized or might die
%
%   
%   original author: Davide Grande
%   date: 19-March-2020
%


outcome = randi(100,1);
if outcome <= 80
    person.healing = true;
elseif outcome >= 96
    person.fatal_sickness = true;
else
    person.hospitalized = true;
end

% person.sick_in_isolation = false;

output = person;
end

