function [m00temp, m01temp, m10temp, m20temp, m02temp, m11temp,area] = region_properties(out_connect, labels)

area = Area_of_Region(out_connect, labels);

numLabel =size(labels,2);

for k =1:numLabel
    [m00temp, m01temp, m10temp, m20temp, m02temp, m11temp] = calcMoment(input_image,labels(k));
    m00 = [m00 m00temp];
    m10 = [m10 m10temp];
    m01 = [m01 m01temp];
    m11 = [m11 m11temp];
    m20 = [m20 m20temp];
    m02 = [m02 m02temp];
end
    
end

