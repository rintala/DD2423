%LAB 2 - Jonathan Rintala

%% Q1 - Compare size of dxtools and tools

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

%SMOOTHED IMAGE
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
