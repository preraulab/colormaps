function map = redbluemap(N_raw, white_prct)
%REDBLUEMAP  Divergent red-white-blue colormap centered at zero
%
%   Usage:
%       map = redbluemap(N, white_prct)
%
%   Inputs:
%       N          : integer - number of points in the output colormap (default: 1024)
%       white_prct : double  - fraction of the map occupied by the white
%                              center band (default: 0.01)
%
%   Outputs:
%       map : Nx3 double - RGB colormap running red -> white -> blue
%
%   Example:
%       figure
%       imagesc(randn(1000));
%       colormap(redbluemap);
%       caxis([-3 3]);  % set +/- caxes equal to center on zero
%
%   See also: colormap, redblue_equalized, blueredbluemap, hotcoolmap
%
%   ∿∿∿  Prerau Laboratory MATLAB Codebase · sleepEEG.org  ∿∿∿
%        Source: https://github.com/preraulab/labcode_main

%Set default N
if nargin<1
    N_raw=1024;
end

%Set default percentage of white
if nargin<2
    white_prct=.01;
end

blue_part=[linspace(1,0,N_raw)',linspace(1,0,N_raw)',ones(N_raw,1)];
red_part=[ones(N_raw,1),linspace(0,1,N_raw)',linspace(0,1,N_raw)'];

%Create the white component
if white_prct==0
    num_white=1;
else
    num_white=round((white_prct*2*N_raw)/(1-white_prct));
end
white_part=ones(num_white,3);

%Create the full colormap
map_raw=[red_part; white_part; blue_part];
Nr = size(map_raw,1);

%Interpolate to correct size
map(:,1) = interp1(linspace(0,1,Nr), map_raw(:,1), linspace(0,1,N_raw));
map(:,2) = interp1(linspace(0,1,Nr), map_raw(:,2), linspace(0,1,N_raw));
map(:,3) = interp1(linspace(0,1,Nr), map_raw(:,3), linspace(0,1,N_raw));
