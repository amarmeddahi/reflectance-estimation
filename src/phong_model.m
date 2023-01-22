function imgs_phong = phong_model(lightDirections, normalVectors, specularDirections, lightsValid, in_mask, error_pixels, numLights, numPixels, rho_d, albedo_spec, coeff_spec, v)
%APPLY_PHONG_MODEL applies the Phong reflectance model to an image
%   Inputs:
%       lightDirections: a 3D array of light directions (numLights x 3 x numImages)
%       normalVectors: a 3D array of surface normals (h x w x numImages)
%       specularDirections: a 3D array of specular directions (numLights x h x w)
%       lightsValid: a binary array indicating which lights are valid for each pixel (h x w x numImages)
%       in_mask: a 2D binary mask indicating which pixels are in the object (h x w)
%       error_pixels: a list of pixels that have errors in their normals
%       numLights: number of light sources
%       numPixels: number of pixels
%       rho_d: diffuse reflectance coefficient
%       albedo_spec: specular albedo 
%       coeff_spec: specular exponent 
%       v: view direction 
%   Outputs:
%       imgs_phong: a 3D array of images with Phong reflectance applied (h x w x numImages)

% Create Phong model images
imgs_phong = zeros([numPixels numLights]);
for i = setdiff(in_mask,error_pixels)
    tempLightsValid = find(lightsValid(i,:) ~=0);
    % Model = Lambert + Phong for valid pixels
    for j = tempLightsValid
        imgs_phong(i,j) = rho_d(i) .* sum(lightDirections(j, :) .* normalVectors(i,:),2) +  albedo_spec(i) * sum(v .* squeeze(specularDirections(j,i,:)))^coeff_spec(i);
    end
    % Model = Lambert otherwise
    for j = setdiff(1:numLights,tempLightsValid)
        imgs_phong(i,j) = rho_d(i) .* sum(lightDirections(j, :) .* normalVectors(i,:),2);
    end
end