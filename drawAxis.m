function input_image = drawAxis(input_image, labels)


%first let us read in the size of the image and then we can start the
%opperations 

[height, width]=size(input_image);
output = input_image;
numLabel = size(labels, 2);
m00 = [];
m10 = [];
m01 = [];
m10 = [];
m01 = [];
m20 = [];
m02 = [];
m11 = [];

for k =1:numLabel
    [m00temp, m01temp, m10temp, m20temp, m02temp, m11temp] = calcMoment(input_image,labels(k));
    m00 = [m00 m00temp];
    m10 = [m10 m10temp];
    m01 = [m01 m01temp];
    m11 = [m11 m11temp];
    m20 = [m20 m20temp];
    m02 = [m02 m02temp];
    
end

figure, imshow(uint8(input_image))
hold on

for k=1:numLabel
    xc = m10(k)/m00(k);
    yc = m01(k)/m00(k);
    
   %plot(yc,xc,'r+', 'MarkerSize', 50);
    
    u00 = m00(k);
    u11 = m11(k)-xc*(m01(k));
    u20 = m20(k)-xc*m10(k);
    u02 = m02(k)-yc*m01(k);
    
    lambdaMin = 1/(2*u00)*(u20+u02 - sqrt((u20-u02)^2+4*u11^2));
    lambdaMax = 1/(2*u00)*(u20+u02 + sqrt((u20-u02)^2+4*u11^2));
    thetaMaj = .5*atan2(2*u11, u20-u02);
    thetaMin = pi/2 + thetaMaj;
    
    xmajdown = xc + cos(thetaMaj)*sqrt(lambdaMax);
    ymajdown = yc + sin(thetaMaj)*sqrt(lambdaMax);
    xmajup = xc - cos(thetaMaj)*sqrt(lambdaMax);
    ymajup = yc - sin(thetaMaj)*sqrt(lambdaMax);
    
   
  
  line([ymajdown ymajup],[xmajdown xmajup]);
  hold on
    
%{    
    xminr = xc + cos(pi/2 - thetaMaj)*sqrt(lambdaMin)
    yminr = yc + sin(pi/2 - thetaMaj)*sqrt(lambdaMin)
    xminl = xc - cos(thetaMaj)*sqrt(lambdaMin)
    yminl = yc - sin(thetaMaj)*sqrt(lambdaMin)
  %}
    xmindown = xc + cos(thetaMin)*sqrt(lambdaMin);
    ymindown = yc + sin(thetaMin)*sqrt(lambdaMin);
    xminup = xc - cos(thetaMin)*sqrt(lambdaMin);
    yminup = yc - sin(thetaMin)*sqrt(lambdaMin);
    
    
      line ([ymindown yminup],[xmindown xminup]);

   
    
    
    
end
%title('Central Axis');


end

