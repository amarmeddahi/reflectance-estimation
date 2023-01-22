clear;
close all;

% Parameters
scale = 1; % Resize the images to scale% of the original size
imgs_path = ''; % Path to the folder containing ONLY the images
extension = ''; % Extension of the images (ex. '*.jpg')
lights_path = ''; % Path to the file containing the light directions (one per line in the format 'x y z')
index_first_token = 1; % Index of the first token in the line (ex. 1 for 'x y z' or 2 for 'path x y z')
delimiter = ' '; % Delimiter used to split the line into tokens (ex. ' ' for 'x y z' or '/' for 'path/x/y/z')

% Get the list of image files
imageFiles = dir(strcat(imgs_path,extension));
numFiles = length(imageFiles);

% Initialize the datastructure to hold the data (numCols x numRows x numImgs)
[row, col, ~] = size(imresize(imread(strcat(imgs_path,imageFiles(1).name)), scale));
data.I = zeros(row, col, numFiles); % Replace 'row' and 'col' with the desired size for the images

% Open the file containing the light directions
fid = fopen(lights_path, 'r');

% Initialize the datastructure to hold the light directions (numImgs x 3)
calib.S = zeros(numFiles, 3); % traditional CV coordinate system

% Read the file line by line
for i = 1:numFiles
    % Read the image
    image = imread(strcat(imgs_path,imageFiles(i).name));

    % Convert the image to grayscale and double precision
    image = im2double(rgb2gray(image));

    % Resize the image
    image = imresize(image, scale);

    % Store the image in the matrix
    data.I(:,:,i) = image;

    % Read the line
    line = fgetl(fid);
    
    % Split the line into tokens using the space character as the delimiter
    tokens = strsplit(line, delimiter);
    
    % Store the data in the matrix (traditional CV coordinate system)
    calib.S(i,:) = [str2double(tokens{index_first_token}); -str2double(tokens{index_first_token + 1}); -str2double(tokens{index_first_token + 2})];
end

% Close the file
fclose(fid);

% Save the data
save('data.mat', 'data');
save('calib.mat', 'calib');