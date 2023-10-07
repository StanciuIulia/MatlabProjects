% RoughPedometer.m
%
% Rough step counting.   
%
% Tuned from: https://bit.ly/3lBx9TS
%
% 21.01.11 SB

clc;           % delete and close all
clear all;
close all; 

m = mobiledev; % The displayed output should show Connected

%% Raw data adquisition
m.AccelerationSensorEnabled = 1;% Enable the accelerometer on the device.
m.AngularVelocitySensorEnabled=1; % Enable gyroscope.

while (1)
    m.Logging = 1; % The device is now transmitting sensor data.
    disp('Walk Around')
    pause(10)
    
    m.Logging = 0; % The device stop sending sensor data to mobiledev.

    [a,t] = accellog(m); % Retrieve Logged Data
    discardlogs(m); % Last logged data is erased

    plot(t,a); % Plot Raw Sensor Data
    legend('X', 'Y', 'Z');
    xlabel('Relative time (s)');
    ylabel('Acceleration (m/s^2)');

    %% Acceleration magnitude computation
    % The magnitude is calculated to allow that
    % large changes in overall acceleration,
    % such as steps taken while walking,
    % to be detected regardless of device orientation.
    
    x = a(:,1);
    y = a(:,2);
    z = a(:,3);
    mag = sqrt(sum(x.^2 + y.^2 + z.^2, 2));
    
    % Plot magnitude
    subplot(3,1,1);
    stem(t,mag);
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    title('Raw Magnitude')

    % Remove effects of gravitity
    % The acceleration magnitude is not zero-mean.
    magNoG = mag - mean(mag);
    subplot(3,1,2);
    stem(t,magNoG);
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    title('No Gravity')

    % Find Peaks
    amag = abs(magNoG);
    subplot(3,1,3);
    stem(t, amag);
    title('Absolute Magnitude')
    xlabel('Time (s)');
    ylabel('Acceleration Magnitude, No Gravity (m/s^2)');
    
    %% Counting the Number of Steps Taken
    % Only peaks with a minimum height above one standard deviation are
    % treated as a step. This threshold should be tuned experimentally
    % to match a person's level of movement while walking, hardness of
    % floor surfaces, etc.
    %
    % Tip: try also another available MATLAB methods for peak detection
    %      like 'islocalmax'
    %
    minPeakHeight = std(magNoG);
    [pks,locs] = findpeaks(magNoG,'MINPEAKHEIGHT',minPeakHeight);

    % The number of steps taken is simply the number of peaks found.
    if isempty(peaks)
     disp('No Steps')
     return
    end

    numSteps = numel(pks);
    disp('Number of Steps:')
    disp(numSteps)

    % The peak locations can be visualized w/ the acceleration magnitude data.
    hold on;
    plot(t(locs), pks, 'r', 'Marker', 'v', 'LineStyle', 'none');
    title('Counting Steps');
    xlabel('Time (s)');
    ylabel('Acceleration Magnitude, No Gravity (m/s^2)');
    hold off;

    %% Cleaning Up
    %Turn off the acceleration sensor and clear mobiledev.
    m.AccelerationSensorEnabled = 0;
    clear m;
    connector off;
end



