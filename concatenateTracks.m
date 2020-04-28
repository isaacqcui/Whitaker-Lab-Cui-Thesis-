function tracks = concatenateTracks(tracks, dim1, dim2, dimReturn)
% Combines tracks that you think should be a single one but MATLAB doesn't
% recognize. Input three track numbers: the two track numbers you want to
% combine and a third number for what the final track number should be.

len = length(tracks(:,7));
for i = 1:len
    if((tracks(i,7) == dim1) || (tracks(i,7) == dim2))
        tracks(i,7) = dimReturn;
    end
end
sprintf("track #%s and #%s were concatenated into track #%s", num2str(dim1), num2str(dim2), num2str(dimReturn))
end

