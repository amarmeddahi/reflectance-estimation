clear;
close all;

% Display error pixels mask
load('error_img.mat', 'error_img');
figure;
imshow(error_img);

% Load the MSE
load('mse_lamb.mat', 'mse_lamb');
load('mse_phong.mat', 'mse_phong');

% Display the MSE as a bar plot for each light on the same plot to compare
figure;
bar([mse_lamb mse_phong]);
legend('Lambertian', 'Phong');
title('MSE for each light');

% Load the images and their errors
load('imgs_ref.mat', 'imgs_ref');
load('imgs_lamb.mat', 'imgs_lamb');
load('imgs_phong.mat', 'imgs_phong');

% Display all the images and their mae as a heatmap below
[r, c, numLights] = size(imgs_ref);
for i = 1:numLights
    subplot(1,3,1);
    imshow(imgs_ref(:,:,i));
    title('Ground truth');
    subplot(1,3,2);
    imshow(imgs_lamb(:,:,i));
    title('Lambertian');
    subplot(1,3,3);
    imshow(imgs_phong(:,:,i));
    title('Phong');
    % If character is pressed, go to next image
    waitforbuttonpress;
end

% Display the MAE for each light as a color heatmap
load('mae_lamb_pixels.mat', 'mae_lamb_pixels');
load('mae_phong_pixels.mat', 'mae_phong_pixels');

for i = 1:numLights
    subplot(1,2,1);
    data = reshape(mae_lamb_pixels(i,:), r, c);
    data(1,1) = 1; % Set the first pixel to 1 to put the same scale for the two images
    data(data >= 1) = 1; % Set outliers to 1 to avoid having a too bright color
    imagesc(data);
    colormap("hot"); % change the color map
    colorbar; % show the colorbar
    title('Lambertian');
    subplot(1,2,2);
    data = reshape(mae_phong_pixels(i,:), r, c);
    data(1,1) = 1;
    data(data >= 1) = 1;
    imagesc(data);
    colormap("hot"); % change the color map
    colorbar; % show the colorbar
    title('Phong');
    % If character is pressed, go to next image
    waitforbuttonpress;
end