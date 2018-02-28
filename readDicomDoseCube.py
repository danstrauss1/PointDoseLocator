# -*- coding: utf-8 -*-
"""
 Title:   readDicomDoseCube.m
 Author:  John Eley
 Date:    31 October 2012

 Purpose: Read DICOM dose into cube structure (3D array)

 Input:   File path to DICOM RT dose file

 Output:  sCube
          sCube.pppdData
          sCube.pppdXCoords (mm)
          sCube.pppdYCoords (mm)
          sCube.pppdZCoords (mm)
          sCube.nX
          sCube.nY
          sCube.nZ
          sCube.dDeltaX (mm)
          sCube.dDeltaY (mm)
          sCube.dDeltaZ (mm)
          sCube.dXMin (mm)
          sCube.dYMin (mm)
          sCube.dZMin (mm)
          sCube.dXMax (mm)
          sCube.dYMax (mm)
          sCube.dZMax (mm)
          sCube.pcDataUnits

 Notes:   Uses codes from Mirkovic 2010 readRTDOSE

 Converted to .py by Dan Strauss 2.28.2018
"""

import numpy as np
import dicom

def ReadDicomDoseCube(fname):
    
    
    dinfo = dicom.read_file(fname)
    
    x0 = dinfo.ImagePositionPatient[0]
    y0 = dinfo.ImagePositionPatient[1]
    z0 = dinfo.ImagePositionPatient[2]

    T = dinfo.ImageOrientationPatient
    nx = dinfo.Width
    ny = dinfo.Height
    doseScale = dinfo.DoseGridScaling
    unitStr = dinfo.DoseUnits
    typeStr = dinfo.DoseType
    dx = dinfo.PixelSpacing[0]
    dy = dinfo.PixelSpacing[1]
    zoff = dinfo.GridFrameOffsetVector
    dz = np.diff(zoff)
    errDz = np.linalg.norm(np.diff(dz))
    
    if errDz < 0.1:
        dz = dz[0]
    else:
        print(['z-spacing not uniform! - ' + str(errDz)])
        
    x = np.linspace(x0, dx, xn)
    y = np.linspace(y0, dy, yn)
    for i in zoff:
        z[i] = z0 + zoff[i]
#    z = z0 + zoff
    
    print(z)
    
    