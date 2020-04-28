global Tracks
%Remember to change your values
ySize = 720;
metersPerPx = .00113;
framesPerSecond = 60;
framesSmooth = 3;
mass = .000227; %kg
diameter = .06; %meters
area = 3.14*(diameter/2)^2;


% Run a concatenate if necessary
%Tracks = concatenateTracks(Tracks,4,2,2)

% Remember to change the SeedNumbersAndCutoffs
SeedNumbersAndCutoffs = [1,0,0];

disp("Data about the video:")
framesPerSecond
framesSmooth


%Make sure to update the following global variables: Tracks and SeedNumbersandCutoffs
BatchAnalysis(Tracks, SeedNumbersAndCutoffs, metersPerPx, framesPerSecond, ySize, framesSmooth, mass, area)

for seed = 1:size(SeedNumbersAndCutoffs,1)
    
    %make individual tracks (both metricized version and not) global
    %variables
    disp(sprintf("%s frames were cut off from the beginning and %s from the end", num2str(SeedNumbersAndCutoffs(seed,2)), num2str(SeedNumbersAndCutoffs(seed,3))))
    SeedNum = int2str(SeedNumbersAndCutoffs(seed,1));
    
    SeedName =['Seed_',SeedNum];
    eval(['global ', SeedName]);
    
    SeedNameMetric = [SeedName, 'm'];
    eval(['global ', SeedNameMetric]);
    
  
end