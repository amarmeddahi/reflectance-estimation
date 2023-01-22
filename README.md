# Reflectance estimation using RTI data
The goal of this repo is to propose a solution to extract information about the BRDF of an object thanks to RTI data.

## Description

The estimation of reflectance is mainly studied by the Phong model. Indeed, the traditional approach is to extract a diffuse albedo from the Lambertian model using the data. We propose to estimate the parameters of the Phong model with these same data (i.e., specular albedo and specular coefficients).

## Getting Started

### RTI dataset
To estimate the reflectance parameters with the Phong model, you will need an RTI dataset. The structure of the file should be as follows:
 - ./dataset_rti
	 - images/
		 - img000.{JPG;PNG;...}
		 - ...
		 - imgXYZ.{JPG;PNG;...}
	 - lights.txt

Clearly, a specific folder should contain only all the RTI images. Then you can use the `read_rti_data.m` script to extract and format the data. You will have to modify the variavles of the script to adapt it to your dataset. 

## Acknowledgments

 - [Matlab code for robust nonconvex photometric stereo](https://github.com/yqueau/robust_ps)


