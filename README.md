# Reflectance estimation using RTI data
The goal of this repo is to propose a solution to extract information about the BRDF of an object thanks to RTI data.

## Description

The estimation of reflectance is mainly studied by the Phong model. Indeed, the traditional approach is to extract a diffuse albedo from the Lambertian model using the data. We propose to estimate the parameters of the Phong model with these same data (i.e., specular albedo and specular coefficients).

## Getting Started

### RTI dataset
To estimate the reflectance parameters with the Phong model, you will need an RTI dataset. The structure of the file should be as follows:
. └── dataset_RTI/ ├── images/ │ ├── img000.{JPG;PNG;...} │ ├── ... │ └── imgXYZ.{JPG;PNG;...} ├── light.txt └── ...


## Acknowledgments

 - [Matlab code for robust nonconvex photometric stereo](https://github.com/yqueau/robust_ps)
