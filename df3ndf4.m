function [ R ] = df3ndf4( X,Feature, landmarks, CASE )
%UNTITLED7 ????????????
%   ????????

R = zeros(landmarks,size(X,2));

if CASE == 'R';
    for i = 1:1:landmarks;
        R(i,1) = (X(1) - Feature(i,1))/(sqrt((Feature(i,1) - X(1))^2 + (Feature(i,2) - X(2))^2));
        R(i,2) = (X(2) - Feature(i,2))/(sqrt((Feature(i,1) - X(1))^2 + (Feature(i,2) - X(2))^2));
    end
        
end

if CASE == 'B';
    for i = 1:1:landmarks;
        R(i,1) = (X(1) - Feature(i,1))/((Feature(i,1) - X(1))^2 + (Feature(i,2) - X(2))^2);
        R(i,2) = (X(2) - Feature(i,2))/((Feature(i,1) - X(1))^2 + (Feature(i,2) - X(2))^2);
        R(i,3) = -1;
    end
end
if CASE == 'A';
    R = zeros(2*landmarks,size(X,2));
    j = 1;
    for i=1:2:2*landmarks;
        R(i,1) = (X(1) - Feature(j,1))/(sqrt((Feature(j,1) - X(1))^2 + (Feature(j,2) - X(2))^2));
        R(i,2) = (X(2) - Feature(j,2))/(sqrt((Feature(j,1) - X(1))^2 + (Feature(j,2) - X(2))^2));
        R(i+1,1) = (X(1) - Feature(j,1))/((Feature(j,1) - X(1))^2 + (Feature(j,2) - X(2))^2);
        R(i+1,2) = (X(2) - Feature(j,2))/((Feature(j,1) - X(1))^2 + (Feature(j,2) - X(2))^2);
        R(i+1,3) = -1;
        j=j+1;
    end
end
    

end

