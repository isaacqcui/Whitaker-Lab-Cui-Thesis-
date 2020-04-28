%To be used with writeVideo.m to make blurred videos averaged over 2n frames
n = 5;
len = size(y);
smoothedMat = zeros(len(1),len(2),len(3),len(4)-2*n);
smoothedMat=double(smoothedMat);
for i = 1:(len(4)-2*n)
    for j = i:i+2*n
        smoothedMat(:,:,:,i) = smoothedMat(:,:,:,i) + double(y(:,:,:,j)/(2*n+1)); 
    end
end