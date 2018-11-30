function [linepar, acc] = houghedgeline(img, scale, gradmagnthresh, nrho, ntheta, nlines, verbose)
curves = extractedge(img, scale, gradmagnthresh, 'same')
magnitude = Lv(img, 'same')

if verbose == 1
    figure('overlay curves: img + edge segments')
    overlaycurves(img, curves);
    
    figure('grad magnitude')
    overlaycurves(magnitude, curves);
end

[linepar, acc] = houghline(curves, magnitude, nrho, ntheta, gradmagnthresh, nlines, verbose);


D = sqrt(size(magnitude, 1).^2 + size(magnitude, 2).^2);
                        

if verbose == 0
    figure
    subplot(1,2,2)
    overlaycurves(img, linepar);
    axis([1 size(img, 2) 1 size(img, 1)]);                        
    title('Image')

    subplot(1,2,1)
    showgrey(binsepsmoothiter(acc, 0.5, 1))
    title('Hough transform, smoothed')
end

if verbose == 1
    figure
    subplot(1,2,1)
    overlaycurves(img, curves)
    title('Overlay curves: Img and curves')
    subplot(1,2,2)
    showgrey(magnitude)
    title('Magnitude')
end

if verbose == 2
    figure
    subplot(1,2,1)
    showgrey(acc)
    title('Acc')
    subplot(1,2,2)
    showgrey(binsepsmoothiter(acc, 0.5, 1));
    title('Acc with binseopsmoothiter')
end

if verbose == 3
    figure
    subplot(1,2,2)
    overlaycurves(img, linepar);
    axis([1 size(img, 2) 1 size(img, 1)]);                        
    title('Image')

    subplot(1,2,1)
    surf(binsepsmoothiter(acc, 0.5, 1))
    title('Hough transform, smoothed')
end

