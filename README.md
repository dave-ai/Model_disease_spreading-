# Model_desease_spreading-
1) BASIC RATIONALE\
MATLAB model of the spreading of a desease in a population.\
The model implements a population in which each individual is resembled by a state machine, transitioning in between health stati based on the different stages of the infection.\ 
The model is currently tailored on the data and on the possible outcomes that the Covid-19 infection might cause.\
\

2) HEALTH-STATUS STATE MACHINE DESCRIPTION\
a) Each person of the simulated population has an associated health status.\
b) The people are all initialized as HEALTHY aside from a person who is initialized as infective.\
c) Each infected person starts being infective from the day following his infection and keeps being 
infective until the first sympthoms show up. This time varies from person to person and it is drawn  
in a Gaussian distribution of mean value = 7 days and 3sigma = 7 days. The health status transitions  
into SICK IN ISOLATION.\ 
d) Once sick, each patient's disease course might follow different paths, i.e. standard healing, reqiring hospitalization or perishing.\ 
e) Each survived person is then considered immune from further infections.\ 

The visual description of the state machine is reported hereby: \
![picture](https://github.com/dave-ai/Model_desease_spreading-/blob/master/images/state_machine_person.JPG)

3) HOW TO USE ME\
Before launching a simulation, open the loadParam.m script and set up the parameters characterising the requested population. 
Additionally the parameters related to the post processing are included.\
Once that has been set up, run the master_script_v2.m script.



 
