# Map-to-BW-Converter
The algorithm needs to be feed with the map generated by SLAM, it has to be renamed as 'Generated_SLAM_Map.pgm' and shall be placed into the same directory. It will generate a png file named 'SLAM_Gen_Map.png', which is a suitable, black and white image to be used into knnsearch algorithm.

There are three variables that can affect widely the results:
1. rawImageHeight: Integer value that is equivalent to the height pixels of 'Generated_SLAM_Map.pgm', defaulted to 421.
2. rawImageWidth: Integer value that is equivalent to the width pixels of 'Generated_SLAM_Map.pgm', defaulted to 421.
3. lineThickness: The higher it is, the thicker the lines become in 'SLAM_Gen_Map.png'. It was defaulted to 3, since 3 experimentally gives the best adjustment.
