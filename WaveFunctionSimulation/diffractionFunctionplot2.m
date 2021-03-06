function p1 = diffractionFunctionplot2(wavelength, slitx,pxrange, Y)

%clc
%clearvars -except wavelength slitx vali valj

% wavelength = 2
% slitx = 5

divide = 256;  %set the Resolution of graph
slitdivide = 512;%10^11; %set the Resolution of Numerical Integration
angledivide = 512;

A = 1;
k = 2*pi/wavelength;

wavefunc = @(r,t) A*cos(k*r+t)./r;
EucDM = @(r1x, r1y, r2x, r2y) sqrt( (r1x - r2x).^2 + (r1y - r2y).^2 ) ;


pxrange = pxrange*[-1,1];

pxrange = linspace(pxrange(1),pxrange(2),divide);

integraldivide = slitdivide;  %slitx*slitdivide; %slit divide

slit = [-1,1]*slitx/2;
slitrange = linspace(slit(1), slit(2), integraldivide);



angle = linspace(0,2*pi,angledivide);

%values = [];%zeros([size(xrange,2) size(slitrange,2) size(angle,2)]);

[Xrange, S, Ag] = ndgrid(pxrange,  slitrange, angle);

clearvars -except wavefunc EucDM Xrange xrange Y S Ag wavelength slitx divide slitdivide angledivide integraldivide pxrange

values = wavefunc( EucDM(Xrange, Y, S ,0) , Ag);

% figure
% 
% surf(values)
% 
% shading interp
% 
% view(-90,90)

values = abs((sum(values,2)/integraldivide));

values = (sum(values,3)/angledivide).^2;

p1 = plot( pxrange ,values);




pt1 = ['Wavelength : ', num2str(wavelength),'    Slit Size : ',  num2str(slitx)];
pt2 = ['RangeDivide: ', num2str(divide),'     SlitDivide : ',num2str(slitdivide),'     AngleDivide : ',num2str(angledivide)];
title({pt1; pt2});

end