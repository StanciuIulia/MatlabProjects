function H = convexhull(P)

plot(P(1,:),P(2,:),".") %plotting the points
hold on

X = P(1,:); %x coordinates
Y = P(2,:); %y coordinates

Imax = find(X==max(X)); %finding the indexes of the points with max value for x coordonate
[~,J] = max(P(2,Imax)); %finding the index of the point with the maximum value of y out of the ones with max value of x

FirstIndex = Imax(J); %index of the starting point P0(Xmax, Y0)
Index = FirstIndex;
H = Index; %initializing the convex hull


X0 = X(Index);
Y0 = Y(Index);

Xreference = X0;
Yreference = Y0+1;

Angle = atan2d(1,0);
Angle2 = atan2d(Y-Y0,X-X0);


ReferenceAngle = 0;
disp(ReferenceAngle)

DifferenceAngle = Angle2-Angle-ReferenceAngle;
DifferenceAngle = mod(DifferenceAngle,360);
DifferenceAngle(Index) = 360; %setting the angle between the vector of the point and itself to 2*pi instead of 0, to be able to find the minimum angle

DifferenceAngleMIN = min(DifferenceAngle);
Imin = find(DifferenceAngle==DifferenceAngleMIN); %finding all the points with the minimum angle to the starting point

Xmin = P(1,Imin); %x coordinates of the points at the smallest angle
Ymin = P(2,Imin); %y coordinates of the points at the smallest angle
D2 = (Xmin-X0).^2+(Ymin-Y0).^2; %square distance from the points to the starting point P0
[~,Perm] = sort(D2);

Index = Imin(Perm);
H = [H, Index]; %adding index to the convex hull

while(H(end)~= FirstIndex)
    
    X0 = X(Index);
    Y0 = Y(Index);
    Angle = atan2d(1,0);
    Angle2 = atan2d((Y-Y0),(X-X0));
    
    ReferenceAngle = DifferenceAngleMIN;
    
    DifferenceAngle = Angle2;
    DifferenceAngle = DifferenceAngle-Angle-ReferenceAngle;
    DifferenceAngle = mod(DifferenceAngle,360);
    DifferenceAngle(Index) = 360; %setting the angle between the vector of the point and itself to 2*pi instead of 0, to be able to find the minimum angle

    DifferenceAngleMIN = min(DifferenceAngle);
    
    Imin = find(DifferenceAngle==DifferenceAngleMIN); %finding all the points with the minimum angle to the starting point

    Xmin = P(1,Imin); %x coordinate of the points at the smallest angle
    Ymin = P(2,Imin); %y coordinate of the points at the smallest angle
    D2 = (Xmin-X0).^2+(Ymin-Y0).^2; %square distance from the points to the starting point P0
    [~,Perm] = sort(D2);

    Index = Imin(Perm);
    H = [H, Index]; %adding index to the convex hull
end

plot(P(1,H),P(2,H),'b');

end