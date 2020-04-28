%inputs are the output of ReadFrames, Track, and the z value specifying 
%the track t omake a video
function trackedVideo(video4D,tracks, trackNum)
    x = tracks(:,7)==trackNum;
    positionsxytc = tracks(x,:);
    TrackedV = VideoWriter('trackedVideotest','MPEG-4');
    open(TrackedV);
    NoFrames = size(video4D,4);
    video4D = uint8(video4D);
    for i = 1:NoFrames
        cla
        imshow(video4D(:,:,:,i))
        hold on
        for j = 1:size(positionsxytc,1)
            if i == positionsxytc(j,6)
                scatter(positionsxytc(1:j,1),positionsxytc(1:j,2), ...
                positionsxytc(1:j,3),positionsxytc(1:j,6));
            end
            
            if i >= positionsxytc(size(positionsxytc,1),6)
                scatter(positionsxytc(:,1),positionsxytc(:,2), ...
                positionsxytc(:,3),positionsxytc(:,6));
            end
        end
        frameImage = getframe(gcf);
        writeVideo(TrackedV,frameImage);
    end
    close(TrackedV);
end