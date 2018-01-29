# function [sCube, iRC] = readDicomDoseCube(pcFilePathAndName) 


# %*******************************************************************************
# % Title:   readDicomDoseCube.m
# % Author:  John Eley
# % Date:    31 October 2012
# %
# % Purpose: Read DICOM dose into cube structure (3D array)
# %
# % Input:   File path to DICOM RT dose file
# %
# % Output:  sCube
# %          sCube.pppdData
# %          sCube.pppdXCoords (mm)
# %          sCube.pppdYCoords (mm)
# %          sCube.pppdZCoords (mm)
# %          sCube.nX
# %          sCube.nY
# %          sCube.nZ
# %          sCube.dDeltaX (mm)
# %          sCube.dDeltaY (mm)
# %          sCube.dDeltaZ (mm)
# %          sCube.dXMin (mm)
# %          sCube.dYMin (mm)
# %          sCube.dZMin (mm)
# %          sCube.dXMax (mm)
# %          sCube.dYMax (mm)
# %          sCube.dZMax (mm)
# %          sCube.pcDataUnits
# %
# % Notes:   Uses codes from Mirkovic 2010 readRTDOSE
# %
# %*******************************************************************************


# % Check that the input file exists
# if (~exist(pcFilePathAndName))
#     error(['<E> DICOM dose file: ' pcFilePathAndName ' not found.']);
# end


fname = pcFilePathAndName;


# %
# % BEGIN Mirkovic Code (ELEY made only minor changes to Mirkovic code which are noted below)
# %


dinfo = dicominfo(fname);
if(~strcmp(dinfo.Modality, 'RTDOSE'))
    error(['The input file: ' file ' is not flagged as RTDOSE.']);
end
x0 = dinfo.ImagePositionPatient(1);
y0 = dinfo.ImagePositionPatient(2);
z0 = dinfo.ImagePositionPatient(3);

T = dinfo.ImageOrientationPatient;
nx = dinfo.Width;
ny = dinfo.Height;
doseScale = dinfo.DoseGridScaling;
unitStr = dinfo.DoseUnits;
typeStr = dinfo.DoseType;
dx = dinfo.PixelSpacing(1);
dy = dinfo.PixelSpacing(2);
zoff = dinfo.GridFrameOffsetVector;
dz = diff(zoff);
errDz = norm(diff(dz));
if errDz < 0.1
    dz = dz(1);
else
    error(['z-spacing not uniform! - ' num2str(errDz)]);
end
nz = size(zoff, 1);

xn = x0 + double(nx-1)*dx;  % make sure that nx-1 is double to avoid integer arithmetic!
yn = y0 + double(ny-1)*dy;  % make sure that ny-1 is double
zn = z0 + zoff(end);

%
%   Build x, y, z coordinate matrices
%
x = x0:dx:xn;
y = y0:dy:yn;
z = z0 + zoff;
%[xd,yd,zd] = meshgrid(x, y, z); % ELEY commented out on 10/31/12, I would rather use ndgrid
[xd,yd,zd] = ndgrid(x, y, z); % ELEY 103112
%
%   Read the dose matrix
%
imd = doseScale*double(squeeze(dicomread(fname)));
out.xd = xd;
out.yd = yd;
out.zd = zd;
out.imd = imd;
out.imdS = [];
out.dmax = max(imd(:));
out.x0 = [x0 y0 z0];
out.xn = [xn yn zn];
out.dx = [dx dy dz];
out.zd1 = squeeze(zd(1,1,:));
out.yd1 = squeeze(yd(:,1,1));
out.xd1 = squeeze(xd(1,:,1));

out.n = [nx ny nz];
out.T = T; 
out.Units = unitStr;
out.Type = typeStr;
% ELEY 121412 - I commented out the following line.  It was causeing problems when reading proton arc therapy distributions, and I don't need it anyway.
%out.beamNo = dinfo.ReferencedRTPlanSequence.Item_1.ReferencedFractionGroupSequence.Item_1.ReferencedBeamSequence.Item_1.ReferencedBeamNumber;

% % ELEY 103112 commented out this message box, I don't need it
% o = sprintf('Done reading RTDOSE file: %s\n', fname);
% o = [o sprintf('Dose matrix size: %d x %d x %d\n', nx, ny, nz)];
% o = [o sprintf('BBox: %f %f %f %f %f %f\n', x0, xn, y0, yn, z0, zn)];
% o = [o sprintf('Pixel spacing: %f %f %f\n', dx, dy, dz)];
% o = [o sprintf('Max dose: %f\n', out.dmax)];
% h = msgbox(o);


%
% END Mirkovic Code
%


%
% Write data to ELEY structure sCube
%

sCube.pppdData = single(permute(out.imd, [2 1 3]));
sCube.pppdXCoords = single(out.xd);
sCube.pppdYCoords = single(out.yd);
sCube.pppdZCoords = single(out.zd);

%
%Read Patient name and info (DStrauss)
%

sCube.Name = dinfo.PatientName;
sCube.PtID = dinfo.PatientID;
sCube.PatientBirthDate = dinfo.PatientBirthDate;
sCube.Manufacturer = dinfo.Manufacturer;
sCube.SeriesDescription = dinfo.SeriesDescription;
sCube.ManufacturerModelName = dinfo.ManufacturerModelName;





sCube.nX = nx;
sCube.nY = ny;
sCube.nZ = nz;
sCube.dDeltaX = dx;
sCube.dDeltaY = dy;
sCube.dDeltaZ = dz;
sCube.dXMin = x0;
sCube.dYMin = y0;
sCube.dZMin = z0;
sCube.dXMax = xn;
sCube.dYMax = yn;
sCube.dZMax = zn;
sCube.pcDataUnits = out.Units;
sCube.dDataMin = min(min(min(sCube.pppdData)));
sCube.dDataMax = max(max(max(sCube.pppdData)));


iRC = 0;