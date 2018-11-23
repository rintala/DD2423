%LAB 2 - Jonathan Rintala

%% Q1 - Compare size of dxtools and tools

deltax = [1 0 -1; 2 0 -2; 1 0 -1];
deltay = deltax';

%Load function basd image from course lib
tools = few256;

%Compute the discrete derivation approximations
dxtools = conv2(tools, deltax, 'valid');
dytools = conv2(tools, deltay, 'valid');

figure
surf(dxtools)
title('deltax - tools')

figure
surf(dytools)
title('deltay - tools')

%Compare size of tools and dxtools
size_tools = size(tools)
size_dxtools = size(dxtools)
