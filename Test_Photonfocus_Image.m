%% A Script to apply demosaicing to photonfocus SSI image
% Author: Kinan ABBAS
% Creation Date: 4 July 2023



% Cleaning and loading everthing to the path
close all;
clear;

addpath(pwd);
cd Data/
addpath(genpath(pwd));
cd ..;

cd Functions/
addpath(genpath(pwd));
cd ..;

cd Methods/
addpath(genpath(pwd));
cd ..;


%% Load the SSI image
sz=[1000,2000];
num_band=25;
try
    [baseFileName, folder] = uigetfile({'*.bmp';'*.png';'*.jpg';'*.JPG';'*.bmp';'*.tif'},'Pick up an image');
    try
        fullFileName = fullfile(folder, baseFileName);
    catch
        fullFileName='Data/MV0-D2048x1088-C01-HS02-160-G2_image_115649_000.bmp';
    end
    
catch
    fullFileName='Data/MV0-D2048x1088-C01-HS02-160-G2_image_115649_000.bmp';
end
cdata=imread(fullFileName);


% Show the image
figure; imagesc(cdata);title('The SSI image'); colorbar;

% Convert image to double
I=double(cdata(1:1000,1:2000))/255;

%% Super-pixel down-sampling
Super_Pixel_Cube=X2Cube(I,5,25);
figure;
subplot(1,2,1); imagesc(Super_Pixel_Cube(:,:,1));title('Band 1');
subplot(1,2,2); imagesc(Super_Pixel_Cube(:,:,2)); title('Band 2');

%% Demosaicing using WB
% Call the demosaicing function with WB method
I_HS_WB= Run_Demosaicing(I(:,:,1),16,1);

% Show the first two bands of the restored datacube
figure;
subplot(1,2,1); imagesc(I_HS_WB(:,:,1));title('Band 1');
subplot(1,2,2); imagesc(I_HS_WB(:,:,2)); title('Band 2');


