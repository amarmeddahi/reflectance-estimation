function imgs_lamb = lambertian_model(lightDirections, normalVectors, in_mask, rho_d, numPixels, numLights)
%APPLY_LAMBERTIAN_MODEL applies the lambertian reflectance model to an image
%   Inputs:
%       lightDirections: a 3D array of light directions (numLights x 3 x numImages)
%       normalVectors: a 3D array of surface normals (h x w x numImages)
%       in_mask: a 2D binary mask indicating which pixels are in the object (h x w)
%       numLights: number of light sources
%       numPixels: number of pixels in a single
%       rho_d: diffuse reflectance coefficient
%   Outputs:
%       imgs_lamb: a 3D array of images with lambertian reflectance applied (h x w x numImages)

imgs_lamb = zeros(numPixels, numLights);
for i = 1:numLights
    imgs_lamb(in_mask,i) = rho_d(in_mask) .* sum(lightDirections(i, :) .* normalVectors(in_mask,:),2);
end

