
clc 
clear all
close all
%open up the pathway to file and set as the input
[FileName, FilePath] = uigetfile('*');
input_image = imread(strcat(FilePath,FileName));
numcolors = 3;
[height, width]=size(input_image);
output_color = zeros(height, width, numcolors);
out_connect = zeros(height, width);
%clean the image up
out = double_threshold(input_image);
out = ErosionDilationFunc(out);
imshow(uint8(out));
title('Cleaned Thresholded Image')
hold on
%conneced components in black and which which is the one we will use for
%all of the other algoithms

[out_connect, labels] = ConnectedComponentsFloodfill(out);
figure, imshow(uint8(out_connect));
title('Connected Components')





%connected components to display the image with color
output_color = ConnectedComponentsColor(out);
figure, imshow(uint8(output_color));
title('Connected Components with Color')


%Now  to find the center of the fruit and its axis
% Area_of_Region(labels);
area = Area_of_Region(out_connect, labels);


axis= drawAxis(out_connect, labels);
title('Central Axis')


out_wall = out_connect;
wall_labels = [];
for k=1:5
[out_wall, templabel] = wallFollowing(out_wall, labels(k), k, area(k));
wall_labels = [wall_labels templabel];
end
figure, imshow(uint8(out_wall));
title('Wall Follow')

[fruit_out] = FruitIdentify(out_wall, labels, wall_labels);
%figure, imshow(uint8(fruit_out));
%axis = drawAxis(fruit_out, labels);
%figure, imshow(uint8(axis));



