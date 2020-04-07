%% ADITYA PATHAK (adityapathak1515@gmail.com)
% The following codes provides the use of conventional method in a
% Restaurant Tipping Problem
% There are many sections to go through and understand the process with
% steady progress in the coding
clc;
clear all;
close all;
%% The code section gives same value of tip (0.15) for all services rated from 0 to 10
service = 0:0.5:10; %the service provided in restaurant with 0(poor) and 10(excellent)
tip = 0.15*ones(size(service)); %the tip with respect to service provided with constant on 15%
plot(service, tip); %plot the figure
xlabel('Service')
ylabel('Tip')
title('Flat 15% Tip for all qualities of service')
ylim([0.05 0.25]) %limits the y axis from 0.05 to 0.25

%% The above code provides flat line of tips wrt to quality of service
% It shows poor performance of the tipping problem because it's constant to
% 0.15, so a new variable is introduced for tip with slope which gives tip
% based on range of quality of service
tip_new = (0.20/10)*service+0.05; %provides a slope starting from 0.05 and goes till 0.25
figure
plot(service, tip_new); %plot the figure
xlabel('Service')
ylabel('Tip')
title('New Tip calculation metric (Variable)')
ylim([0.05 0.25]) %limits the y axis from 0.05 to 0.25

%% However, the food also matters, tip can't be given based only on quality of service but also, on the quality of food
% a food variable is introduced with same range as service (0 to 10)
food = 0:0.5:10; %0 for bad quality of food and 10 for delicious food
[F,S]=meshgrid(food,service); %meshgrid is used bcoz 2-D variable is generated, and it creates a plane to see the overall service
tip_FS = (0.20/20).*(S+F)+0.05; %new variable to calculate tip based on food and service
figure
surf(S,F,tip_FS); %plot the 3-D plane of service, food and tip
xlabel('Service')
ylabel('Food')
zlabel('Tip')
title('3-D Tip calculation metric')

%% In this section of code, tip is calculated based on ratio or weightage of variables
servRatio = 0.8; %service is weighted 80% in tip calculation and food is 20% important
tip_servR = servRatio*(0.20/10*S+0.05) + (1-servRatio)*(0.20/10*F+0.05);
figure
surf(S,F,tip_servR); %plot the 3-D plane of service, food and tip
xlabel('Service')
ylabel('Food')
zlabel('Tip')
title('3-D Tip calculation metric on weightage')

%% The tip problem is not linear as shown in all the cases above, so this section deals wiht non-linear approach to calculate tip
tip_NL = zeros(size(service));
%piecewise formula is used to calculate tip based on service ranges
tip_NL(service<3) = (0.10/3)*service(service<3)+0.05; %lower tipping (10%) for lower quality of service
tip_NL(service>=3 & service<7) = 0.15; %flat 15% tip in this service interval
tip_NL(service>=7 & service<=10) = (0.10/3)*(service(service>=7 & service<=10)-7) +0.15;
figure
plot(service, tip_NL); %plot the figure
xlabel('Service')
ylabel('Tip')
title('Non linear 2-D tip calculation metric')
% the tip is calculated based only on one variable i.e service, however
% even quality of food is responsible for tip calculation

%% Piecewise formula is used on service as well as food in this section to create a meshgrid of tip calculation
% the servRatio, F and S are taken into account from above sections
tip_nonL_FS= zeros(size(S));
tip_nonL_FS(S<3) = servRatio*((0.10/3)*S(S<3)+0.05) + (1-servRatio)*(0.20/10*F(S<3)+0.05);
tip_nonL_FS(S>=3 & S<7) = (0.15)*servRatio + (1-servRatio)*(0.20/10*F(S>=3 & S<7)+0.05);
tip_nonL_FS(S>=7 & S<=10) = ((0.10/3)*(S(S>=7 & S<=10)-7)+0.15)*servRatio + (1-servRatio)*(0.20/10*F(S>=7 & S<=10)+0.05);
figure
surf(S,F,tip_nonL_FS); %plot the 3-D plane of service, food and tip
xlabel('Service')
ylabel('Food')
zlabel('Tip')
title('Non-Linear 3-D Tip calculation metric with 80% of service')