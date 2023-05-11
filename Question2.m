% Code for Question 2 
% March 1, 2022
% Group 24
%   k20044349 Antonia Massmann
%   k20046622 Natyada Julintron
%   k20074264 Shivani Kakkad
%   k20038514 Stella Hadfield Elliot 
%------------------------------------------------

% Clear the workspace
close all
clear all
clc

% Part 1: The signal in region A starts at value 1 at time 1 and increases
%        by 1 until time 10, remains at 10 for time 11 and returns in steps
%        of -1 to 1 at 20, then pattern repeats 3 times. 
 
    % step 1a: set the parameters
    t =[1:1:60];          
    n = 1:1:10;           % the first value of a vector will be added by 1
    nn = 10: -1:1;        % the second value will follow the first and will decrease by 1 

    % step 1b: ensure the initial steps work
     Signal_A = [n,nn]; 
     plot(Signal_A); 

    % step 1c:  repeat the initial pattern three times
     Signal_A1 = repmat(Signal_A,1,3);

    % step 1d: plot an appropriate graph to demonstrate the above 
     figure                                         % opens up a figure window
     plot(Signal_A1, 'm', 'linewidth', 3)           % plots the different variables (x,y), color(r/g/b), thickness of line
     xlabel ("Time")                                % labels the x axis
     ylabel ("Value of Signal A")                   % labels the y axis
     title ("Signal A")                             % labels the graph by inserting a title


%  ----------------------- Signal B -------------------------  %

% Part 2: The signal in Region B starts at value 2 at time 1 and remains at
%        2 until time 10, then jumps to a value of 0 from time 11 to 20,
%        this pattern repeats 3 times. 

    % step 2a: ensure the initial steps work
    Signal_B (1:10)= 2; 
    Signal_B (11:20)= 0; 
    plot (Signal_B); 

    % step 2b: run the same commands as previous, but repeated three times
    Signal_B1 = repmat(Signal_B,1,3);

    % step 2c: plot an appropriate graph to demonstrate the above 
    figure                                         % opens up a figure window
    plot(Signal_B1, 'm', 'linewidth', 3)           % plots the different variables (x,y), color(r/g/b), thickness of line
    xlabel ("Time")                                % labels the x axis
    ylabel ("Value of Signal B")                   % labels the y axis
    title ("Signal B")                             % labels the graph by inserting a title


%  ----------------------- Signal C --------------------------- %

%Part 3: Region C performs a sin operation on the sum of these inputs. 


   %step 3a: define signal_c as the sin operations of the sum of inputs from Region A and B. 
   Signal_C = sin(Signal_A1 + Signal_B1);

   %step 3b: plot an appropriate graph to demonstrate the above 
   figure                                         %opens up a figure window
   plot(Signal_C, 'g', 'linewidth', 3)            %plots the different variables (x,y), color(r/g/b), thickness of line
   xlabel ("Time")                                %labels the x axis
   ylabel ("Value of Signal C")                   %labels the y axis
   title ("Signal C")                             %labels the graph by inserting a title

   
  
%  ------------------------ Signal D --------------------------- %

%Part 4: If Region C then sends its signal to Region D, with multiplicative weight of 0.5, plot the response in region D.

    %step 4a: define signal_D by multiplying 0.5 to Signal_C 
    Signal_D = Signal_C * 0.5;

    %step 4b: plot an appropriate graph to demonstrate the above 
    figure                                         %opens up a figure window
    plot(Signal_D, 'r', 'linewidth', 3)            %plots the different variables (x,y), color(r/g/b), thickness of line
    xlabel ("Time")                                %labels the x axis
    ylabel ("Value of Signal D")                   %labels the y axis
    title ("Signal D")                             %labels the graph by inserting a title



% --------------------- End of Question 2 ------------------------ %


