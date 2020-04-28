clear global Particlexyt
clear global Tracks
clear param

global Particlexyt
global Tracks

ySize = 1080;
xSize = 1920;

density = 10;
area = 100;

video = ReadFrames('A_3.mov', ySize, xSize);

Particlexyt = FindParticles(density,area,video);

param.good=5;
param.mem=2;
param.quiet=0;
param.dim=2;
maxDisp = 50;

Tracks = track(Particlexyt,maxDisp,param);



scatter3(Tracks(:,1), Tracks(:,2), Tracks(:, 7), Tracks(:,3), Tracks(:,6));
video_dim = size(video);
axis([0 video_dim(2) 0 video_dim(1)])
axis ij
c = colorbar('southoutside');
c.Label.String = 'Time (s)';

%To compare to a frame of the video, uncomment this code
% figure
% imshow(uint8(video(:,:,:,47)))