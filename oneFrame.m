tic;
global myFrame
fileName = '6-19_CalibrationA_RAW.mov';
disp(['Extracting frame for ', fileName])
v = VideoReader(fileName);
n = 1;
myFrame = readFrame(v);

figure;
image(myFrame)

toc;