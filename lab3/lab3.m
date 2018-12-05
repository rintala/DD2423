%LAB 3 - Jonathan Rintala

%% Q.1 Initialization of clustering process - why good method of doing it?
    %Try to modify
        %K - number of cluster centeers
        %L - number of iterations
        %scale_factor - image downscale factor
        %sigma - amount of pre-blurring 

%% Q.3 What's the min value for K, w/o gettign any superpixels that cover
    %parts from both halves of the orange
close all
clear

%---------------------------------------------
K = 8;               %number of clusters used
L = 20;              %number of iterations
seed = 14;           %seed used for random initialization
scale_factor = 0.5;    %image downscale factor
image_sigma = 1.0;   %image preblurring scale
threshold = 0.01;
%---------------------------------------------

i = 1;
I_org = imread('orange.jpg');

I = imresize(I_org, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I_in = imfilter(I, h);

for k=7:8
    subplot(2,3,i)
    imshow(I_org);
    title('Original')

    [segm, centers] = kmeans_segm(I_in, k, L, seed, true, threshold);
    Inew = mean_segments(Iback, segm);
    I = overlay_bounds(Iback, segm);
    
    subplot(2,3,i+1)
    imshow(Inew);
    title(sprintf('Clustered, K = %d', k))
    
    subplot(2,3,i+2)
    imshow(I);
    title('Divided into superpixels - Overlay')
    
    i = i+3;
end

i = 1;

figure
for k=2:3
    subplot(2,3,i)
    imshow(I_org);
    title('Original')

    [segm, centers] = kmeans_segm(I_in, k, L, seed, true, threshold);
    Inew = mean_segments(Iback, segm);
    I = overlay_bounds(Iback, segm);
    
    subplot(2,3,i+1)
    imshow(Inew);
    title(sprintf('Clustered, K = %d', k))
    
    subplot(2,3,i+2)
    imshow(I);
    title('Divided into superpixels - Overlay')
    
    i = i+3;
end