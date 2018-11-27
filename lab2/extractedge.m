function edgecurves = extractedge(inpic, scale, threshold, shape)
%this function combines 
Lv_init = Lv(discgaussfft(inpic, scale), shape);

% Second order derivative of smoothed image
Lvv = Lvvtilde(discgaussfft(inpic, scale), shape);
Lvvv = Lvvvtilde(discgaussfft(inpic, scale), shape);
Lv_mask = (Lv_init > threshold) -0.5;
Lvvv_mask = (Lvvv < 0) - 0.5;

edgecurves = zerocrosscurves(Lvv, Lvvv_mask);
edgecurves = thresholdcurves(edgecurves, Lv_mask);

end
