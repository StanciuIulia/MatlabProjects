% RoughPedometer .m
% Step counting system and distance walked estimator  
%

clc;           % delete and close all
clear all;
close all; 

%mobiledevlist;
m = mobiledev; % The displayed output should show Connected

%% Raw data adquisition
m.AccelerationSensorEnabled = 1;    % Enable the accelerometer on the device.
m.AngularVelocitySensorEnabled=1;   % Enable gyroscope on the device.
% m.MagneticFieldSensorEnabled=1;     % Enable magnetic field sensor on the device.

% might not be used for this programme
m.OrientationSensorEnabled=1;       % Enable orientation sensor on the device.
m.PositionSensorEnabled=1;          % Enable position sensor on the device.  
                                    % The position sensor uses GPS, Wi-Fi and celilar data. 

while (1)
    m.Logging = 1;      % The device is now transmitting sensor data.
    disp(m)             % Display the mobile object proprieties.
    disp('Walk Around') % Display message for the walking action.
    for i = 1:5
        pause(2)
    end
    m.Logging = 0;      % The device stop sending sensor data to mobiledev.

    %% Retrieve Logged Data
    
    % Retrieve Logged Data from the Accelerometer.
    [acceleration, t1] = accellog(m); 
    
    figure
    % Plot Raw Sensor Data from the Accelerometer.
    subplot(4,1,1);
    plot(t1, acceleration); 
    title('Raw Acceleration Data')
    legend('X', 'Y', 'Z');
    xlabel('Relative time (s)');
    ylabel('Acceleration (m/s^2)');
    
    % Retrieve Logged Data from the Magnetic Field Sensor.
    [magneticField, t2] = magfieldlog(m); 
    
    % Plot Raw Sensor Data from the Magnetic Field Sensor.
    subplot(4,1,2);
    plot(t2, magneticField);
    title('Raw Magnetic Field Data')
    legend('X', 'Y', 'Z');
    xlabel('Relative time (s)');
    ylabel('Magnetic Field (uT)');

    
    % Retrieve Logged Data from the Gyroscope.
    [angularVelocity, t3] =  angvellog(m); 
     
    % Plot Raw Sensor Data from the Gyroscope.
    subplot(4,1,3);
    plot(t3, angularVelocity);
    title('Raw Gyroscope Data')
    legend('X', 'Y', 'Z');
    xlabel('Relative time (s)');
    ylabel('Angular Velocity (rad/s)');
    
    % Retrive Orientation Logged Data.
    [orientation, t4] = orientlog(m);            
  
    % Plot Raw Sensor Data from the Orientation Sensor.
    subplot(4,1,4);
    plot(t4, orientation);
    title('Raw Orientation Sensor Data')
    legend('X', 'Y', 'Z');
    xlabel('Relative time (s)');
    ylabel('Orientation (degrees)');
    
    discardlogs(m);     % Last logged data is erased.
    

    %% Orientation computation 
    
    % Plot Raw Sensor Data from the Gyroscope.
    figure
    subplot(2,1,1);
    plot(t4, orientation);
    title('Raw Orientation Sensor Data')
    legend('X', 'Y', 'Z');
    xlabel('Relative time (s)');
    ylabel('Orientation (degrees)');
    
    x_or = orientation(:,1);
    y_or = orientation(:,2);
    z_or = orientation(:,3);
    % Determine the raw linear acceleration
    or = sqrt(sum(x_or.^2 + y_or.^2 + z_or.^2, 2)); 

    
    subplot(2,1,2);
    plot(t4, or);
    hold on
    title('Processed Orientation Data')
    xlabel('Time(s)');
    ylabel('Orientation');
    hold off
    
    minPeakHeight = std(or);
    [pks,locs] = findpeaks(or,'MINPEAKHEIGHT',minPeakHeight);

    % The number of steps taken is simply the number of peaks found.
    if isempty(peaks)
     disp('Orientation changes')
     return
    end
    
    numOrCh = numel(pks);
    disp('Number of orientation changes:')
    disp(numOrCh)
   
    %% Angular acceleration computation from angular velocity given by the gyeoscope
    
    % Plot Raw Sensor Data from the Gyroscope.
    figure
    subplot(3,1,1);
    plot(t3, angularVelocity); 
    title('Raw Gyroscope Data')
    legend('X', 'Y', 'Z');
    xlabel('Time (s)');
    ylabel('Angular Velocity (rad/s)');
    
    x_av = angularVelocity(:,1);
    y_av = angularVelocity(:,2);
    z_av = angularVelocity(:,3);
    % Determine the raw linear acceleration
    av = sqrt(sum(x_av.^2 + y_av.^2 + z_av.^2, 2)); 
    
    % Determine gyroscope maximum angular velocity.
    gyr_max = max(av);
    % Determine gyroscope minimum angular velocity.
    gyr_min = min(av);
    
    % Determine the threshold of the angular velocity.
    gyr_threshold = (gyr_max+gyr_min)/2;   
    
    % Determine the variance of the angular velocity.
    gyr_variance = var(av);
    
    subplot(3,1,2);
    plot(t3, av);
    hold on
    plot(t3, gyr_max,'g.--')         % Plot maximum 
    plot(t3, gyr_threshold,'y.--')    % Plot threshold 
    plot(t3, gyr_min,'r.--')         % Plot minimum 
    title('Processed Gyroscope data with threshold shown on graphic')
    xlabel('Time(s)');
    ylabel('Angular Velocity (rad/s)');
    hold off
    
    minPeakHeight = gyr_threshold - gyr_variance;
    [pks,locs] = findpeaks(av,'MINPEAKHEIGHT',minPeakHeight);

    % The number of steps taken is simply the number of peaks found.
    if isempty(peaks)
     disp('No Steps')
     return
    end
    
    gyr_numSteps = numel(pks);
    disp('Number of Steps given by gyroscope data:')
    disp(gyr_numSteps)

    % The peak locations can be visualized w/ the acceleration magnitude data.
    hold on;
    subplot(3,1,3);
    plot(t3(locs), pks, 'r', 'Marker', 'v', 'LineStyle', '-');
    title('Counting Steps using Gyroscope Data');
    xlabel('Time (s)');
    ylabel('Angular Velocity (rad/s)');
    hold off;
    
    
    %% Acceleration magnitude computation
    % The magnitude is calculated to allow that
    % large changes in overall acceleration,
    % such as steps taken while walking,
    % to be detected regardless of device orientation.
    
    x = acceleration(:,1);
    y = acceleration(:,2);
    z = acceleration(:,3);
    % Determine the raw linear acceleration
    mag = sqrt(sum(x.^2 + y.^2 + z.^2, 2)); 
    
    figure
    % Plot magnitude
    subplot(4,1,1);
    stem(t1,mag);
    title('Raw Magnitude')
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    

    % Remove effects of gravitity to get the linear acceleration
    % Linear Acceleration = Measured Acceleration - Gravity
    % The acceleration magnitude is not zero-mean.
    magNoG = mag - mean(mag);
    subplot(4,1,2);
    stem(t1,magNoG);
    title('No Gravity')
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    
    
    % Find Peaks
    amag = abs(magNoG);   
    [maxAcc, idmax] = max(amag);     % Determine maximum acceleration.
    [minAcc, idmin] = min(amag);     % Determine minimum acceleration.
    
    % Determine the threshold of the acceleration.
    ac_threshold = (maxAcc+minAcc)/2;  

    % Determine the variance of the acceleration.
    ac_variance = var(amag);
    
    subplot(4,1,3);
    plot(t1, amag);
    hold on
    plot(t1, maxAcc,'g.--')        % Plot maximum acceleration 
    plot(t1, ac_threshold,'y.--')     % Plot threshold 
    plot(t1, minAcc,'r.--')        % Plot minimum acceleration 
    title('Absolute Magnitude')
    xlabel('Time (s)');
    ylabel('Acceleration Magnitude, No Gravity (m/s^2)');
    hold off

    %% Counting the Number of Steps Taken with the Accelerator Data
    % Only peaks with a minimum height above one standard deviation are
    % treated as a step. This threshold should be tuned experimentally
    % to match a person's level of movement while walking, hardness of
    % floor surfaces, etc.
    %
    % Tip: try also another available MATLAB methods for peak detection
    %      like 'islocalmax'
    %
    %minPeakHeight = std(magNoG);
    minPeakHeight = ac_threshold - ac_variance;
    [pks,locs] = findpeaks(magNoG,'MINPEAKHEIGHT',minPeakHeight);

    % The number of steps taken is simply the number of peaks found.
    if isempty(peaks)
     disp('No Steps')
     return
    end
    
    ac_numSteps = numel(pks);
    disp('Number of Steps given by acceleration:')
    disp(ac_numSteps)

    % The peak locations can be visualized w/ the acceleration magnitude data.
    hold on;
    subplot(4,1,4);
    plot(t1(locs), pks, 'r', 'Marker', 'v', 'LineStyle', '-');
    title('Counting Steps using Accelerator data');
    xlabel('Time (s)');
    ylabel('Acceleration Magnitude, No Gravity (m/s^2)');
    hold off;
   
    %% Comlementary filter to get the orientation estimation
%     % The complementary filter is a frequency domain filter.
%     % this is similat to a low-pass filtert, but uses
%     % two different sets of sensor measurements to produce 
%     % a weighted estimation.
%     
%     Ts = mean(diff(t2)); % sampling interval
%     St = std(diff(t2));  % standard deviation 
%     Fs = 1/Ts;          %sampling frequency 
%     
%     [NumRowsAc NumColsAc]=size(acceleration);
%     disp(NumRowsAc);
%     [NumRowsAv NumColsAv]=size(angularVelocity);
%     disp(NumRowsAv);
%     [NumRowsMf NumColsMf]=size(magneticField);
%     disp(NumRowsMf);
%     
%     % Creating a complementary filter object with sample rate equal to the frequency of the data
%     % fuse = complementaryFilter('SampleRate', Fs); 
%     fuse = complementaryFilter; 
%     % Fuse accelerometer, gyroscope, and magnetometer data using the filter.
%     q = fuse(acceleration, angularVelocity, magneticField);
%     
%     % Visuazization of the filter
%     figure
%     plot(eulerd( q, 'ZYX', 'frame'));
%     title('Orientation Estimate');
%     legend('Z-rotation', 'Y-rotation', 'X-rotation');
%     ylabel('Degrees');
%  
   
    %% Distance walked computation
    prompt = "What is your average step length in centimeters?";
    Average_step = input(prompt);       %average step distance in centimeters
    Average_step = Average_step/100;    %average step distance in meters
    
    prompt = "Add weights given by the early use of algorityhm.";
    disp('For first use: 0.5, 0.5, -0.2')
    k1 = input(prompt);
    k2 = input(prompt);
    k3 = input(prompt);
    
    % Defining initial weights
    %k1 = 0.5;
    %k2 = 0.5;
    %k3 = -0.2;
    
    % Calculating the number of steps
    numSteps = k1*gyr_numSteps + k2*ac_numSteps + k3*numOrCh;
    disp('Number of steps:')
    disp(round(numSteps))

    % Calculating the walked distance
    Distance_walked = numSteps*Average_step;
    disp('Distance walked:')
    disp(Distance_walked) 
    disp('meters.')

    prompt = "What is the actual step count? ";
    Actual_step_count = input(prompt);
    
    % Recalculate weights
    weight_difference = Actual_step_count/(gyr_numSteps+ac_numSteps+numOrCh);
    disp('New weights are:')
    disp(k1+weight_difference)
    disp(k2+weight_difference)
    disp(k3+weight_difference)
 
    %% Cleaning Up
    %Turn off sensors.
    m.AccelerationSensorEnabled = 0;    % Disable the accelerometer on the device.
    m.AngularVelocitySensorEnabled=0;   % Disable gyroscope on the device.
    % m.MagneticFieldSensorEnabled=0;     % Disable magnetic field sensor on the device.
    
    m.OrientationSensorEnabled=0;       % Disable orientation sensor on the device.
    m.PositionSensorEnabled=0;          % Disable position sensor on the device.

    % Clear mobiledev.
    clear m;
    connector off;
end