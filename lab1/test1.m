%LAB 1 - Jonathan Rintala

%% Q1 - Q6
%p=5;q=9;
%p=9;q=5;
%p=17;q=9;
p=17;q=121;
%p=5;q=1;
%p=125;q=1;
%--------------------------
fftwave(p,q)

%% Q7 / 1.4 Linearity
%Define F, G, H according to lab instructions
F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
H = F + 2 * G;

%Display F, G, H with showgrey
figure(3);
Fabsmax = max(abs(F(:)));
subplot(4, 2, 1);
showgrey(F);
title('F')
subplot(4, 2, 2);
showgrey(G);
title('G - transpose(F)')
subplot(4, 2, 3);
showgrey(H);
title('H - F+2*G')

%Display Fourier spectra of Fhat, Ghat, Hhat with showgrey
subplot(4, 2, 4);
showgrey(log(1 + abs(Fhat)));
title('Fhat');

subplot(4, 2, 5);
showgrey(log(1 + abs(Ghat)));
title('Ghat');

subplot(4, 2, 6);
showgrey(log(1 + abs(Hhat)));
title('Hhat');

%Commands fftshift and log - why?
subplot(4, 2, 7);
showgrey(log(1 + abs(fftshift(Hhat))));
title('fftshifted and log')

%Compute the discrete Fourier transforms of the images
Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);

%% Q8 Why logarithm?

%Define F, G, H according to lab instructions
F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
H = F + 2 * G;

Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);

%Illustrate with Fhat and log(Fhat)
figure(4);
subplot(2,1,1);
surf(1 + abs(Fhat));
title('Fhat');

subplot(2,1,2);
surf((log(1 + abs(Fhat))));
title('log(Fhat)');

sz = 128;
amplitude = max(abs(Fhat(:)))/sz^2;

%% Q9 - Conclusions regarding linearity
F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
H = F + 2 * G;

Fhat = fft2(F);
Ghat = fft2(G);

%Hhat_1: computing the linear combination before Fourier transform
Hhat_1 = fft2(H);

%Hhat_2: computing the linear combination after Fourier transform 
Hhat_2 = fft2(F) + 2*fft2(G);

%Illustrate with Fhat and log(Fhat)
figure(5);
subplot(2,1,1);

showgrey(log(1 + abs(fftshift(Hhat_1))), 64, -pi, pi);
title('1 + abs(fftshift(Hhat_1))');

subplot(2,1,2);
showgrey(log(1 + abs(fftshift(Hhat_2))), 64, -pi, pi);
title('1 + abs(fftshift(Hhat_2))');

%% Q10 - Convolution in Fourier domain <=> multiplication in spatial
F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
sz = 128;

%1. Looking at multiplication
figure(6);
subplot(2,2,1);
showgrey(F.*G);
title('(F .* G)')

subplot(2,2,2)
%showfs( FREQSPEC, RES, FOURSPECMAX) displays a compressed version
%of the corresponding Fourier spectrum as a gray-level image.
showfs(fft2(F.*G));
title('fft2(F.*G)');

%2. Looking at convolution
Fhat = fft2(F);
Ghat = fft2(G);

%non-normalized
subplot(2,2,3);
showfs(conv2(Fhat,Ghat));
title('conv2(Fhat,Ghat)');

%normalized
the_conv = conv2(Fhat, Ghat)/sz.^2;
the_conv = the_conv(1:sz, 1:sz);
subplot(2,2,4)
showfs(the_conv);
title('conv2(Fhat,Ghat)*1/sz.^2)');
