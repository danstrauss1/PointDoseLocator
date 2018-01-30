function [dose] = plotDoseGradient(sCube) 
%This function plots a slice of a sCube dose and outputs the plot of the
%gradient.

%sCube data is exctracted from readDicomDoseCube.m function by John Eley


%Find coordinate shifts
x0 = sCube.dXMin;
y0 = sCube.dYMin;
z0 = sCube.dZMin;

xMax = sCube.dXMax;
yMax = sCube.dYMax;
zMax = sCube.dZMax;

%Define which plane we want to see with dose gradient overlaid
plane = 100;

dosematrix = sCube.pppdData;
gradmatrix = gradient(dosematrix);
contour(dosematrix(:,:,plane));
title(plane)
hold on;
quiver3(gradmatrix(:,:,plane),gradmatrix(:,:,plane),gradmatrix(:,:,plane),gradmatrix(:,:,plane));
grid on;
xlabel('x');
ylabel('y');
zlabel('z');
%mesh(gradmatrix(:,:,plane));
%mesh(dose(:,:,plane));
hold off;

%Plot histogram of absolute gradient values
figure;
hold on;
title('Histogram of Absolute Gradient Values');
ylabel('Count');
xlabel('Gradient Magnitude');
histogram(abs(gradmatrix(gradmatrix ~=0)));
hold off;


%Fraction of Dosemax used in computations
DoseThreshold = .3;


%Find indicies which correspond to the dose threshold of maxdose or more.
i = find(dosematrix > sCube.dDataMax * DoseThreshold);


%Implement dose threshold to position matricies
X = sCube.pppdXCoords(i);
Y = sCube.pppdYCoords(i);
Z = sCube.pppdZCoords(i);

%Implement dose threshold to dose matrix
T = dosematrix(i);

%Use absolute dose gradient for calculations
H = abs(gradmatrix(i));

%Find indicies which have lowest absolute dose gradient.
possiblepoints = find(H == min(H));

xpoints = X(possiblepoints);%+ (xMax/2); %Account for shift?
ypoints = Y(possiblepoints);%+ (yMax);
zpoints = Z(possiblepoints);%+ (zMax/2); %+ (zMax/2);

%Find dose at points in cGy
pointdoses = T(possiblepoints)*100;

%Record coordinates
possiblecoords = [xpoints,ypoints,zpoints,pointdoses];



%Plot points and dose
figure;
hold on;
grid on;
xlabel('x');
ylabel('y');
zlabel('z');

%Plot isosurface at Dose Threshold Level
isosurface(dosematrix,sCube.dDataMax * DoseThreshold);

%Make isosurface transparent
h = findobj(gca,'type','patch');
set(h,'facealpha',0.25);

%Plot optimal dose points
%scatter3(xpoints,ypoints,zpoints,50,pointdoses,'filled');
scatter3(ypoints,xpoints,zpoints,50,pointdoses,'filled');


hold off;


%Read out relavent output
dose.dosematrix = dosematrix;
dose.gradmatrix = gradmatrix;
dose.highdoseindicies = i;
dose.possiblepointsindicies = possiblepoints;
dose.xpoints = xpoints;
dose.ypoints = ypoints;
dose.zpoints = zpoints;
dose.pointcoordinates = possiblecoords;




end

