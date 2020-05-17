# Model_disease_spreading-
## 1) BASIC RATIONALE
MATLAB model simulating the spreading of a disease in a population. 
The model implements a population in which each individual is resembled by a state machine, transitioning in between health stati based on the different stages of the infection. 
The model and its assumptions are currently tailored on the data available at March 2020. 
### Current model assumptions
a) The people who get the virus and heal become immune and cannot get the virus a second time.

### Prerequisites
Having MATLAB (no specific distribution required) installed on the machine.

## 2) HEALTH-STATUS STATE MACHINE DESCRIPTION
a) Each person of the simulated population has an associated health status. 
b) The people are all initialized as healthy aside from a person who is initialized as infective.  
c) Each infected person starts being infective from the day following his infection and keeps being infective until the first sympthoms show up. This time varies from person to person and it is drawn in a Gaussian distribution of mean value = 7 days and 3sigma = 7 days. Following, the health status transitions into sick in isolation.  
d) Once sick, each patient's disease course might follow different paths, i.e. standard healing, reqiring hospitalization or perishing.  
e) Each survived person is then considered immune from further infections. 

The visual description of the state machine is reported hereby:
![picture](https://github.com/dave-ai/Model_disease_spreading-/blob/master/images/state_machine_person.JPG)

## 3) HOW TO USE ME
Before launching a simulation, open the loadParam.m script and set up the parameters characterising the requested population.  
Additionally the parameters related to the post processing are included.  
Once that has been set up, run the master_script_vX.m script.

## 4) RESULTS
Meaningful results are reported in the **res** folder. 
Convention: save your result in a subfolder named: sim_#pupulation_#months_#init_infected_#init_in_hospitals_#init_immune.
e.g. if you simulate a scenario with 500000 people, for 6 months, with 10 initial infections, 3 people in hospital and 0 immune, save the result in:
res/sim_500000_6_10_3_0


## 5) PERFORMANCES
Being the code computationally expensive to be run for consistent populations (e.g. > 10^6 people), this section has the purpose to provide an approximate computational time required by the simulation based on the different parameters choices and hardware architectures. 

| Master script used  | computational time [min] | RAM usage [GB] |     CPU    |     OS     | number CPU cores | population size | simulation length [months] | 
| ------------------- | ------------------------ | -------------- | ---------- | ---------- | ---------------- | --------------- | -------------------------- |
|         v3          |            215           |       6.6      |   Core i7  |   Windows  |        8         |       10^6      |             6              |       
| ------------------- | ------------------------ | -------------- | ---------- | ---------- | ---------------- | --------------- | -------------------------- |
|         v3          |            29            |       4        |   Core i7  |   Windows  |        8         |     550000      |             6              |       
| ------------------- | ------------------------ | -------------- | ---------- | ---------- | ---------------- | --------------- | -------------------------- |
|         v3          |            <1            |       4        |   Core i7  |   Linux    |        8         |     10000       |             6              | 
| ------------------- | ------------------------ | -------------- | ---------- | ---------- | ---------------- | --------------- | -------------------------- |


## 6) CONTRIBUTORS
The list of contributor is contained in [NOTICE](https://github.com/dave-ai/Model_disease_spreading-/NOTICE.md) file. 


## 7) LICENSE

Model_disease_spreading- is open-sourced under the GNU General Public License v3.0 license. See the [LICENSE](https://github.com/dave-ai/Model_disease_spreading-/LICENSE.md) file for details.




 
