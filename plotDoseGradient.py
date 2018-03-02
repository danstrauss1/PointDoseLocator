"""
plotDoseGradient.py

Written by Dan Strauss 3/1/2018
Computes dose gradient from an RT DICOM file

"""


from readDicomDoseCube import DoseCube
import numpy as np

#dosegradient():
x0 = DoseCube.x0
y0 = DoseCube.y0
z0 = DoseCube.z0

xMax = np.max(DoseCube.xn)
yMax = DoseCube.yn
zMax = DoseCube.zn

dMax = DoseCube.dmax

dosematrix = DoseCube.pppdData
gradmatrix = np.gradient(dosematrix)

DoseThreshold = 0.5

# Find indicies which correspond to the dose threshold level
i = np.nonzero(dosematrix > dMax * DoseThreshold)

# Implement dose threshold to position matricies
X = DoseCube.nx[i]
Y = DoseCube.ny
Z = DoseCube.nz

# Implement dose threshold to dose matrix
T = dosematrix(i)

# Use absolute dose gradient for calculations
H = np.abs(gradmatrix(i))