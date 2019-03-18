function [ R ] = JF( X, Feature, landmarks, CASE )

if CASE == 'A';


    R = zeros((size(X,2)/3)*(2+2*landmarks),size(X,2));

    R(1,1:3) = df1(X(1,1:3),0);
    R(2,1:3) = df2(X(1,1:3),0);
    R(3:(2+2*landmarks),1:3) = df3ndf4(X(1,1:3),Feature,landmarks,'A');

    for i=4:3:size(X,2);
        R(((i-1)/3)*(2+2*landmarks)+1,i-3:i+2) = df1(X(1,i-3:i+2),1);
        R(((i-1)/3)*(2+2*landmarks)+2,i-3:i+2) = df2(X(1,i-3:i+2),1);
        R(((i-1)/3)*(2+2*landmarks)+3:((i-1)/3)*(2+2*landmarks)+landmarks*2+2,i:i+2) = df3ndf4(X(1,i:i+2),Feature,landmarks,'A');
    end
end

if CASE == 'R';
    
    R = zeros((size(X,2)/3)*(2+landmarks),size(X,2));
    
    R(1,1:3) = df1(X(1,1:3),0);
    R(2,1:3) = df2(X(1,1:3),0);
    R(3:(2+landmarks),1:3) = df3ndf4(X(1,1:3),Feature,landmarks,'R');
    
    for i=4:3:size(X,2);
        R(((i-1)/3)*(2+landmarks)+1,i-3:i+2) = df1(X(1,i-3:i+2),1);
        R(((i-1)/3)*(2+landmarks)+2,i-3:i+2) = df2(X(1,i-3:i+2),1);
        R(((i-1)/3)*(2+landmarks)+3:((i-1)/3)*(2+landmarks)+landmarks+2,i:i+2) = df3ndf4(X(1,i:i+2),Feature,landmarks,'R');
        
    end
end

if CASE == 'B';
    
    R = zeros((size(X,2)/3)*(2+landmarks),size(X,2));
    
    R(1,1:3) = df1(X(1,1:3),0);
    R(2,1:3) = df2(X(1,1:3),0);
    R(3:(2+landmarks),1:3) = df3ndf4(X(1,1:3),Feature,landmarks,'B');
    
    for i=4:3:size(X,2);
        R(((i-1)/3)*(2+landmarks)+1,i-3:i+2) = df1(X(1,i-3:i+2),1);
        R(((i-1)/3)*(2+landmarks)+2,i-3:i+2) = df2(X(1,i-3:i+2),1);
        R(((i-1)/3)*(2+landmarks)+3:((i-1)/3)*(2+landmarks)+landmarks+2,i:i+2) = df3ndf4(X(1,i:i+2),Feature,landmarks,'B');
        
    end
end

    




end

