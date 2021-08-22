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
%        knnsearch. The image generated is named as 
%        'SLAM_Gen_Map.png'
%----------------------------------------------%

%% Remove old analysis files

if exist('SLAM_Gen_Map.png', 'file') == 2
    delete('SLAM_Gen_Map.png')
end

clear

rawImage = imread('Generated_SLAM_Map.pgm');

if exist('SLAM_Gen_Map.png', 'file') == 2
    delete('SLAM_Gen_Map.png')
end

binaryImage = rawImage(:,:,1) > 200;
imshow(binaryImage);

exportgraphics(gca,'SLAM_Gen_Map.png','Resolution', 2400)                  % Creates an image of the plot with a resolution of 2400 DPI
fprintf("Completed! \n")