function pixels = Lvvvtilde(inpic, shape)
%complete - todo

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

%NEW: third order
dxxxmask = conv2(dxmask, dxxmask, shape);
dxyymask = conv2(dxmask, dyymask, shape);
dxxymask = conv2(dxxmask, dymask, shape);
dyyymask = conv2(dymask, dyymask, shape);

%Smoothened intensity function L (we get it by convolution)
%get all partial derivatives
Lx = filter2(dxmask, inpic, shape);
Ly = filter2(dymask, inpic, shape);
Lxx = filter2(dxxmask, inpic, shape);
Lxy = filter2(dxymask, inpic, shape);
Lyy = filter2(dyymask, inpic, shape);

%NEW: third order
Lxxx = filter2(dxxxmask, inpic, shape);
Lxyy = filter2(dxyymask, inpic, shape);
Lxxy = filter2(dxxymask, inpic, shape);
Lyyy = filter2(dyyymask, inpic, shape);

%Then we, finally, define our output (approx of gradient magnitude of img)
%according to expression of \tilde L on page 3 (lab description)
pixels = Lx.^3.*Lxxx + 3.*Lx.^2.*Ly.*Lxxy + 3.*Lx.*Ly.^2.*Lxyy + Ly.^3.*Lyyy;

end