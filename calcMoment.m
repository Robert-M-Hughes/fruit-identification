function [m00temp, m01temp, m10temp, m20temp, m02temp, m11temp] = calcMoment(input_image,label)
   

   [height, width]=size(input_image);

    m00temp = 0;
    m10temp = 0;
    m01temp = 0;
    m20temp = 0;
    m02temp = 0;
    m11temp = 0;
    for i=1:height
        for j = 1:width
        if(input_image(i,j)== label)
           m00temp = m00temp + 1; 
           m10temp = m10temp + i;
           m01temp = m01temp + j;
           m20temp = m20temp + i^2;
           m02temp = m02temp + j^2;
           m11temp = m11temp +  i * j;
           
        end

        end
        
        
    end

