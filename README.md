# Model_desease_spreading-
## 1) BASIC RATIONALE
MATLAB model of the spreading of a desease in a population.  
The model implements a population in which each individual is resembled by a state machine, transitioning in between health stati based on the different stages of the infection.  
The model is currently tailored on the data and on the possible outcomes that the Covid-19 infection might cause. 


## 2) HEALTH-STATUS STATE MACHINE DESCRIPTION
a) Each person of the simulated population has an associated health status. 
b) The people are all initialized as healthy aside from a person who is initialized as infective.  
c) Each infected person starts being infective from the day following his infection and keeps being infective until the first sympthoms show up. This time varies from person to person and it is drawn in a Gaussian distribution of mean value = 7 days and 3sigma = 7 days. Following, the health status transitions into sick in isolation.  
d) Once sick, each patient's disease course might follow different paths, i.e. standard healing, reqiring hospitalization or perishing.  
e) Each survived person is then considered immune from further infections. 

The visual description of the state machine is reported hereby:
![picture](https://github.com/dave-ai/Model_desease_spreading-/blob/master/images/state_machine_person.JPG)

## 3) HOW TO USE ME
Before launching a simulation, open the loadParam.m script and set up the parameters characterising the requested population.  
Additionally the parameters related to the post processing are included.  
Once that has been set up, run the master_script_vX.m script.

## 4) RESULTS
Meaningful results are reported in the **res** folder. 

## 5) PERFORMANCES
Being the code computationally expensive to be run for consistent populations (e.g. > 10^6 people), this section has the purpose to provide an approximate computational time required by the simulation based on the different parameters choices and hardware architectures. 

| Master script used  | computational time [min] | RAM usage [GB] |     CPU    | number CPU cores | population size | simulation length [months] |
| ------------------- | ------------------------ | -------------- | ---------- | ---------------- | --------------- | -------------------------- |
|         v3          |            215           |       6.6      |   Core i7  |        8         |       10^7      |             6              |       


 
