%To be used with smoothMatrix.m to make blurred videos

v = VideoWriter("2-18_s8_2_smoothed","MPEG-4");
open(v)
writeVideo(v,uint8(smoothedMat(:,:,:,:)));
close(v)