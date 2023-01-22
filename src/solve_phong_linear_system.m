function [albedo_spec, coeff_spec, error_pixel, lightsValid] = solve_phong_linear_system(A, b, in_mask, numLights, numLightsCond)
%SOLVE_LINEAR_SYSTEM Solve the linear system Ax = b for each pixel in the mask
%
%   [albedo_spec, coeff_spec, error_pixel, lightsValid] = solve_linear_system(A, b, in_mask, numLights, numLightsCond)
%   A: matrix of size mxnxl, where m is the number of light sources, n is the number of pixels and l is the number of values
%   b: matrix of size mxn, where m is the number of light sources and n is the number of pixels
%   in_mask: vector of size nx1, where n is the number of pixels, indicating the pixels to be processed
%   numLights: scalar, the total number of light sources
%   numLightsCond: scalar, the minimum number of valid light sources needed to perform the linear solve
%
%   albedo_spec: vector of size nx1, where n is the number of pixels, containing the albedo of each pixel
%   coeff_spec: vector of size nx1, where n is the number of pixels, containing the coefficient of each pixel
%   error_pixel: vector of size mx1, where m is the number of pixels that do not have enough valid light sources
%   lightsValid: matrix of size nxm, where n is the number of pixels and m is the number of light sources, indicating which light sources are valid for each pixel
%
    numPixels = size(A, 2);
    albedo_spec = zeros([numPixels 1]);
    coeff_spec = zeros([numPixels 1]);
    error_pixel = [];
    lightsValid = zeros([numPixels numLights]);
    eps = 1e-12; % small value to check for negative values
    for i = in_mask
        A_i = squeeze(A(:,i,:));
        b_i = b(:,i);

        % Remove negative values from A_i and b_i
        ok_idx = intersect(find(A_i(:,2) >= eps),find(b_i >= eps));

        % Check if there are enough valid light sources
        if length(ok_idx) > numLightsCond
            lightsValid(i,ok_idx) = 1;

            % Perform log transformation on A_i and b_i
            A_i_filtered = A_i(ok_idx,:);
            A_i_filtered(:,2) = log(A_i_filtered(:,2));
            b_i_filtered = log(b_i(ok_idx));

            % Solve the linear system
            temp = A_i_filtered\b_i_filtered;

            % Store the solution
            albedo_spec(i) = exp(temp(1));
            coeff_spec(i) = temp(2);
        else
            error_pixel = [error_pixel i];
        end
    end
end

