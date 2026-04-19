function col = blueredbluemap(N,wp)
%BLUEREDBLUEMAP  Cyclic blue-white-red-white-blue colormap centered at zero
%
%   Usage:
%       col = blueredbluemap(N, wp)
%
%   Inputs:
%       N  : integer - number of points per colored segment (default: 1024)
%       wp : double  - fraction of the map occupied by each white band (default: 0.01)
%
%   Outputs:
%       col : Nx3 double - RGB colormap that transitions blue->white->red->white->blue,
%             with the red peak at 0 and blue troughs at +/- pi
%
%   See also: colormap, redbluemap, redblue_equalized, hotcoolmap
%
%   ∿∿∿  Prerau Laboratory MATLAB Codebase · sleepEEG.org  ∿∿∿
%        Source: https://github.com/preraulab/labcode_main


if nargin<1
    N=1024;
end

if nargin<2
    wp=.01;
end


blue_part=[linspace(1,0,N)',linspace(1,0,N)',ones(N,1)];
red_part=[ones(N,1),linspace(0,1,N)',linspace(0,1,N)'];

if wp==0
    wN=1;
else
    wN=round((wp*2*N)/(1-wp));
end
white_part=ones(wN,3);

col=[flip(blue_part); white_part; flip(red_part); red_part; white_part; blue_part];