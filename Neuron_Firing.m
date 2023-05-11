% Summative 2 code
% Due 25/03/2022
% ---------------------------------
% Group 24
% ---------------------------------

% QUESTION 1 ----------------------

% Clear the workspace
  close all
  clear all
  clc

% Part A: Create a Matrix of size 8 x 8. Fill each matrix entry with the product of the row and column index. 
% ------- For example, in row 2, column 4, the matrix entry should equal 8.

  % Step 1a: create the matrix
    matrix = zeros (8,8);         % Size of matrix is 8 x 8  
           
           
  % Step 1b: create a forloop to fill each matrix entry with the product of the row and column index
    for i = 1:height(matrix)
        for j = 1:width(matrix)
            matrix(i,j) = i * j;   % Product of row x column index
        end 
    end
             
   % Step 1c: display the matrix to ensure the code works
     disp (matrix)                 % Displays the final matrix 
   
   % Yes, the matrix fulfils the requirements of question
                                        


% --------------------------------------------- End of Part A ----------------------------------------------- %


% Part B: You are designing an experiment with 100 trials. Each trial shows a random number between 1 and 5. 
% ------- Create a vector that contains these 100 stimuli, where each element of the vector is of value 
% ------- '1', '2', '3', '4' or '5' in a random order. 
 

  % Step 2a: direct input using randi function
    RandomVector = randi (5,1,100); % Generates the vector with numbers generated at random btwn 1-5 for 100 trials  
           
           
  % Step 2b: display the vector generated in previous step 
          disp (RandomVector)        % Displays the vector 'RandomVector'

  % step 2c: run the code multiple times to ensure it works 
  % ----- Yes, the vector consists of numbers generated at random between 1 to 5
  % ----- displayed for all 100 trials at a column interval of 21 (column 1-21, 22-42, 
  % ----- 43-63, 64-84, 85-100)

% QUESTION 2 ----------------------

% Clear the workspace
  clc 
  clear all
  close all

% Part A: Stimulating time series for 1 second of beta oscillation (frequency 17
% ------- Hz, amplitude 10) and gamma oscillations occuring after DBS for 1 second
% ------- (frequency 32 Hz, amplitude 1)

    % Step 1a: Defining the the time vector 
      TMax = 1;       % Max of 1 sec - for each signal
      Ti = 0.01;      % Define time interval of 10 msec 
      t = 0:Ti:TMax;  % Vector of time axis
      Fs = 1/Ti;      % Sampling rate

    % Step 1b: Define frequency and amplitude of the wave
      BetaF = 17;     % Frequency of beta oscillation (before DBS)
      GammaF = 32;    % Frequency of gamma oscillation (after DBS)
      Amp_b = 10;     % Beta oscillation amplitude
      Amp_g = 1;      % Gamma oscillation amplitude

    % Step 1c: Hz to radians per sec:  w = 2*pi*f
      omega_b = 2*pi*BetaF;
      omega_g = 2*pi*GammaF;

    % Step 1d: Create the sine or cosine wave:  wave = A*sin(wt)
      signal_b = Amp_b*sin(omega_b*t);
      signal_g = Amp_g*sin(omega_g*t);

    % Step 1e: Combine the wave
    signal_g(:,1) = [];                    % Delete the first data point in gamma oscillation for equal vectors
    signal_combine = [signal_b signal_g];  % Create combined matrix

    t_all = 0:Ti:2;                        % New time interval for both signals for plotting 2 seconds

    % Step 1f: Plot the signals
    figure
    plot(t_all,signal_combine)
    xlabel('time (sec)')
    ylabel('Amplitude (mV)')
    ylim([-10 10])

% --------------------------------------------- End of Part A ----------------------------------------------- %

% ----- Fast Fourier transform of the time series and plotting on-sides magnitude
% ----- of the FFT

    % Step 2a: Fourier transform - use fft and fftshift
    ySignal = fft(signal_combine);          % FT in the positive and negative frequency space
    zSignal = fftshift(ySignal);            % Corrects the order of the fft 
    abs_signal = abs(zSignal);              % Use the absolute value 
      
    % Step 2b: Obtain frequency axis
    % f = (-ly/2 : ly/2 -1)/ly*Fs ; 
    ly = length(ySignal);                   % Length of FFT output
    f = (-ly/2 : ly/2 -1)/ly*Fs;

    % Step 2c: Plot Fourier Transform - positive frequencies
    % ---- Determine positive frequency points
    pos_start = ceil(length(f)/2);           % Ceil will change to the nearest whole number 
    pos_frequency = [pos_start:length(f)];   % Determine what indices to plot
    
    FFT_mag = abs_signal(pos_frequency);     % New vector of FFT values for positive frequencies only
    pos_x = f(pos_frequency);                % X-axis showing just positive frequencies
    
    % Step 2d: Plot one-sided FFT
    figure
    plot(pos_x ,FFT_mag) 
    xlabel('Frequency (Hz)')
    ylabel('Magnitude of Fourier Transform, Single Sided')
    title('Frequency Domain')

% QUESTION 3 ----------------------

% Spike Trains in LGN
% This code will recreate the firing of an LGN OFF-cell during an experiment 

% This experiment consists of 2 trials. 
% In the first trial the light is shone in the centre. 
% In the other trial the light is shone in the surround. 

% Measurements are taken for 1.5 secs.
% The light comes on at 450 msec and goes off at 900 msec.

% Trial 1: 
% The initial (pre-stimulus) background firing is 20%
% Light on : firing is 2%. 
% After the light is turned off the cell fires with 75% probability.

% Trial 2: 
% The initial (pre-stimulus) background firing is 20%
% Light on : firing probability is 80%.
% After the light is turned off the cell fires with 20% probability.

% Clear the workspace
  clc
  clear all
  close all

    % Step 1a: Defining Time properties
    
    MaxT      = 1.5;                        % Measurements are taken for 1.5 seconds
    Ti        = 0.01;                       % Time Interval - set to 10 milliseconds for each bin
    Light_on  = 0.45;                       % Time point when light comes on
    Light_off = 0.9;                        % Time point when light goes off
    All_bins  = 0:Ti:MaxT;                  % Time axis 
    
    % Step 1b: Creating a vector to hold the cell firing rate of all trials 
     
    cell_firing= zeros(2,length(All_bins));  % 0 is the default and 1 the fireing cell
     
     
    % Step 1c: Define the probability for each trial, where there are 6 trials and three sections
    
    trial_prob  = [20 2 75; ...
        20 80 20];                           % Pre light, light ON, and After light
                                             % This syntax builds a 2x3 matrix
    
    % Step 2a: Cycle through each trial
    
    for Trial = 1:2                          % For trials 1 and 2...
        for i = 1:length(All_bins)           % ...Loop over every time bin in the trial
    
    % Step 2b: Check if the light at this part of the trial is on or
    % ------ off
    % ------ As the cell fires differently depending on what part of the trial we
    % ------ are on
     
            if All_bins(i) < Light_on        % This is the time bins before the light comes on
    
                % Step 2c: Randomly select an integer between 1-100
                x = randi(100);               
                
                % Step 2d: Establish a rule for these trials
                if x <= trial_prob(Trial,1)   % First section of experiment        
                    firing_yes_no = 1;        % If randi returns 1, it can be assumed that the cell fires...
                else                            
                    firing_yes_no = 0;        % ...Otherwise set firing to zero
                end
    
            elseif (All_bins(i) > Light_on) && (All_bins(i) < Light_off)  % Time bins during light on
    
                y = randi(100);              % Randomly generate integer from 1-100
    
                if y <trial_prob(Trial,2)    % Second section of experiment
                    firing_yes_no = 1;       % If randi returns 1, can assume the cell fires 
                else                         
                    firing_yes_no = 0;       % ...Otherwise set the firing to zero
                end
    
            elseif All_bins(i) >  Light_off  % Time bins after the light has gone off
    
                z = randi(100);              % Randomly generate integer from 1-100
    
                if z < trial_prob(Trial,3)   % Third section of experiment 
                    firing_yes_no = 1;       % if my randi returns 1, can assume the cell fires 
                else                         
                    firing_yes_no = 0;       % ...Otherwise set the firing to zero
                end
    
            end
    
            cell_firing(Trial,i) = firing_yes_no; % Assigning the variable firing_yes_no to the vector containing the firing rates
    
        end
    end
    
    % Step 3: Plot the output (plots a matrix)
    
    figure
    imagesc(cell_firing)                   
    xlabel('Time in secs')                   
    ylabel('Trials')                       
    title('Firing Rates of LGN OFF Cell')  
    colormap('hot') % Changing the colour to specific colour scheme 
    
    
                                        
