function [output] = deseaseCourse(person)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

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

