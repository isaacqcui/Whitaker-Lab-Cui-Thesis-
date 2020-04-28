%Make Matrix with Seed numbers and coordinates for labels called SeedNumbersAndCoordninates(easiest to just
%update the already existing matrix called SeedNumbersAndCutoffs)
%Each row of SeedNumbersAndCoordninates goes [SeedNumber, xVal, yVal]
%
%Also make sure to have all Tracks (non metric) saved as global variables
%
%



hold off
image(uint8(video(:,:,:,70)))
hold on

Seed_ = 'Seed ';
for i=1:size(SeedNumbersAndCoordinates,1)
    
    disp(i)
    
    SeedNum = int2str(SeedNumbersAndCoordinates(i,1));
    SeedName =['Seed_',SeedNum];
    
    
    
    plot = ['scatter(', SeedName, '(:,1),' , SeedName, '(:,2),' , '[],', SeedName, '(:,3) );'];
    eval(plot);
    
   
end  

for i=1:size(SeedNumbersAndCoordinates,1)
    SeedNum = int2str(SeedNumbersAndCoordinates(i,1));
    SeedName =['Seed_',SeedNum];
    label = [Seed_,SeedNum];
    track = matlab.lang.makeValidName(label);
    text(SeedNumbersAndCoordinates(i,2),SeedNumbersAndCoordinates(i,3),label,'BackgroundColor','y')
    
end
