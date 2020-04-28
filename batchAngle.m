for i = 1:length(SeedNumbersAndCutoffs(:,1))
    
    
    title = ['Seed ',num2str(SeedNumbersAndCutoffs(i, 1))];
    SeedName = ['Seed_',num2str(SeedNumbersAndCutoffs(i, 1)), 'm'];
    
    test = ['angleTest(' ,SeedName,',5,85,','''',title,'''',')']
    
    eval(test)
    
    
end