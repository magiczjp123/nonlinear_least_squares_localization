function [ R ] = df2(X, CASE)
%UNTITLED4 ????????????
%   ????????

R = zeros(1,size(X,2));

if CASE == 0;
    R(1,3) = 1;
end

if CASE == 1;
    R(1,3) = 1;
    R(1,6) = -1;
end

end

