%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A Two-Lane Cellular Automaton Traffic Flow Model with the Keep-Right Rule
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
close all;

B=3;              % The number of the lanes
plazalength=100;  % The length of the simulation highways
h=NaN;            % The handle of the image


[plaza,v]=create_plaza(B,plazalength);
h=show_plaza(plaza,h,0.1);

iterations=1000;    % Number of iterations
probc=0.2;          % Density of the cars
probv=[0.5 1];      % Density of two kinds of cars
probslow=0.4;       % The probability of random slow
%Dsafe=[1,2];        % The safe gap distance for the car to change the lane
VTypes=[7,7];       % Maximum speed of two different cars 
Gsafe=[1,3];        % The safe gap distance for cars' travel
K=ceil(probc*plazalength*B)/(plazalength*4)
[cartype,plaza,v,vmax]=new_cars(plaza,v,probc,probv,VTypes);% Generate cars on the lane cartype=1 self-driving cartype=2 no-self

size(find(plaza==1))
PLAZA=rot90(plaza,2);
CARTYPE=rot90(cartype,2);
h=show_plaza1(CARTYPE,h,0.1);
for t=1:iterations;
    size(find(plaza==1))
    cplaze=cartype;
    PLAZA=rot90(plaza,2);
    CARTYPE=rot90(cartype,2);
    h=show_plaza1(CARTYPE,h,0.1);
    [v,gap]=para_count(plaza,v,vmax);
   [cartype,plaza,v,vmax]=switch_lane(cartype,plaza,v,vmax,gap);
    [plaza,v,vmax]=random_slow(cartype,plaza,v,vmax,probslow);
    [cartype,plaza,v,vmax,vave]=move_forward(cartype,plaza,v,vmax,Gsafe);
    vave=vave*4
    Q=K*vave/B
end




