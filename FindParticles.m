function Particlexyt = FindParticles(Density,Area, Video)
%Takes:
%Video, from the function ReadFrames.m
%Density, an integer representing how far the subtracted framed should be
%spaced, usually 10
%Area, The required area of a particle to be counted in the final result,
%usually 5

disp('Tracking Movement');


%Subtract frames for all pixels and all frames
%   Density is the offset between the matrices in terms of frame number
%   Video is 4-d: 1st two dimensions are pixel (x,y), 3rd is RGB (color), 
%       4th is frame number. Squeeze means greenDifs is 3-d matrix where
%       color is removed as an extra dimension.
global greenDifs
greenDifs = squeeze(double(Video(:,:,2,1:(end-Density))) - double(Video(:,:,2,(1+Density):end)));

disp('Highlighting Particles');

%Only keep the ones with significant changes
%thresholded is 3-dimensional: (x component, y component, frame)
thresholded = greenDifs(:,:,:) > 8;
% sum(sum(thresholded))
% imtool(thresholded);

disp('Finding Particle Locations');

numberOfFrames = size(thresholded,3);

Particlexyt = [0, 0, 0, 0, 0,0];


for frame = 1:numberOfFrames

    %Number each cluster in the frame
     Labeled = bwlabeln(thresholded(:,:,frame));
%      if (frame == 1)
%          imtool(Labeled)
%      end
    %extract data for each cluster
    ParticleProperties = regionprops(Labeled,'Orientation', 'PixelIdxList', 'PixelList','Centroid','Area');

    %Instantiate variables
    %   Note that ParticleProperties returns a nx1 struct array, with five
    %   elements inside (i.e., five fields per an entry of
    %   ParticleProperties). numel(ParticleProperties) returns n, so the
    %   TempParticlexyt provides space for mapping the five fields into a
    %   row of an array.
    TempParticlexyt = zeros(numel(ParticleProperties),5);
    GoodList = zeros(numel(ParticleProperties),1);

    % store the frame number in the sixth column
    TempParticlexyt(:,6) = frame;

    % size(greenDifs,1) and size(greenDifs,2) return the pixel count in
    % each dimension, so greenSize is the resolution of the video.
    greenSize = size(greenDifs, 1)*size(greenDifs,2);
    %disp(numel(ParticleProperties))

    for i = 1:numel(ParticleProperties) 
        if (i < 10) && (frame < 5)
            ParticleProperties(i);
        end
        % Centroid returns (x,y) coordinate of the center of the region
        % (i.e., the center of mass of the seed)

        TempParticlexyt(i,1:2) = ParticleProperties(i).Centroid;
        % Area returns the number of pixels in the region
        TempParticlexyt(i, 3) = ParticleProperties(i).Area;
        % Orientation returns angle between the x-axis and the major axis
        % of the ellipse (returns in degrees between -90 and 90)
        TempParticlexyt(i,4) = ParticleProperties(i).Orientation;


        %Sum of the pixel values
        % PixelIdxList is the linear index of the pixels (i.e., it's a
        % scalar that reflects the location of each of the pixels) in a
        % group. Adding the factor of (frame-1)*greenSize assures
        % uniqueness in the GreenPixels value because PixelIdxList <
        % greenSize.
        GreenPixels = (ParticleProperties(i).PixelIdxList + (frame-1)*greenSize);
       
        % GreenSum is the sum of how many differences there are at the
        % relevant locations (i.e., locations where there are seeds), which is info 
        % stored by GreenPixels)
        GreenSum = sum(greenDifs(GreenPixels));


        TempParticlexyt(i,5) = GreenSum;

        %AREA usually 5
        GoodList(i) = ParticleProperties(i).Area > Area;



    end

    GoodList = GoodList > 0;
    %whos GoodList
    Particlexyt = [Particlexyt; TempParticlexyt(GoodList,:)];
end
    Particlexyt = Particlexyt(2:end,:);
%     figure;
%     scatter(Particlexyt(:,1),512-Particlexyt(:,2),10,Particlexyt(:,3));
    