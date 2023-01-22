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

Clearly, a specific folder should contain only all the RTI images. Then you can use the `read_rti_data.m` script to extract and format the data. You will have to modify the variables of the script to adapt it to your dataset. The txt parser has been developed in the most flexible way possible to adapt to your specific data, but you may have to modify it in some specific cases.

### Reflectance estimation with Phong model
`reflectance_estimation.m` is an implementation of the Phong reflectance model for multiple light sources. It loads data from several .mat files, including images, lights, and a binary mask. It then reshapes and vectorizes the data, computes the specular directions, and initializes a linear system. The script then solves the linear system and computes error metrics for the resulting model images. The script ends by saving the results and reshaped images to .mat files. Please modify the different paths in the script according to yours.

### Visualization
`results_visualization` is used to display and analyze the results of the Phong reflectance model implemented in `reflectance_estimation.m`. It loads and displays the error pixels mask, the mean squared error (MSE) for both the Lambertian and Phong models, and the mean absolute error (MAE) for each light for both models. The script also displays the ground truth, Lambertian and Phong model images, and the MAE for each light as a heatmap. The script allows the user to view the results one light at a time by waiting for a button press before moving to the next image. Please modify the different paths in the script according to yours.

## Acknowledgments
 - [Matlab code for robust nonconvex photometric stereo](https://github.com/yqueau/robust_ps)
 - [Étude et modélisation de la réflectance de la surface d'objets réels
](https://domurado.pagesperso-orange.fr/Memoire/)


