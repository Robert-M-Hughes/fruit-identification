function area = Area_of_Region(input_image, labels)

[height, width]=size(input_image);
components = size(labels,2);

area = [];


for k=1:components
    temp = 0;
    for i=1:height
       for j=1:width
           if(input_image(i,j)== labels(k))
               temp = temp +1;
           end
       end
    end
    area = [area temp];
end
labelCol = reshape(labels,[],1);
areaCol = reshape(area, [],1);

A = table(labelCol,areaCol,...
    'VariableNames',{'Labels' 'Area'})


end

