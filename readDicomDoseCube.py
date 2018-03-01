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
    nx = dicom_info.Width
    ny = dicom_info.Height
    doseScale = dicom_info.DoseGridScaling
    unitStr = dicom_info.DoseUnits
    typeStr = dicom_info.DoseType
    dx = dicom_info.PixelSpacing[0]
    dy = dicom_info.PixelSpacing[1]
    zoff = dicom_info.GridFrameOffsetVector
    dz = np.diff(zoff)
    errDz = np.linalg.norm(np.diff(dz))


    def read_dicom_dose_cube(file_name):


        # Throw error if spacing not uniform
        if errDz < 0.1:
            dz = dz[0]
        else:
            print("z-spacing not uniform! - {}".format(str(errDz)))

        x = np.linspace(x0, dx, xn)
        y = np.linspace(y0, dy, yn)
        for i in zoff:
            z[i] = z0 + zoff[i]
        #    z = z0 + zoff

        #print(z)

