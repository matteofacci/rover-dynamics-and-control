% https://www.uahirise.org/ESP_068360_1985 (25 February 2021)

clc; clear all; close all; warning off; 
%bdclose('all');

addpath('mars surface','utilities');

choice = 0; % picture chosen or choice = 0 for a standard profile

if choice == 0
    load standardRoadProfile.mat;

else

    %% Set the parameters depending on the picture

    switch choice
        case 1
            I = imread('ESP_068360_1985.jpg'); % 29.5 cm/pixel (Perseverance)
            mpp = 0.295; % meters per pixel (ESP pics)
            % gaussian filter smoothing factor (sigma = 16 for maximum smoothing)
            sigma = 16; %(ESP pic)
            maxHeigth = 20; % (fake param)



        case 2
            I = imread('ESP_059329_2095_RGB.jpg'); % 29.5 cm/pixel
            mpp = 0.295; % meters per pixel (ESP pics)
            % gaussian filter smoothing factor (sigma = 16 for maximum smoothing)
            sigma = 16; %(ESP pic)
            maxHeigth = 20; % (fake param)


        case 3
            I = imread('mars_surface.jpg'); % 504.38 m/pixel
            mpp = 0.50438; % meters per pixel (mars surface pic, fake param)
            % gaussian filter smoothing factor (sigma = 16 for maximum smoothing)
            sigma = 16; %(ESP pic)
            maxHeigth = 50; % (fake param)

        case 4
            I = imread('volcans-mars-hirise.jpg'); % 5.196 m/pixel
            mpp = 5.196/5; % meters per pixel (volcans pic)
            % gaussian filter smoothing factor (sigma = 16 for maximum smoothing)
            sigma = 8; %(volcans pic)
            maxHeigth = 400/5; % (volcanos pic h_real = 400 m)
    end

    %% Terrain Profile

    terrainProfile = meshCreation(I,mpp,sigma,maxHeigth);

end

initParams4Simulink;
set_param('roverDynamics','StartTime','0','StopTime',stopTime);
sim('roverDynamics'); % running model from script
% Plots

taskDuration = seconds(totalTime);
taskDuration.Format = 'hh:mm:ss.SSS';
fprintf("Task duration (hh:mm:ss.SSS): %s\n",string(taskDuration));
fprintf("Distance traveled: %f [m]\n",distanceTraveled);


