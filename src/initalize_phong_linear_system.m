function [A,b] = initalize_phong_linear_system(numLights, numPixels, specularDirections, lights, normals, v, imgs, rho_d, mask)
    % Initialize matrices A and b for the Phong model
    %
    % Parameters:
    %   numLights (int) : number of total lights
    %   numPixels (int) : number of total pixels
    %   specularDirections (nxmx3 array) : matrix containing the specular directions for each light, for each pixel specified by the mask
    %   lights (nx3 array) : n lights directions in 3D space
    %   normals (mx3 array) : m normal vectors in 3D space
    %   v (1x3 array) : view vector
    %   imgs (mxn array) : m images for n lights
    %   rho_d (mx1 array) : diffuse reflectance
    %   mask (mx1 boolean array) : mask indicating which pixels to compute specular directions for
    %
    % Returns:
    %   A (nxmx2 array) : matrix used in the Phong model to compute the albedo and specular coefficient
    %   b (nxm array) : matrix used in the Phong model to compute the albedo and specular coefficient
    
    % Initialize a matrix to store the A and b
    A = ones([numLights  numPixels  2]);
    b = zeros([numLights  numPixels]);
    % Compute A and b according the linear system definition
    for i = 1:numLights
        A(i,mask,2) = sum(v .* squeeze(specularDirections(i,mask,:)),2);
        b(i,mask) = imgs(mask,i) - rho_d(mask) .* sum(lights(i, :) .* normals(mask,:),2);
    end
end

