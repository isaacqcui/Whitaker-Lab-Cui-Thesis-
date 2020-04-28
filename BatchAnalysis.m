function BatchAnalysis(Tracks,SeedNumbersAndCutoffs,metersPerPx, framesPerSecond, ySize, numSmooth, mass, area)



for seed = 1:size(SeedNumbersAndCutoffs,1)
    
    %make useful names
    SeedNum = int2str(SeedNumbersAndCutoffs(seed,1));
    CutoffStart = 1+SeedNumbersAndCutoffs(seed,2);
    CutoffEnd = 1+SeedNumbersAndCutoffs(seed,3);
    SeedName =['Seed_',SeedNum];
    SeedNameMetric = [SeedName, 'm'];
    %make em global
    eval(['global ', SeedName]);
    eval(['global ', SeedNameMetric]);
    
    %extract a single track
    %[x,y,time(frames), size]]
    singleTrack = [SeedName, '= Tracks(Tracks(:,7)==', SeedNum, ',[1,2,6,3]);'];
    eval(singleTrack);
 
    
    %make it metric
    metricize = [SeedNameMetric,' = ConvertToMetricZero(', SeedName,',', num2str(metersPerPx),',',num2str(framesPerSecond),',', num2str(ySize), ');'];
    eval(metricize)
    
    
    
    
    
    %run analysis!
    analyze = ['analysis = runAnalysis(', SeedNameMetric, '(',...
        num2str(CutoffStart),':end-',num2str(CutoffEnd),',:)',',','''', ...
        'Seed ', num2str(SeedNum),'''', ',', num2str(numSmooth), ',',... 
        num2str(mass),',', num2str(area),');'];
    
    disp(['DATA FOR SEED ', num2str(SeedNum)])
    
    eval(analyze)
    
    
    
end