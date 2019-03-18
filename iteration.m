function [ R ] = iteration( X, Z, stepN, Feature, landmarks, numP, eps, CASE)


R = X;

last_er = 100000;
max_er = 1;
count=1;
while max_er > eps
    Xold = R;
    
    J = JF(R',Feature,landmarks,CASE);
    R = inv(J'*J)*J'*(Z - H(R, Feature,numP,landmarks,CASE) + J*R);
    
    er = R - Xold;
    max_er = max(abs(er));
    
%     if max_er > last_er
%         R = Xold;
%         break;
%     end
%     last_er = max_er;
    
    if count > stepN
        break;
    end
    count=count+1;
end
er
count
max_er

% last_er = 100000;
% er = 1;
% count=1;
% while er > eps
%     Xold = R;
%     
%     J = JF(R',Feature,landmarks,CASE);
%     R = inv(J'*J)*J'*(Z - H(R, Feature,numP,landmarks,CASE) + J*R);
%     
%     
%     k=3;
%     for i=1:numP
%         R(k,1) = mod(R(k,1),2*pi);
%         k = k+3;
%     end
%     
%     
%     [PSNR,MSE,MAXERR,L2RAT] = measerr(Xold,R);
%     er = MSE;
%     
% %     if er > last_er
% %         R = Xold;
% %         break;
% %     end
% %     last_er = er;
%     
%     if count > stepN
%         break;
%     end
%     count=count+1;
% end
% count
% er

end

