function [mse_lamb, mae_lamb_pixels, mse_phong, mae_phong_pixels] = compute_error_metrics(imgs_lamb, imgs_phong, imgs_ref, numLights, numPixels)
%COMPUTE_ERROR_METRICS Computes the Mean Squared Error (MSE) and Mean Absolute Error (MAE) 
%   Inputs:
%       imgs_lamb: a 3D array of images with lambertian reflectance applied (h x w x numImages)
%       imgs_phong: a 3D array of images with Phong reflectance applied (h x w x numImages)
%       imgs_ref: a 3D array of reference images (h x w x numImages)
%       numLights: number of light sources
%   Outputs:
%       mse_lamb: MSE for lambertian reflectance model (1 x numLights)
%       mae_lamb_pixels: MAE for each pixel for lambertian reflectance model (numLights x h*w)
%       mse_phong: MSE for Phong reflectance model (1 x numLights)
%       mae_phong_pixels: MAE for each pixel for Phong reflectance model (numLights x h*w)

mse_lamb = zeros(numLights,1);
mae_lamb_pixels = zeros([numLights numPixels]);
mse_phong = zeros(numLights,1);
mae_phong_pixels = zeros([numLights numPixels]);
for i = 1:numLights
    mae_lamb_pixels(i,:) = abs(imgs_lamb(:,i) - imgs_ref(:,i));
    mae_phong_pixels(i,:) = abs(imgs_phong(:,i) - imgs_ref(:,i));
    mse_lamb(i) = mean((imgs_lamb(:,i) - imgs_ref(:,i)).^2);
    mse_phong(i) = mean((imgs_phong(:,i) - imgs_ref(:,i)).^2);
end
