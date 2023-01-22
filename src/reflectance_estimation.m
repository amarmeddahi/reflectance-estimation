clear;
close all;

% NB: You might need to change the path to the data folder and save foler

% Load images, lights and the binary mask
load('data.mat', 'data')
load('calib.mat', 'calib')
load('mask.mat', 'mask')

% Load all normals, lights and albedo
load('N.mat', 'N')
load('rho.mat', 'rho')
load('S.mat', 'S')

% Light parameters
lightDirections = S;
numLights = size(S,1);

% Image parameters
[r, c, ~] = size(data.I);
imgs = reshape(data.I(:,:,:),[],numLights) ; % Vectorize the images (numPixels x numLights)

% Mask parameters
mask = imresize(mask, [r c]); % Resize the mask to the image size
mask = mask(:); % Vectorize the mask (numPixels x 1)

% Normal parameters
normalVectors = reshape(N, [], 3); % Vectorize the normals (numPixels x 3)
numPixels = size(normalVectors,1);

% Albedo parameters
rho_d = rho(:); % Vectorize the albedo

% Find pixels inside the mask
[in_mask, ~] = find(mask);
in_mask = in_mask';

% View direction
v = [0 0 -1];
vt = v';

% Compute the specular directions 
specularDirections = computeSpecularDir(lightDirections, normalVectors, in_mask);

% Initialize the linear system
[A,b] = initalize_phong_linear_system(numLights, numPixels, specularDirections, lightDirections, normalVectors, v, imgs, rho_d, in_mask);

% Solve the linear system
numLightsCond = 6;
[albedo_spec, coeff_spec, error_pixels, lightsValid] = solve_phong_linear_system(A, b, in_mask, numLights, numLightsCond);

% Compute the error pixels and save them
error_img = zeros([numPixels 1]);
error_img(error_pixels) = 1;
error_img = reshape(error_img, [r c]);
save('error_img.mat', 'error_img');

% Create ground truth images
imgs_ref = zeros(size(imgs));
imgs_ref(in_mask,:) = imgs(in_mask,:);

% Create Lambertian model images
imgs_lamb = lambertian_model(lightDirections, normalVectors, in_mask, rho_d, numPixels, numLights);

% Create Phong model images
imgs_phong = phong_model(lightDirections, normalVectors, specularDirections, lightsValid, in_mask, error_pixels, numLights, numPixels, rho_d, albedo_spec, coeff_spec, vt);

% Compute the MAE and MSE for each images
[mse_lamb, mae_lamb_pixels, mse_phong, mae_phong_pixels] = compute_error_metrics(imgs_lamb, imgs_phong, imgs_ref, numLights, numPixels);

% Save the results
save('albedo_spec.mat', 'albedo_spec');
save('coeff_spec.mat', 'coeff_spec');
save('mse_lamb.mat', 'mse_lamb');
save('mse_phong.mat', 'mse_phong');
save('mae_lamb_pixels.mat', 'mae_lamb_pixels');
save('mae_phong_pixels.mat', 'mae_phong_pixels');

% Reshape and save images
imgs_ref = reshape(imgs_ref, [r c numLights]);
imgs_lamb = reshape(imgs_lamb, [r c numLights]);
imgs_phong = reshape(imgs_phong, [r c numLights]);
save('imgs_ref.mat', 'imgs_ref');
save('imgs_lamb.mat', 'imgs_lamb');
save('imgs_phong.mat', 'imgs_phong');