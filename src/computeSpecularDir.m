function specularDirections = computeSpecularDir(lights, normals, mask)
    % Compute the specular directions for each light
    %
    % Parameters:
    %   lights (nx3 array) : n lights directions in 3D space
    %   normals (mx3 array) : m normal vectors in 3D space
    %   mask (mx1 boolean array) : mask indicating which pixels to compute specular directions for
    %
    % Returns:
    %   specularDirections (nxmxd array) : matrix containing the specular directions for each light, for each pixel specified by the mask
    
    % Initialize a matrix to store the specular directions 
    specularDirections = zeros([size(lights,1) size(normals,1) 3]);
    % Iterate through each light
    for i = 1:size(lights,1)
       % Compute the specular direction for each light and store it in the corresponding location in the matrix
       specularDirections(i,mask,:) = 2 * sum(lights(i, :) .* normals(mask,:),2) .* normals(mask,:) -  lights(i, :);
    end
end


