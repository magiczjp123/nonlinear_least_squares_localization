close all;
%generate_data_least_squares
generate_data_least_squares_random
stepN = 30;
eps = 10^(-6);
%%*******************X Matrix************************
X = True_pose_wnoise_col;

%%*******************Z Matrix************************
%Already known

%%****************** Iteration **********************
CASE = 'A';
NewX = iteration( X, Z, stepN, Feature, landmarks, numP, eps, CASE);

Pose_NewX = zeros(numP,3);
k=1;
for i=1:numP
    Pose_NewX(i,1) = NewX(k,1);
    Pose_NewX(i,2) = NewX(k+1,1);
    Pose_NewX(i,3) = NewX(k+2,1);
    k=k+3;
end;

figure(1);
plot(Pose(:,1),Pose(:,2),'r-*');
hold on;
plot(True_pose_wnoise(:,1),True_pose_wnoise(:,2),'y-*');
plot(Feature(:,1),Feature(:,2),'g+');
plot(Pose_NewX(:,1),Pose_NewX(:,2),'b-*');

u = cos(Pose(:,3));
v = sin(Pose(:,3));
q = quiver(Pose(:,1),Pose(:,2),u(:,1),v(:,1),0.15);
q.Color = 'red';

uinitguess = cos(True_pose_wnoise(:,3));
vinitguess = sin(True_pose_wnoise(:,3));
qinitguess = quiver(True_pose_wnoise(:,1),True_pose_wnoise(:,2),uinitguess(:,1),vinitguess(:,1),0.15);
qinitguess.Color = 'yellow';

unew = cos(Pose_NewX(:,3));
vnew = sin(Pose_NewX(:,3));
qnew = quiver(Pose_NewX(:,1),Pose_NewX(:,2),unew(:,1),vnew(:,1),0.15);
qnew.Color = 'blue';
%axis([0 5 -3 3]);

%%****************** Range only *********************
CASE = 'R';
NewX = iteration( X, Zrange, stepN, Feature, landmarks, numP, eps, CASE);

Pose_NewX = zeros(numP,3);
k=1;
for i=1:numP
    Pose_NewX(i,1) = NewX(k,1);
    Pose_NewX(i,2) = NewX(k+1,1);
    Pose_NewX(i,3) = NewX(k+2,1);
    k=k+3;
end;

figure(2);
plot(Pose(:,1),Pose(:,2),'r-*');
hold on;
plot(True_pose_wnoise(:,1),True_pose_wnoise(:,2),'y-*');
plot(Feature(:,1),Feature(:,2),'g+');
plot(Pose_NewX(:,1),Pose_NewX(:,2),'b-*');

u = cos(Pose(:,3));
v = sin(Pose(:,3));
q = quiver(Pose(:,1),Pose(:,2),u(:,1),v(:,1),0.15);
q.Color = 'red';

uinitguess = cos(True_pose_wnoise(:,3));
vinitguess = sin(True_pose_wnoise(:,3));
qinitguess = quiver(True_pose_wnoise(:,1),True_pose_wnoise(:,2),uinitguess(:,1),vinitguess(:,1),0.15);
qinitguess.Color = 'yellow';

unew = cos(Pose_NewX(:,3));
vnew = sin(Pose_NewX(:,3));
qnew = quiver(Pose_NewX(:,1),Pose_NewX(:,2),unew(:,1),vnew(:,1),0.15);
qnew.Color = 'blue';
%%****************** Bearing only *********************
CASE = 'B';
stepN = 1;
NewX = iteration( X, Zbearing, stepN, Feature, landmarks, numP, eps, CASE);

Pose_NewX = zeros(numP,3);
k=1;
for i=1:numP
    Pose_NewX(i,1) = NewX(k,1);
    Pose_NewX(i,2) = NewX(k+1,1);
    Pose_NewX(i,3) = NewX(k+2,1);
    k=k+3;
end;

figure(3);
plot(Pose(:,1),Pose(:,2),'r-*');
hold on;
plot(True_pose_wnoise(:,1),True_pose_wnoise(:,2),'y-*');
plot(Feature(:,1),Feature(:,2),'g+');
plot(Pose_NewX(:,1),Pose_NewX(:,2),'b-*');

u = cos(Pose(:,3));
v = sin(Pose(:,3));
q = quiver(Pose(:,1),Pose(:,2),u(:,1),v(:,1),0.15);
q.Color = 'red';

uinitguess = cos(True_pose_wnoise(:,3));
vinitguess = sin(True_pose_wnoise(:,3));
qinitguess = quiver(True_pose_wnoise(:,1),True_pose_wnoise(:,2),uinitguess(:,1),vinitguess(:,1),0.15);
qinitguess.Color = 'yellow';

unew = cos(Pose_NewX(:,3));
vnew = sin(Pose_NewX(:,3));
qnew = quiver(Pose_NewX(:,1),Pose_NewX(:,2),unew(:,1),vnew(:,1),0.15);
qnew.Color = 'blue';