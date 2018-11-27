%LAB 2 - Jonathan Rintala

%% Q1 - Compare size of dxtools and tools
close
clear all

deltax = [1 0 -1; 2 0 -2; 1 0 -1];
deltay = deltax';

%Load function based image from course lib
tools = few256;

%Compute the discrete derivation approximations
dxtools = conv2(tools, deltax, 'valid');
dytools = conv2(tools, deltay, 'valid');

figure
%surf(dxtools)
showgrey(dxtools)
title('deltax - tools')

figure
%surf(dytools)
showgrey(dytools)
title('deltay - tools')

%Compare size of tools and dxtools
size_tools = size(tools)
size_dxtools = size(dxtools)

%% Q2 - Is it easy to find a threshold that results in thin edges?
clear
close all

deltax = [1 0 -1; 2 0 -2; 1 0 -1];
deltay = deltax';

%Load function based image from course lib
tools = few256;
figure
surf(tools)
%Compute the discrete derivation approximations
dxtools = conv2(tools, deltax, 'valid');
dytools = conv2(tools, deltay, 'valid');

gradmagntools = sqrt(dxtools .^2 + dytools .^2);

thresholds = [20, 40, 60, 80, 100, 120];

%Plot approx. of the gradient magnitude, subtract threshold
%Img: few256
figure
for t = 1 : length(thresholds)
    subplot(2,4,t)
    showgrey((gradmagntools - thresholds(t)) > 0)
    title(['threshold (' num2str(thresholds(t)) ')'])
end;

figure
histgradmagn = histogram(gradmagntools);
title('img few256')
xlabel('intensities')
ylabel('count')

%Img: godthem256 - Contains image structures of higher complexity
godthem = godthem256;
pixel = Lv(godthem, 'valid');

figure
for t = 1 : length(thresholds)
    subplot(2,4,t)
    showgrey((pixel - thresholds(t)) > 0)
    title(['threshold (' num2str(thresholds(t)) ')'])
end;

figure
histgradmagn = histogram(pixel);
title('img godthem256')
xlabel('intensities')
ylabel('count')

%% Q3 - Does smoothing help in finding edges
%Idea: Deploy smoothing through discgaussfft - then find edges
godthem = godthem256;

%apply smoothing (gaussian blur) with specified variance (sigma)
smooth_godthem = discgaussfft(godthem, 7)
pixel = Lv(godthem, 'valid');
pixel_smooth = Lv(smooth_godthem, 'valid');
figure
showgrey(smooth_godthem)
figure
showgrey(godthem)


thresholds = [2, 6, 8, 12, 16, 20, 30, 40];
%thresholds = [3, 6, 9, 13, 16, 21];

%SMOOTHENED IMAGE
figure
for t = 1 : length(thresholds)
    subplot(2,4,t)
    showgrey((pixel_smooth - thresholds(t)) > 0)
    title(['smooth threshold (' num2str(thresholds(t)) ')'])
end;

%ORIGINAL IMAGE
figure
for t = 1 : length(thresholds)
    subplot(2,4,t)
    showgrey((pixel - thresholds(t)) > 0)
    title(['org threshold (' num2str(thresholds(t)) ')'])
end;

%% Q4 - What can you observe - zero crossing of Lvv, varying scale

%-------EXPERIMENTS--------
house = godthem256;
%initializing the sigma values (scale) we want to test
scale = [0.0001, 1.0, 4.0, 16.0, 64.0];

figure
subplot(2,3,1)
showgrey(house)
title('org image')
for s = 1 : length(scale)
    subplot(2,3,s+1)
    contour(Lvvtilde(discgaussfft(house,scale(s)), 'same'), [0,0])
    axis('image')
    axis('ij')
    title(['Lvv scale (' num2str(scale(s)) ')'])
end;

%% Q5 - Assemble results
%STUDY SIGN OF THIRD ORDER DERIVATIVE IN GRADIENT DIRECTION
%What can you observe? Effect of sign condition in this differential expr?
scale = [0.0001, 1.0, 4.0, 16.0, 64.0];
tools = few256;

%plot results
figure
subplot(2,3,1)
showgrey(tools)
title('org image')
for s = 1 : length(scale)
    subplot(2,3,s+1)
    %try discgaussfft using different scales (sigmas)
    convolved_gauss_image = discgaussfft(tools,scale(s));
    showgrey(Lvvvtilde(convolved_gauss_image, 'same') < 0)
    axis('image')
    axis('ij')
    title(['Lvvv scale (' num2str(scale(s)) ')'])
end;

%% Q7 - Present best results obtained with extractedge for house & tools

thresholds = [2, 4, 8, 10, 12];
scale = 4;

%1.house
house = godthem256;
shape = 'same';
figure
subplot(2,3,1)
showgrey(house)
title('org image')

for t = 1 : length(thresholds)
    subplot(2,3,t+1)  
    extractededge = extractedge(house, scale, thresholds(t), shape);
    overlaycurves(house, extractededge)
    title(['Lvvv thresholds (' num2str(thresholds(t)) '), scale ' num2str(scale)]) 
end;

%2 tools
tools = few256;
shape = 'same';
figure
subplot(2,3,1)
showgrey(tools)
title('org image')
for t = 1 : length(thresholds)
    subplot(2,3,t+1)  
    extractededge = extractedge(tools, scale, thresholds(t), shape);
    overlaycurves(tools, extractededge)
    title(['Lvvv thresholds (' num2str(thresholds(t)) '), scale ' num2str(scale)']) 
end;

