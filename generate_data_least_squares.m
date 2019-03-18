clc;
clear;

Direction = 'data_generated/';

numP = 5;
landmarks = 3;

%% Odometry & observation matrix initialization

height_matrix = numP + (numP*landmarks);
data = zeros(height_matrix, 5);

data(1:numP,1) = 1;
data(numP+1:end, 1) = 2;

for i=1:numP
    data(i,2) = i-1;
    data(i,3) = i;
end;
ind = numP+1;
for i=1:numP;
    for k=1:landmarks;
        data(ind,2) = i;
        data(ind,3) = k;
        ind = ind+1;
    end
end

% pause
%% Odometry
data(1:numP,4) = 1;

data(2:int32(numP/2),5) = 0.2;
data(int32(numP/2+1):numP,5) = -0.2;

% pause
%% Pose
Pose = zeros(numP+1,3);
Phi = 0;
Ti = zeros(2,1);
temp_vel = zeros(numP,2);
for i=1:numP;    
    dR = FuncRMatrix2D(data(i,5));
    temp_vel(i,1) = data(i,4);
    dT = temp_vel(i,1:2)';
    Phi = Phi+data(i,5);
    if Phi > 2*pi
        Phi = Phi - 2*pi;
    elseif Phi < 0
        Phi = Phi + 2*pi;
    end
    Ri = FuncRMatrix2D(Phi);
    Ti = Ti+Ri'*dT;
    Pose(i+1,3) = Phi;
    Pose(i+1,1:2) = Ti';
end;

%plot(Pose(:,1),Pose(:,2),'r-*');
%axis([0 numP -3 3]);

%pause
%% True Pose with Noise
Noise_pose_coord = 0.2;

N_pose_coord = randn(numP,2)*Noise_pose_coord;
for i=1:numP;
    for j=1:2;
        if N_pose_coord(i,j)>2*Noise_pose_coord;
            N_pose_coord(i,j)=2*Noise_pose_coord;
        elseif N_pose_coord(i,j)<-2*Noise_pose_coord;
            N_pose_coord(i,j)=-2*Noise_pose_coord;
        end;
    end;
end;

Noise_pose_ori = 0.02;
N_pose_ori = randn(numP,1)*Noise_pose_ori;
for i=1:numP;
    if N_pose_ori(i,1)>2*Noise_pose_ori;
        N_pose_ori(i,1)=2*Noise_pose_ori;
    elseif N_pose_ori(i,1)<-2*Noise_pose_ori;
        N_pose_ori(i,1)=-2*Noise_pose_ori;
    end;
end;

N_pose = zeros(numP,3);
for i=1:numP;
    N_pose(i,1)= N_pose_coord(i,1);
    N_pose(i,2)= N_pose_coord(i,2);
    N_pose(i,3)= N_pose_ori(i,1);
end;

True_pose_wnoise = Pose(2:numP+1,:)+N_pose;
for i=1:numP;
    if True_pose_wnoise(i,3) > 2*pi
        True_pose_wnoise(i,3) = True_pose_wnoise(i,3) - 2*pi;
    elseif True_pose_wnoise(i,3) < 0
        True_pose_wnoise(i,3) = True_pose_wnoise(i,3) + 2*pi;
    end
end;
% 
% hold on;
% plot(True_pose_wnoise(:,1),True_pose_wnoise(:,2),'y-*');

True_pose_wnoise_col = zeros(numP*3,1);
k=1;
for i=1:numP;
    True_pose_wnoise_col(k,1) = Pose(i+1,1)+N_pose(i,1);
    True_pose_wnoise_col(k+1,1) = Pose(i+1,2)+N_pose(i,2);
    True_pose_wnoise_col(k+2,1) = Pose(i+1,3)+N_pose(i,3);
    if True_pose_wnoise_col(k+2,1) > 2*pi
        True_pose_wnoise_col(k+2,1) = True_pose_wnoise_col(k+2,1) - 2*pi;
    elseif True_pose_wnoise_col(k+2,1) < 0
        True_pose_wnoise_col(k+2,1) = True_pose_wnoise_col(k+2,1) + 2*pi;
    end
    k=k+3;
end;

%pause
%% Observations Odometry

Noise_odo_vel = 0.2;

N_O_vel = randn(numP,1)*Noise_odo_vel;
for i=1:numP;
    if N_O_vel(i,1)>2*Noise_odo_vel;
        N_O_vel(i,1)=2*Noise_odo_vel;
    elseif N_O_vel(i,1)<-2*Noise_odo_vel;
        N_O_vel(i,1)=-2*Noise_odo_vel;
    end;
end;

Noise_odo_angle = 0.02;

N_O_angle = randn(numP,1)*Noise_odo_angle;
for i=1:numP;
    if N_O_angle(i,1)>2*Noise_odo_angle;
        N_O_angle(i,1)=2*Noise_odo_angle;
    elseif N_O_angle(i,1)<-2*Noise_odo_angle;
        N_O_angle(i,1)=-2*Noise_odo_angle;
    end;
end;

data(1:numP,4) = data(1:numP,4) + N_O_vel;
data(1:numP,5) = data(1:numP,5) + N_O_angle;

%pause
%% Features

data(numP+1:numP+(numP*landmarks),1) = 2;
ind = 0;
for i=1:numP
    for j=1:landmarks
        data(i+numP+ind,2) = i;
        data(i+numP+ind,3) = j;
        if j<landmarks
            ind = ind+1;
        end
    end
end;

Feature = zeros(landmarks,2);
Feature(1,1) = 1.25;
Feature(1,2) = 1.5;
Feature(2,1) = 3.75;
Feature(2,2) = 1.5;
Feature(3,1) = 2.5;
Feature(3,2) = -1.5;

% hold on;
% plot(Feature(:,1),Feature(:,2),'g+');

%pause
%% Range Observations Feature
Noise_range_obs = 0.2;
N_range_obs = randn((numP+1)*landmarks,1)*Noise_range_obs;

ROF = zeros((numP+1)*landmarks,1);
ind = 1;
for i=1:numP+1;
    for k=1:landmarks;
        if N_range_obs(ind,1)>2*Noise_range_obs;
            N_range_obs(ind,1)=2*Noise_range_obs;
        elseif N_range_obs(ind,1)<-2*Noise_range_obs;
            N_range_obs(ind,1)=-2*Noise_range_obs;
        end;
        X = [Pose(i,1:2);Feature(k,:)];
        ROF(ind,1) = pdist(X,'euclidean')+N_range_obs(ind,1);
        ind = ind+1;
    end;
end;
data((numP+1):(numP+(numP*landmarks)),4) = ROF((landmarks+1):((numP+1)*landmarks),1);

%% Bearing Observations Feature
Noise_bearing_obs = 0.02;
N_bearing_obs = randn((numP+1)*landmarks,1)*Noise_bearing_obs;

BOF = zeros((numP+1)*landmarks,1);
ind = 1;
for i=1:numP+1;
    for k=1:landmarks;
        if N_bearing_obs(ind,1)>2*Noise_bearing_obs;
            N_bearing_obs(ind,1)=2*Noise_bearing_obs;
        elseif N_bearing_obs(ind,1)<-2*Noise_bearing_obs;
            N_bearing_obs(ind,1)=-2*Noise_bearing_obs;
        end;
        BOF(ind,1) = atan2(Feature(k,2)-Pose(i,2),Feature(k,1)-Pose(i,1)) - Pose(i,3)+N_bearing_obs(ind,1);
        if BOF(ind,1) > 2*pi
            BOF(ind,1) = BOF(ind,1) - 2*pi;
        elseif BOF(ind,1) < 0
            BOF(ind,1) = BOF(ind,1) + 2*pi;
        end
        ind = ind+1;
    end;
end;
data((numP+1):(numP+(numP*landmarks)),5) = BOF((landmarks+1):((numP+1)*landmarks),1);

R_B_OF = zeros(numP*landmarks*2,1);
j=1;
for i=1:numP*landmarks
    R_B_OF(j,1) = ROF(landmarks+i,1);
    R_B_OF(j+1,1) = BOF(landmarks+i,1);
    j=j+2;
end

%% Z matrix initialisation

Z = zeros(numP*(2+landmarks*2),1);
j=1;
k=1;
for i=1:numP
   Z(j,1) = data(i,4);
   Z(j+1,1) = data(i,5);
   Z(j+2:j+1+landmarks*2,1) = R_B_OF(k:k+landmarks*2-1,1);
   j=j+2+landmarks*2;
   k=k+landmarks*2;
end

Zrange = zeros(numP*(2+landmarks),1);
Zbearing = zeros(numP*(2+landmarks),1);
j=1;
k=landmarks+1;
for i=1:numP
   Zrange(j,1) = data(i,4);
   Zrange(j+1,1) = data(i,5);
   
   Zbearing(j,1) = data(i,4);
   Zbearing(j+1,1) = data(i,5);
   
   Zrange(j+2:j+1+landmarks,1) = ROF(k:k+landmarks-1,1);
   Zbearing(j+2:j+1+landmarks,1) = BOF(k:k+landmarks-1,1);
   j=j+2+landmarks;
   k=k+landmarks;
end


%% Save file

file = strcat(Direction,'localmap_test');
save(file,'data','Pose','Feature','ROF','BOF','True_pose_wnoise_col','Z','Zrange','Zbearing');
