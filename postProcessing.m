%% Post-processing script to be called at the end of a simulation
% Plots of the relevant simulation variables 
%   
%   original author: Davide Grande
%   date: 19-March-2020
%



%% printout of the totals 
tot_healing 
tot_hospitalized 
tot_fatal_sickness 
tot_dead 
tot_immune 
tot_infected


%% plots of the variables expressed per day (e.g. new infections per day ecc. )
figure;
subplot(3,2,1)
plot(num_infected_per_day(1:plot_quant:end));
grid on 
title('Number of daily new infections');
xlabel('[days]')

subplot(3,2,2)
plot(num_healed_per_day(1:plot_quant:end));
grid on 
title('Number of daily new healing');
xlabel('[days]')

subplot(3,2,3)
plot(num_hospitalized_per_day(1:plot_quant:end));
grid on 
title('Number of daily new hospitalized');
xlabel('[days]')


subplot(3,2,4)
plot(num_fatally_sick_per_day(1:plot_quant:end));
grid on 
title('Number of daily new fatally sick');
xlabel('[days]')

subplot(3,2,5)
plot(num_dead_per_day(1:plot_quant:end));
grid on 
title('Number of daily new dead');
xlabel('[days]')

subplot(3,2,6)
plot(num_immuned_per_day(1:plot_quant:end));
grid on 
title('Number of daily new immune');
xlabel('[days]')


%% plots of the cumulative variables (e.g. cumulated infections up to date)
figure;
subplot(2,2,1)
plot(num_infected_cumulative(1:plot_quant:end));
grid on 
title('Number of cumulative infected ');
xlabel('[days]')

subplot(2,2,2)
plot(num_healed_cumulative(1:plot_quant:end));
grid on 
title('Number of cumulative healed ');
xlabel('[days]')

subplot(2,2,3)
plot(num_dead_cumulative(1:plot_quant:end));
grid on 
title('Number of cumulative deaths');
xlabel('[days]')

subplot(2,2,4)
plot(num_hospitalized_cumulative(1:plot_quant:end));
grid on 
title('Number of cumulative hospitalized');
xlabel('[days]')
 

figure;
plot(num_currently_in_hospital(1:plot_quant:end));
grid on 
title('Number of patients in hospitals');
xlabel('[days]')


figure;
plot(num_currently_sick_in_isolation(1:plot_quant:end));
grid on 
title('Number of patients sick in isolation');
xlabel('[days]')


%% plot of the variable split per month 
for iMonth = 1:num_months

    figure;
    subplot(3,2,1)
    plot(num_infected_per_day(iMonth:plot_quant:(iMonth+1)));
    grid on 
    title(['Number of daily new infections - month # ', num2str(iMonth)]);
    xlabel('[days]')

    subplot(3,2,2)
    plot(num_healed_per_day(iMonth:plot_quant:(iMonth+1)));
    grid on 
    title(['Number of daily new healing - month # ', num2str(iMonth)]);    
    xlabel('[days]')

    subplot(3,2,3)
    plot(num_hospitalized_per_day(iMonth:plot_quant:(iMonth+1)));
    grid on 
    title(['Number of daily new hospitalized - month # ', num2str(iMonth)]);   
    xlabel('[days]')


    subplot(3,2,4)
    plot(num_fatally_sick_per_day(iMonth:plot_quant:(iMonth+1)));
    grid on 
    title(['Number of daily new fatally sick - month # ', num2str(iMonth)]);    
    xlabel('[days]')

    subplot(3,2,5)
    plot(num_dead_per_day(iMonth:plot_quant:(iMonth+1)));
    grid on 
    title(['Number of daily new dead - month # ', num2str(iMonth)]);    
    xlabel('[days]')

    subplot(3,2,6)
    plot(num_immuned_per_day(iMonth:plot_quant:(iMonth+1)));
    grid on 
    title(['Number of daily new immunes - month # ', num2str(iMonth)]);    
    xlabel('[days]')

end

%% plotting R0
R0_time = zeros(1,num_days);
for iTime = 1:num_days
   
    num_new_infected = 0; %temporary variable: how many gets infected that day
    tot_consequent_infected = 0; 
    
    for iPeople = 1:num_popul
        if struct_people(1,iPeople).day_of_infection == iTime
            num_new_infected = num_new_infected + 1;
            tot_consequent_infected = tot_consequent_infected + struct_people(1,iPeople).infected_people; % summing up how many infections will derive form the ones infected today
        end
    end
    
    if num_new_infected >=1 
        R0_time(1,iTime) = tot_consequent_infected / num_new_infected; 
    end
    
end

figure
plot(R0_time);
title('real R0 evolution over time');
xlabel('[days]')

