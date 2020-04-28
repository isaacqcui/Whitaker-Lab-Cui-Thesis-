function video = ReadFrames(fileName, ySize, xSize, numFrames)
%numFrames is optional and should be used if you know that you
%only want a subset of the video

disp(['Making Video Reader for ', fileName])
v = VideoReader(fileName);
disp('Reading in frames:')

if nargin < 4
    numFrames = round(v.FrameRate*v.Duration);
end

video = zeros(ySize, xSize, 3, numFrames);
for i=1:numFrames
    video(:,:,:,i) = double(readFrame(v));
    if mod(i,10) == 0
        disp(i)
    end
end
% whos video
%n = 1;
%video = zeros(ySize,xSize,3,n);
%while hasFrame(v)
%     video(:,:,:,n) = readFrame(v);
%     n = n + 1;
%     if mod(n,10) == 0
%         disp(n);
%     end
     
% end

end