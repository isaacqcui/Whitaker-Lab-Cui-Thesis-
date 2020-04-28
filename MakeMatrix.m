%Make Matrix
figure
scatter3(Tracks(:,1), Tracks(:,2), Tracks(:, 7), Tracks(:,3), Tracks(:,6));

SeedNumbersAndCoordinates = [];


while 1
    disp('Adjust figure as necessary.')
    
    isDone = input('Enter 1 when ready to move on ');
    if isDone == 1
        break   
    end

end

row = 1;
runnning = 1;

Done = 0;

while ~Done 
  
  disp('Choose your track by double clicking.')
  disp('Be careful because your (double) clicks are being recorded...')
  
  [x,y] = getpts;
  
  trackNum = input('Track Number? (enter 0 to disregard click, -1 to disregard and quit) ');
  if trackNum == 0
      continue    
  end
  
  if trackNum == -1
      break    
  end
  
  SeedNumbersAndCoordinates(row,1) = trackNum;
  SeedNumbersAndCoordinates(row,2) = x;
  SeedNumbersAndCoordinates(row,3) = y;
  
  
  
  row = row + 1;
  
end

clear GoOn
clear Done
clear row
clear running