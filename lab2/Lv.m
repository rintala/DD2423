function pixels = Lv(inpic, shape)
%pixels function
if(nargin<2)
    shape = 'same';
end;

%Defining our masks 
dymask = fspecial('sobel');
dxmask = dymask';

Lx = filter2(dxmask, inpic, shape);
Ly = filter2(dymask, inpic, shape);

pixels = sqrt(Lx.^2 + Ly.^2);
end