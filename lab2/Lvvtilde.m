function pixels = Lvvtilde(inpic, shape)
%define our mask - 5x5
%first order
dxmask = [0 0 0 0 0;
          0 0 0 0 0;
          0 -1/2 0 1/2 0;
          0 0 0 0 0;
          0 0 0 0 0];

dymask = dxmask';

%second order
dxxmask = [0 0 0 0 0;
            0 0 0 0 0;
            0 1 -2 1 0;
            0 0 0 0 0;
            0 0 0 0 0];
dyymask = dxxmask';

%concatenating two masks, by convolution, i.e. filtering operation
dxymask = conv2(dxmask, dymask, shape);

%Smoothened intensity function L (we get it by convolution)
%get all partial derivatives
Lx = filter2(dxmask, inpic, shape);
Ly = filter2(dymask, inpic, shape);
Lxx = filter2(dxxmask, inpic, shape);
Lxy = filter2(dxymask, inpic, shape);
Lyy = filter2(dyymask, inpic, shape);

%Then we, finally, define our output (approx of gradient magnitude of img)
pixels = Lx.^2.*Lxx + 2*Lx.*Lxy.*Ly + Ly.^2.*Lyy;

end
