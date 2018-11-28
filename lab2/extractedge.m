function edgecurves = extractedge(inpic, scale, threshold, shape)

%This function combines the 2nd and 3rd order derivatives
Lv_init = Lv(discgaussfft(inpic, scale), shape);

%Second order derivative of smoothed image
Lvv = Lvvtilde(discgaussfft(inpic, scale), shape);

%Third order derivative of smoothed image
Lvvv = Lvvvtilde(discgaussfft(inpic, scale), shape);

%Masks
Lv_mask = (Lv_init > threshold) -0.5;
Lvvv_mask = (Lvvv < 0) - 0.5;

%Look at when crossing zero
edgecurves = zerocrosscurves(Lvv, Lvvv_mask);
edgecurves = thresholdcurves(edgecurves, Lv_mask);

end
