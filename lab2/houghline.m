function [linepar, acc] = houghline(curves, scale, nrho, ntheta, threshold, nlines, verbose)

%Allocate accumulator space - from number of rhos and number of thetas
%eq to dimension of image
acc = zeros(nrho, ntheta);

%Define coordinate system: accumulator space
thetax = linspace(-pi/2, pi/2, ntheta);
D = sqrt(size(scale, 1).^2 + size(scale, 2).^2)

%Get the maxlen of the img
rhoy = linspace(-D, D, nrho);

%Loop over all the input curves - Amount of pixels lying on a curve
insize = size(curves, 2) 
ttrypointer = 1; 

%For all points, that are on the curves - loop over them
while ttrypointer < insize
    polylength = curves(2, ttrypointer); %Look at each x-value of curve
    ttrypointer = ttrypointer + 1;
    
    %Loop through the points on the edge curve - i.e. not ALL pixels
    for curveidx = 1:polylength 
        x = curves(2, ttrypointer);
        y = curves(1, ttrypointer);
        ttrypointer = ttrypointer + 1;
            
        %Look at tresh - ensure point is above
        magn_xy = abs(scale(round(x), round(y)));
        if magn_xy > threshold
           
            %Loop over a set of theta vals - rotate around point
            for theta_index = 1:ntheta
                %Determine rho, do it for each theta value - rho that is closest to
                rho_val = x*cos(thetax(theta_index)) + y*sin(thetax(theta_index));
                
                %Compute index values in the accumulator space
                rho_index = find(rhoy < rho_val, 1, 'last');
                
                %Upd the accumulator matrix - with the vote
                acc(rho_index, theta_index) = acc(rho_index, theta_index) + 1;
                
                % For Q.10
                %acc(rho_index, theta_index) = acc(rho_index, theta_index) + log(magn);
                %acc(rho_index, theta_index) = acc(rho_index, theta_index) + (magn).^3;
                %acc(rho_index, theta_index) = acc(rho_index, theta_index) + magn;
            end
        end
    end
end



%Get maxima (local) from the accumulator matrix
acctmp = acc;
[pos value] = locmax8(acctmp);
[dummy indexvector] = sort(value);
nmaxima = size(value, 1);

%--------------- Getting maximum points (whitest) from accumulator
%line for each one of the strongest resp
nlines
for index = 1:nlines
    rhoindexacc = pos(indexvector(nmaxima - index + 1), 1);
    thetaindexacc = pos(indexvector(nmaxima - index + 1), 2);
    rho = rhoy(rhoindexacc);
    theta = thetax(thetaindexacc);
    linepar(:,index) = [rho; theta];
    
    x0 = 0;
    y0 = (rho - x0 * cos(theta))./sin(theta);
    dx = D.^2;
    dy = (rho - dx * cos(theta))./sin(theta);
  
    %Given in lab description - visualizing results
    outcurves(1, 4*(index-1) + 1) = 0;          
    outcurves(2, 4*(index-1) + 1) = 3;
    outcurves(2, 4*(index-1) + 2) = x0 - dx;
    outcurves(1, 4*(index-1) + 2) = y0 - dy;
    outcurves(2, 4*(index-1) + 3) = x0;
    outcurves(1, 4*(index-1) + 3) = y0;
    outcurves(2, 4*(index-1) + 4) = x0+dx;
    outcurves(1, 4*(index-1) + 4) = y0+dy;
end

%Return the output data
linepar = outcurves;

end