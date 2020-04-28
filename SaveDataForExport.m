
%Saves all the relevant data in a Matlab matrix called DataForExport, from
%which you can copy/past into Excel etc.

%MAKE SURE SeedNumbersAndCutoffs and each metricized seed track are global
%variables!!!


DataForExport = cell(1,5);
DataForExport{1,1} = ' ';
DataForExport{1,2} = 'launchAngle';
DataForExport{1,3} = 'averageSpeed';
DataForExport{1,4} = 'averageDragCoefficient';
DataForExport{1,5} = 'averageLiftCoefficient';

for seed = 1:size(SeedNumbersAndCutoffs,1)
    
    SeedNum = int2str(SeedNumbersAndCutoffs(seed,1));
    
    SeedName =['Seed_',SeedNum];
    SeedNameMetric = [SeedName, 'm'];
    cutoff = int2str(SeedNumbersAndCutoffs(seed,2));
    
    analyze = ['[launchAngle, averageSpeed, averageDragCoefficient, averageLiftCoefficient] = runAnalysis(' ,SeedNameMetric,',','''', SeedName,'''', ', 0,0);'];
    eval(analyze)
    
    DataForExport{seed+1,1} = SeedName;
    DataForExport{seed+1,2} = launchAngle;
    DataForExport{seed+1,3} = averageSpeed;
    DataForExport{seed+1,4} = averageDragCoefficient;
    DataForExport{seed+1,5} = averageLiftCoefficient;



end