function [double_input_image] = ConnectedComponentsColor(input_image)

 numcolors = 3;
 [height, width]=size(input_image);
 %output_image = zeros(height, width, numcolors);

 %at this point I now have a 3-d Array that I can work with
 
 %what I want to do is loop through the new array and finad all the pixels
 %that are on and set them to a color variable
 
 
 double_input_image = zeros(height, width, numcolors);
 
 for i=1:numcolors
    double_input_image(:,:,i)=input_image;
 end
 
 
% figure, imshow(uint8(double_input_image));
% title('debugColor')
  
 
 for i =1:height
     for j=1:width
         if (double_input_image(i,j, 1) == 255 ||double_input_image(i,j, 2) == 255 ||double_input_image(i,j, 3) == 255)
             %if (output_image(i,j,1) == 0 || output_image(i,j,2) == 0 || output_image(i,j,3) ==0)
                 for k =1:numcolors
                    RGB(k) = randi(255);
                 end
                 double_input_image= floodfill_output(double_input_image, i, j, RGB);
            % end
         end
                         
     end
 end
 
%imshow(uint8(double_input_image));
 
  
end

