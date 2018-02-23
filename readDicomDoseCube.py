# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import numpy as np
import dicom


def read_dicom_dose_cube(file_name):
    dicom_info = dicom.read_file(file_name)

    x0 = dicom_info.ImagePositionPatient[0]
    y0 = dicom_info.ImagePositionPatient[1]
    z0 = dicom_info.ImagePositionPatient[2]

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

    if errDz < 0.1:
        dz = dz[0]
    else:
        #print(['z-spacing not uniform! - ' + str(errDz)])
        print("z-spacing not uniform! - {}".format(str(errDz)))

    x = np.linspace(x0, dx, xn)
    y = np.linspace(y0, dy, yn)
    for i in zoff:
        z[i] = z0 + zoff[i]
    #    z = z0 + zoff

    print(z)
