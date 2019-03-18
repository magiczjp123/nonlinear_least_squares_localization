function [ R ] = H( X,Feature,numP,landmarks, CASE )


if CASE == 'A';
    R = zeros(numP*(2+landmarks*2),1);


    R(1,1) = sqrt(X(1)^2 + X(2)^2);
    R(2,1) = X(3);
    m=3;
    for l=1:landmarks
        R(m,1) = sqrt((Feature(l,1) - X(1))^2 + (Feature(l,2) - X(2))^2);
        R(m+1,1) = atan((Feature(l,2) - X(2))/(Feature(l,1) - X(1))) - X(3);
        if R(m+1,1) > 2*pi
            R(m+1,1) = R(m+1,1) - 2*pi;
        elseif R(m+1,1) < 0
            R(m+1,1) = R(m+1,1) + 2*pi;
        end
        m=m+2;
    end

    j=2+landmarks*2+1;
    k=4;
    for i = 2:numP
        R(j,1) = sqrt((X(k)-X(k-3))^2 + (X(k+1)-X(k-2))^2);
        R(j+1,1) = X(k+2)-X(k-1);
        m=m+2;
        for l=1:landmarks
            R(m,1) = sqrt((Feature(l,1) - X(k))^2 + (Feature(l,2) - X(k+1))^2);
            R(m+1,1) = atan((Feature(l,2) - X(k+1))/(Feature(l,1) - X(k))) - X(k+2);
            if R(m+1,1) > 2*pi
                R(m+1,1) = R(m+1,1) - 2*pi;
            elseif R(m+1,1) < 0
                R(m+1,1) = R(m+1,1) + 2*pi;
            end
            m=m+2;
        end
        k=k+3;
        j=m;
    end
end

if CASE == 'R';
    R = zeros(numP*(2+landmarks),1);


    R(1,1) = sqrt(X(1)^2 + X(2)^2);
    R(2,1) = X(3);
    m=3;
    for l=1:landmarks
        R(m,1) = sqrt((Feature(l,1) - X(1))^2 + (Feature(l,2) - X(2))^2);
        %R(m+1,1) = atan((Feature(l,2) - X(2))/(Feature(l,1) - X(1))) - X(3);
        m=m+1;
    end

    j=2+landmarks+1;
    k=4;
    for i = 2:numP
        R(j,1) = sqrt((X(k)-X(k-3))^2 + (X(k+1)-X(k-2))^2);
        R(j+1,1) = X(k+2)-X(k-1);
        m=m+2;
        for l=1:landmarks
            R(m,1) = sqrt((Feature(l,1) - X(k))^2 + (Feature(l,2) - X(k+1))^2);
            %R(m+1,1) = atan((Feature(l,2) - X(k+1))/(Feature(l,1) - X(k))) - X(k+2);
            m=m+1;
        end
        k=k+3;
        j=m;
    end
end

if CASE == 'B';
    R = zeros(numP*(2+landmarks),1);


    R(1,1) = sqrt(X(1)^2 + X(2)^2);
    R(2,1) = X(3);
    m=3;
    for l=1:landmarks
        %R(m,1) = sqrt((Feature(l,1) - X(1))^2 + (Feature(l,2) - X(2))^2);
        R(m,1) = atan((Feature(l,2) - X(2))/(Feature(l,1) - X(1))) - X(3);
        if R(m,1) > 2*pi
            R(m,1) = R(m,1) - 2*pi;
        elseif R(m,1) < 0
            R(m,1) = R(m,1) + 2*pi;
        end
        m=m+1;
    end

    j=2+landmarks+1;
    k=4;
    for i = 2:numP
        R(j,1) = sqrt((X(k)-X(k-3))^2 + (X(k+1)-X(k-2))^2);
        R(j+1,1) = X(k+2)-X(k-1);
        m=m+2;
        for l=1:landmarks
            %R(m,1) = sqrt((Feature(l,1) - X(k))^2 + (Feature(l,2) - X(k+1))^2);
            R(m,1) = atan((Feature(l,2) - X(k+1))/(Feature(l,1) - X(k))) - X(k+2);
            if R(m,1) > 2*pi
                R(m,1) = R(m,1) - 2*pi;
            elseif R(m,1) < 0
                R(m,1) = R(m,1) + 2*pi;
            end
            m=m+1;
        end
        k=k+3;
        j=m;
    end
end


end

