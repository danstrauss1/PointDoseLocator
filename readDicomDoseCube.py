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
import pydicom

# Test File
file_name = r'C:\Users\User\Documents\DoseVolumeTest\DoseVolumeTest.dcm'


class DoseCube:

    dicom_info = pydicom.read_file(file_name)

    # Coordinate Start
    x0 = dicom_info.ImagePositionPatient[0]
    y0 = dicom_info.ImagePositionPatient[1]
    z0 = dicom_info.ImagePositionPatient[2]

    # Dicom Info
    T = dicom_info.ImageOrientationPatient
    nx = dicom_info.Columns
    ny = dicom_info.Rows
    doseScale = dicom_info.DoseGridScaling
    unitStr = dicom_info.DoseUnits
    typeStr = dicom_info.DoseType
    dx = dicom_info.PixelSpacing[0]
    dy = dicom_info.PixelSpacing[1]
    zoff = dicom_info.GridFrameOffsetVector
    zoff = np.linspace(zoff[0], zoff[-1], num=np.size(zoff))
    dz = np.diff(zoff)
    errDz = np.linalg.norm(np.diff(dz))



    # Throw error if spacing not uniform
    if errDz < 0.1:
        dz = dz[0]
    else:
        print("z-spacing not uniform! - {}".format(str(errDz)))

    nz = np.size(zoff)

    xn = x0 + np.double(nx-1)*dx
    yn = y0 + np.double(ny-1)*dy
    zn = z0 + zoff[-1]

    #Build x, y, z coordinate matrices
    x = np.linspace(x0, dx, xn)
    y = np.linspace(y0, dy, yn)
    z = z0 + zoff[:]

    [xd, yd, zd] = np.meshgrid(x, y, z)

    imd = doseScale * np.double(np.squeeze(dicom_info.pixel_array))

    dmax = np.max(imd)
    x0 = np.array((x0, y0, z0))
    xn = np.array((xn, yn, zn))
    dx = np.array((dx, dy, dz))

    n = np.array((nx, ny, nz))

    pppdData = imd


