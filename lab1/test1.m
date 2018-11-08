%LAB 1

%------ Q1 ---------------
%p=5;q=9;
%p=9;q=5;
%p=17;q=9;
p=17;q=121;
%p=5;q=1;
%p=125;q=1;
%--------------------------
%fftwave(p,q)

%% Q7 / 1.4 Linearity
%Define F, G, H according to lab instructions
F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
H = F + 2 * G;

%Display F, G, H with showgrey
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
title('ffshifted and log')

%Compute the discrete Fourier transforms of the images
Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);