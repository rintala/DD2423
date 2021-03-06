%LAB 1 - Jonathan Rintala

%% Q1 - Q6
close
clear all
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
close
clear all

F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
H = F + 2 * G;

%Compute the discrete Fourier transforms of the images
Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);

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
subplot(2,2,1);

showgrey(1 + abs(fftshift(Hhat_1)));
title('1 + abs(fftshift(Hhat_1))');
subplot(2,2,2)
showgrey(log(1 + abs(fftshift(Hhat_1))));
title('log(1 + abs(fftshift(Hhat_1)))');

subplot(2,2,3);
showgrey(1 + abs(fftshift(Hhat_2)));
title('1 + abs(fftshift(Hhat_2))');
subplot(2,2,4);
showgrey(log(1 + abs(fftshift(Hhat_2))));
title('log(1 + abs(fftshift(Hhat_2)))');

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
%surf(1+abs(fftshift(fft2(F.*G))));
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

%% Q.10.1 Illustration of point-wise multiplication F.*G
F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';

figure(7);

%F and G
subplot(1,3,1); showgrey(F); title('F')
subplot(1,3,2); showgrey(G); title('G');

%Point-wise multiplication result
subplot(1,3,3); showgrey(F.*G); title('(F .* G)')

%% Q.10.2 Illustration of Fhat and Ghat convolution in Fourier domain
F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)]; G = F';

figure(8);

%Fourier transform
Fhat = fft2(F);
Ghat = fft2(G);
subplot(1,3,1);
showfs(Fhat);
title('Fhat')
subplot(1,3,2);
showfs(Ghat);
title('Ghat')

%Convolution - normalized
the_conv = conv2(Fhat, Ghat)/sz.^2;
the_conv = the_conv(1:sz, 1:sz);
subplot(1,3,3)
showfs(the_conv);
title('conv2(Fhat,Ghat) - normalized');

%% Q11 - reformulate abit

%F_new given in lab instructions
F_new = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
       [zeros(128, 48) ones(128, 32) zeros(128, 48)];

F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';

%look at spatial domain
figure(9);
subplot(2,2,1)
showgrey(F .* G);
title('Spatial: F_{old} multiplication')

subplot(2,2,2)
showgrey(F_new)
title('Spatial: F_{new} multiplication')

%look at magnitude
subplot(2,2,3)
showfs(fft2(F .* G));
title('Fourier: F_{old} multiplication')

subplot(2,2,4)
showfs(fft2(F_new));
title('Fourier: F_{new} multiplication')

%% Q.12 - Rotation, varying angles look at original image and Fourier spectra, compare
clear
close all

F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
    [zeros(128, 48) ones(128, 32) zeros(128, 48)];

alphas = [0, 30, 45, 60, 90];


for a = 1 : length(alphas)
    figure
    
    %Display rotated image in spatial domain
    subplot(1,3,1)
    F_rotated = rot(F, alphas(a));
    showgrey(F_rotated);
    title(['Spatial - alpha =' num2str(alphas(a))]);
    
    %Display discrete Fourier transform of rotated image
    subplot(1,3,2)
    Fhat_rotated = fft2(F_rotated);
    showfs(Fhat_rotated);
    title(['Fourier - alpha =' num2str(alphas(a))]);
    
    %Display the Fourier spectra rotated back in the Fourier domain
    subplot(1,3,3)
    Fhat_rotated_back = rot(fftshift(Fhat_rotated), -alphas(a));
    Fhat_rotated_back_show = log(1 + abs(Fhat_rotated_back));
    showgrey(Fhat_rotated_back_show);
    title(['Rotated back - alpha =' num2str(alphas(a))]);
end;

%% Q.13 - look at info in phase vs. magnitude of Fourier transf
a = 10^-10;

pics = cell(1,3);   
pics{1} = few128;
pics{2} = nallo128;
pics{3} = phonecalc128;


for i = 1 : size(pics,2)
    figure
    subplot(1,3,1)
    showgrey(pics{i})
    title(['Pic ' num2str(i) ' - original']);
    
    subplot(1,3,2)
    showgrey(pow2image(pics{i},a))
    title(['Pic ' num2str(i) ' - pow2image']);
    
    subplot(1,3,3)
    showgrey(randphaseimage(pics{i}))
    title(['Pic ' num2str(i) ' - randphaseimage']);
    
end;

%% 2. GAUSSIAN CONVOLUTION IMPLEMENTED VIA FFT

%%2.3 Filtering procedure
%% Q.14 - show the impulse response and variance

%deltafcn(xsize, ysize) -- generates a discrete delta function of
%support xsize*ysize, in which the central pixel is set to one and 
%all other pixel values are set to zero.
clear
close all

t_values = [0.1, 0.3, 1.0, 10.0, 100.0];
our_pic = deltafcn(128, 128);

figure

surf(our_pic)

figure
for i = 1 : length(t_values)
    subplot(3,2,i)
    psf = gaussfft(our_pic, t_values(i));
    
    %use if plotting freq domain
    %psf = fftshift(psf);
    surf(psf)
    title(['t = ' num2str(t_values(i))])
    colormap winter;
end;

figure
for i = 1 : length(t_values)
    subplot(3,2,i)
    psf = gaussfft(our_pic, t_values(i));
    showgrey(psf)
    
    %note to self: showfs shifts automatically
    %showfs(psf);
    title(['t = ' num2str(t_values(i))])
end;

%% Q.15 Variance analysis
clear
close all

t_values = [0.1, 0.3, 1.0, 10.0, 100.0];
our_pic = deltafcn(128, 128);

for i = 1 : length(t_values)
    subplot(3,2,i)
    psf = gaussfft(our_pic, t_values(i));
    
    %variance evaluation - compare with "correct"
    our_variance = variance(psf)
    correct_val_disc = discgaussfft(our_pic, t_values(i));
    correct_cont_variance = t_values(i).*eye(2)
    correct_disc_variance = variance(correct_val_disc);
    diff_disc{i} = abs(correct_disc_variance - our_variance)
    diff_cont{i} = abs(correct_cont_variance - our_variance)
end;

%% Q.16 Convolve images w Guassian functions of different variances
close
clear all

pics = cell(1,3);   
pics{1} = few128;
pics{2} = nallo128;
pics{3} = phonecalc128;

figure
for i = 1 : size(pics,2)
    subplot(1,3,i);
    showgrey(pics{i})
    title(['Img ' num2str(i) ' original']);
end;

t_values = [1.0, 4.0, 16.0, 64.0, 256.0];

%for each image - plot all different convs (w. different variances t)
for i = 1 : size(pics,2)
    figure
    for t = 1 : length(t_values)
        subplot(2,3,t);
        psf = gaussfft(pics{i}, t_values(t));
        showgrey(psf)
        title(['Img ' num2str(i) ' with t=' num2str(t_values(t))]);
    end;
end;

%% Q.17 Positive and negative effects for each type of filter
clear
close all

%Load the image office256 from the image database of the course
office = office256;

%gaussian noise
add = gaussnoise(office, 16);

%salt and pepper noise
sap = sapnoise(office, 0.1, 255);

figure
subplot(2,2,1);
showgrey(add);
title('org: add - gaussnoise')

subplot(2,2,2);
showgrey(sap);
title('org: sap - sapnoise')

t_values = [0.1, 0.3, 1.0, 10.0, 100.0];

%----- 1. Gaussian smoothing --------------

%1.1 On gaussnoise
figure
for i = 1 : length(t_values)
    subplot(3,2,i)
    psf = gaussfft(add, t_values(i));
    showgrey(psf)
    title(['Gaussian - gaussnoise: t = ' num2str(t_values(i))])
end;

%1.2 On sapnoise
figure
for i = 1 : length(t_values)
    subplot(3,2,i)
    psf = gaussfft(sap, t_values(i));
    showgrey(psf)
    title(['Gaussian - sapnoise: t = ' num2str(t_values(i))])
end;
%------------------------------------------

%----------- 2. Median filter -----------------
w_sizes = [4, 8, 10];
%2.1 On gaussnoise
figure
for i = 1 : length(w_sizes)
    subplot(2,3,i)
    filtered_img = medfilt(add, w_sizes(i), w_sizes(i));
    showgrey(filtered_img)
    title(['Median filter - gaussnoise: w_{size} = ' num2str(w_sizes(i))])
end;

%2.2 On sapnoise
for i = 1 : length(w_sizes)
    subplot(2,3,i+length(w_sizes))
    filtered_img = medfilt(sap, w_sizes(i), w_sizes(i));
    showgrey(filtered_img)
    title(['Median filter - sapnoise: w_{size} = ' num2str(w_sizes(i))])
end;

%----------- 3. Ideal filter -----------------
cutoff_freqs = [0.3, 0.2, 0.1];

%3.1 On gaussnoise
figure
for i = 1 : length(cutoff_freqs)
    subplot(2,3,i)
    filtered_img = ideal (add, cutoff_freqs(i));
    showgrey(filtered_img)
    title(['Ideal filter - gaussnoise: cutoff_{freq} = ' num2str(cutoff_freqs(i))])
end;

%3.2 On sapnoise
%figure
for i = 1 : length(cutoff_freqs)
    subplot(2,3,i+length(cutoff_freqs))
    filtered_img = ideal(sap, cutoff_freqs(i));
    showgrey(filtered_img)
    title(['Ideal filter - sapnoise: cutoff_{freq} = ' num2str(cutoff_freqs(i))])
end;

%% Q.19 Effects when subsampling the org image and the smoothed variants
%Q.20 Effects of smoothing when combined with subsampling

%Using provided template
img = phonecalc256;
smooth_img = img;
smooth_img_ideal = img;

N=5;
for i = 1:N
    if i>1 %generate subsampled versions
        %rawsubsample -- reduce image size by raw subsampling without presmoothing
        
            %rawsubsample(image) reduces the size of an image by a factor of two in
            %each dimension by raw subsampling, i.e., by picking out every second
            %pixel along each dimension.
        
        img = rawsubsample(img);
        smooth_img = gaussfft(smooth_img, 1.1);
        smooth_img = rawsubsample(smooth_img);
        
        smooth_img_ideal = ideal(smooth_img_ideal, 0.15);
        smooth_img_ideal = rawsubsample(smooth_img_ideal);
    end;
    
    subplot(3, N, i)
    showgrey(img)
    title('Original img');
    
    subplot(3, N, i+N)
    showgrey(smooth_img)
    title('Smooth img - guassian filter');
    
    subplot(3, N, i+2*N)
    showgrey(smooth_img_ideal)
    title('Smooth img - ideal filter');
end;

%% test
F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
    [zeros(128, 48) ones(128, 1) zeros(128, 79)];

G = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
    [zeros(128, 48) ones(128, 4) zeros(128, 76)];

H = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
    [zeros(128, 48) ones(128, 8) zeros(128, 72)];

figure
subplot(2,1,1);
showgrey(F)
title('F')

subplot(2,1,2);

surf((1+abs(fftshift(fft2(F)))));
title('Fhat')

figure
subplot(2,1,1);
showgrey(G)
title('G')

subplot(2,1,2);

showgrey((1+abs(fftshift(fft2(G)))));
title('Ghat')