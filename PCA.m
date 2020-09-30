function [theta, lambdaMax, lambdaMin, ecentricity, MajAxis, MinAxis] = PCA(input_image, labels)
%PCA Summary of this function goes here
%   Detailed explanation goes here

numLabel =size(labels,2);


    m00 = [];
    m10 = [];
    m01 = [];
    m11 = [];
    m20 = [];
    m02 = [];

for k =1:numLabel
    [m00temp, m01temp, m10temp, m20temp, m02temp, m11temp] = calcMoment(input_image,labels(k));
    m00 = [m00 m00temp];
    m10 = [m10 m10temp];
    m01 = [m01 m01temp];
    m11 = [m11 m11temp];
    m20 = [m20 m20temp];
    m02 = [m02 m02temp];
    
end

lambdaMin = [];
lambdaMax = [];
theta = [];
MajAxis = [];
MinAxis = [];
ecentricity = [];


for k=1:numLabel
    xc = m10(k)/m00(k);
    yc = m01(k)/m00(k);
    
   %plot(yc,xc,'r+', 'MarkerSize', 50);
    
    u00 = m00(k);
    u11 = m11(k)-xc*(m01(k));
    u20 = m20(k)-xc*m10(k);
    u02 = m02(k)-yc*m01(k);
    
    lambdaMini = 1/(2*u00)*(u20+u02 - sqrt((u20-u02)^2+4*u11^2));
    lambdaMaxi = 1/(2*u00)*(u20+u02 + sqrt((u20-u02)^2+4*u11^2));
    thetaMaj = .5*atan2(2*u11, u20-u02);
    thetaMin = pi/2 + thetaMaj;
    
    tempMajAxis = 2*sqrt(lambdaMaxi);
    tempMinAxis = 2*sqrt(lambdaMini);
    tempEcc = sqrt((lambdaMaxi-lambdaMini)/lambdaMaxi);
    
    
    lambdaMin = [lambdaMin lambdaMini ];
    lambdaMax = [lambdaMax lambdaMaxi];
    theta = [theta thetaMaj];
    MajAxis = [MajAxis tempMajAxis];
    MinAxis = [MinAxis tempMinAxis];
    ecentricity = [ecentricity tempEcc];
    
end


end

