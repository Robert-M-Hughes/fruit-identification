function [output] = FruitIdentify(input_image, labels, wall_labels)

[height, width]=size(input_image);
components = size(labels,2);
areaRet = [];
for k=1:components
    temp = 0;
    for i=1:height
       for j=1:width
           if(input_image(i,j)== labels(k))
               temp = temp +1;
           end
       end
    end
    areaRet = [areaRet temp];
end

[theta, lambdaMax, lambdaMin, ecentricity, MajAxis, MinAxis] = PCA(input_image, labels);

labelCol = reshape(labels,[],1);
areaCol = reshape(areaRet, [],1);
thetaCol = reshape(theta, [], 1);
lambdaCol =reshape(lambdaMin , [], 1);
lambdaMCol = reshape(lambdaMax, [], 1);
ecentricityCol = reshape(ecentricity, [], 1);
MajCol = reshape(MajAxis, [], 1);
MinCol = reshape(MinAxis, [], 1);

A = table(labelCol,areaCol,thetaCol, lambdaCol, lambdaMCol, ecentricityCol, MajCol, MinCol,...
    'VariableNames',{'Labels' 'Area' 'Direction' 'EigenvalueA' 'EigenvalueB' 'Eccentricity' 'MajorAxis' 'MinorAxis'})
output = zeros(height, width,3);
output(:,:,1) = input_image;
output(:,:,2) = input_image;
output(:,:,3) = input_image;

for k = 1:components
    for i = 1:height
        for j=1:width
            for e=1:3
                if(ecentricity(k)>.7 && output(i,j,e) == wall_labels(k))
                   output(i,j,1) = 255;
                   output(i,j,2) = 255;
                   output(i,j,3) = 0;
                elseif(areaRet(k) > 4000 && output(i,j,e) == wall_labels(k))
                   output(i,j,1) = 255;
                   output(i,j,2) = 165;
                   output(i,j,3) = 0;
                elseif(output(i,j,e) == wall_labels(k))
                  output(i,j,1) = 255;
                   output(i,j,2) = 0;
                   output(i,j,3) = 0;  
                end
            end
        end
    end
end

m00 = [];
m10 = [];
m01 = [];
m10 = [];
m01 = [];
m20 = [];
m02 = [];
m11 = [];
figure, imshow(uint8(output))
title('Identified Fruits');

hold on



    for k = 1:components
        [m00temp, m01temp, m10temp, m20temp, m02temp, m11temp] = calcMoment(input_image,labels(k));
        m00 = [m00 m00temp];
        m10 = [m10 m10temp];
        m01 = [m01 m01temp];
        m11 = [m11 m11temp];
        m20 = [m20 m20temp];
        m02 = [m02 m02temp];


        xc = m10(k)/m00(k);
        yc = m01(k)/m00(k);

        xmajdown = xc + cos(theta(k))*sqrt(lambdaMax(k));
        ymajdown = yc + sin(theta(k))*sqrt(lambdaMax(k));
        xmajup = xc - cos(theta(k))*sqrt(lambdaMax(k));
        ymajup = yc - sin(theta(k))*sqrt(lambdaMax(k));



      line([ymajdown ymajup],[xmajdown xmajup]);
       hold on
           thetaMin = pi/2 + theta(k);

        xmindown = xc + cos(thetaMin)*sqrt(lambdaMin(k));
        ymindown = yc + sin(thetaMin)*sqrt(lambdaMin(k));
        xminup = xc - cos(thetaMin)*sqrt(lambdaMin(k));
        yminup = yc - sin(thetaMin)*sqrt(lambdaMin(k));


          line ( [ymindown yminup],[xmindown xminup]);
          hold on
    end

%imshow(uint8(output));


end