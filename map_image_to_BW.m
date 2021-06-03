%----------------------------------------------%
% Universidad de Costa Rica
% Engineering Faculty
% Electrical Engineering School
% Graduation project: 
% SLAM Algorithms comparison 
% using ROS nodes
%
% Created by: Kevin Trejos Vargas
% email: kevin.trejosvargas@ucr.ac.cr
%
% Description: This script takes the .pgm image
%    generated from the SLAM algorithm containing
%    the map, and returns a suitable black and
%    white image to be used in knnsearch test.
%
% Instructions for use:
%     1. Take the .pgm file and put it in
%        the same directory where is located
%        this .m file.
%     2. Rename it as 'Generated_SLAM_Map.pgm'.
%     3. Run the script and wait for its
%        completion, it will generate a png image
%        equivalent to this pgm, but suitable for
%        knnsearch, it only takes the black dots
%        and removes the empty spaces from the map.
%        The image generated is named as 
%        'SLAM_Gen_Map.png'
%----------------------------------------------%
rawImage = imread('Generated_SLAM_Map.pgm');

if exist('SLAM_Gen_Map.png', 'file') == 2
    delete('SLAM_Gen_Map.png')
end


rawImageHeight = 421;                                                      % Raw image pixels height
rawImageWidth  = 421;                                                      % Raw image pixels width
lineThickness  = 3  ;                                                      % Experimentally 3 gives the best adjustment

blkPointsIntoImage = blkPoints(rawImage, rawImageHeight, rawImageWidth);   % Gets a matrix of :2 containing only the sectors where the color is black
blkPointsIntoImage = blkcrop(blkPointsIntoImage);                          % Removes the empty space at the left and below the plot

scatter(blkPointsIntoImage(:,1), blkPointsIntoImage(:,2), lineThickness,  '.', 'black')
set(gca,'XTick',[], 'YTick', [], 'Visible','off')
axis equal

exportgraphics(gca,'SLAM_Gen_Map.png','Resolution', 2400)                  % Creates an image of the plot with a resolution of 2400 DPI
fprintf("Completed! \n")


%% Function to get the sectors with black points
function blkMatrix = blkPoints(image, rowRes, colRes)
    
    [rowSize, colSize] = size(image);
    blkMatrix          = zeros(1,2);
    actualRow          = 1;
    actualCol          = 1;
    actualTrial        = 1;
    
    while actualRow <= rowSize
        while actualCol <= colSize
            isBlack = image(actualRow, actualCol);
            if isBlack == 0
                if actualTrial == 1
                    blkMatrix(1,1) = actualRow;
                    blkMatrix(1,2) = actualCol;
                else
                    blkMatrix = [blkMatrix; actualRow, actualCol];
                end
                actualTrial = actualTrial +1;
            end
            actualCol = actualCol + fix(colSize/colRes);
        end
        actualCol = 1;
        actualRow = actualRow + fix(rowSize/rowRes);
    end
end

%% Function to remove the empty space of the black points at the left side and below the important data
function blkmatrixCrop = blkcrop(blkmatrix)
    rowsAmount = size(blkmatrix,1);
    minX = min(blkmatrix(:,1));
    minY = min(blkmatrix(:,2));
    blkmatrixCrop = zeros(1,2);
    actualRow = 1;
    while actualRow <= rowsAmount
        if actualRow == 1
            blkmatrixCrop(1,1) = blkmatrix(actualRow,1)-minX;
            blkmatrixCrop(1,2) = blkmatrix(actualRow,2)-minY;
        else
            blkmatrixCrop = [blkmatrixCrop; blkmatrix(actualRow,1)-minX, blkmatrix(actualRow,2)-minY];
        end
        actualRow = actualRow + 1;
    end
end