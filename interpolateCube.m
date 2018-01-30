function [sCubeOut, iRC] = interpolateCube(sCubeIn, ...
                                           dXMin, dDeltaX, dXMax, ...
                                           dYMin, dDeltaY, dYMax, ...
                                           dZMin, dDeltaZ, dZMax, ...
                                           iInterpolationFlag)


%*******************************************************************************
% Title:   interpolateCube.m
% Author:  John Eley
% Date:    31 October 2012
%
% Purpose: Interpolate 3D data (sCube) onto a new 3D grid (sCube), 
%          can also use to crop 3D data
% 
% Input:   sCube
%              sCube.pppdData
%              sCube.pppdXCoords (mm)
%              sCube.pppdYCoords (mm)
%              sCube.pppdZCoords (mm)
%              sCube.nX
%              sCube.nY
%              sCube.nZ
%              sCube.dDeltaX (mm)
%              sCube.dDeltaY (mm)
%              sCube.dDeltaZ (mm)
%              sCube.dXMin (mm)
%              sCube.dYMin (mm)
%              sCube.dZMin (mm)
%              sCube.dXMax (mm)
%              sCube.dYMax (mm)
%              sCube.dZMax (mm)
%              sCube.pcDataUnits
%          dXMin (mm, dimensions for new sCubeOut) 
%          dDeltaX (mm)
%          dXMax (mm)
%          dYMin (mm)
%          dDeltaY (mm)
%          dYMax (mm)
%          dZMin (mm)
%          dDeltaZ (mm)
%          dZMax (mm)
%          iInterpolationFlag (0 = nearest neighbor, 1 = linear interpolation)
%
% Output:  sCube
%              sCube.pppdData
%              sCube.pppdXCoords (mm)
%              sCube.pppdYCoords (mm)
%              sCube.pppdZCoords (mm)
%              sCube.nX
%              sCube.nY
%              sCube.nZ
%              sCube.dDeltaX (mm)
%              sCube.dDeltaY (mm)
%              sCube.dDeltaZ (mm)
%              sCube.dXMin (mm)
%              sCube.dYMin (mm)
%              sCube.dZMin (mm)
%              sCube.dXMax (mm)
%              sCube.dYMax (mm)
%              sCube.dZMax (mm)
%              sCube.pcDataUnits
%
% Notes:   
%
%*******************************************************************************


% Check that new requested grid is within bounds of original data
if (dXMin < sCubeIn.dXMin) || ...
   (dXMax > sCubeIn.dXMax) || ...
   (dYMin < sCubeIn.dYMin) || ...
   (dYMax > sCubeIn.dYMax) || ...
   (dZMin < sCubeIn.dZMin) || ...
   (dZMax > sCubeIn.dZMax) 

    disp('<W> New dimensions exceed boundaries of original data.  Zero padding will occur.  Be careful.');
   
end


%
% Create coordinate arrays
%

[pppdXCoords, pppdYCoords, pppdZCoords] = ndgrid(dXMin:dDeltaX:dXMax, ...
                                                 dYMin:dDeltaY:dYMax, ...
                                                 dZMin:dDeltaZ:dZMax ...
                                                );

sCubeOut.pppdXCoords = single(pppdXCoords);
clear pppdXCoords
sCubeOut.pppdYCoords = single(pppdYCoords);
clear pppdYCoords
sCubeOut.pppdZCoords = single(pppdZCoords);
clear pppdZCoords
  
                                          
%
% Interpolate (linear)
%
if (iInterpolationFlag == 0)
    pcInterpolationMethod = 'nearest';
elseif (iInterpolationFlag == 1)
    pcInterpolationMethod = 'linear';
else
    pcInterpolationMethod = 'linear';
    disp('<W> Invalid interpolation flag given to interpolateCube.m.  Using default linear interpolation.')
end
sCubeOut.pppdData = single(interpn(sCubeIn.pppdXCoords, ...
                                   sCubeIn.pppdYCoords, ...
                                   sCubeIn.pppdZCoords, ...
                                   sCubeIn.pppdData, ...
                                   sCubeOut.pppdXCoords, ...
                                   sCubeOut.pppdYCoords, ...
                                   sCubeOut.pppdZCoords, ...
                                   pcInterpolationMethod, ...
                                   0.0 ...
                                   ));
                                             
                                                                                         
%
% Write data to new cube
%

sCubeOut.nX = size(sCubeOut.pppdData, 1);
sCubeOut.nY = size(sCubeOut.pppdData, 2);
sCubeOut.nZ = size(sCubeOut.pppdData, 3);
sCubeOut.dDeltaX = dDeltaX;
sCubeOut.dDeltaY = dDeltaY;
sCubeOut.dDeltaZ = dDeltaZ;
sCubeOut.dXMin = min(min(min(sCubeOut.pppdXCoords)));
sCubeOut.dYMin = min(min(min(sCubeOut.pppdYCoords)));
sCubeOut.dZMin = min(min(min(sCubeOut.pppdZCoords)));
sCubeOut.dXMax = max(max(max(sCubeOut.pppdXCoords)));
sCubeOut.dYMax = max(max(max(sCubeOut.pppdYCoords)));
sCubeOut.dZMax = max(max(max(sCubeOut.pppdZCoords)));
sCubeOut.pcDataUnits = sCubeIn.pcDataUnits;

iRC = 0;





