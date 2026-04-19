function map = redblue_equalized(N_raw, min_L, white_prct)
%REDBLUE_EQUALIZED  Red-white-blue divergent colormap with equalized CIELAB lightness
%
%   Usage:
%       map = redblue_equalized(N, min_L, white_prct)
%
%   Inputs:
%       N          : integer - number of points in the output colormap (default: 1024)
%       min_L      : double  - minimum CIELAB L value used to equalize the
%                              red/blue ends; must be >= 53.5 (default: 54)
%       white_prct : double  - fraction of the map occupied by the white
%                              center band (default: 0.01)
%
%   Outputs:
%       map : Nx3 double - RGB colormap running red -> white -> blue with
%             perceptually matched lightness on both ends
%
%   Example:
%       figure
%       imagesc(peaks(500));
%       colormap(redblue_equalized);
%       caxis([-8 8]);  % set +/- caxes equal to center on zero
%
%   See also: equalize_divcmap, redbluemap, blueredbluemap, luminosity, colormap
%
%   ∿∿∿  Prerau Laboratory MATLAB Codebase · sleepEEG.org  ∿∿∿
%        Source: https://github.com/preraulab/labcode_main

%Set default N
if nargin<1
    N_raw=1024;
end

if nargin<2
    min_L = 54;
end

if min_L < 53.5
    warning('Values must be bigger than 53.5 to make sure L is equal');
end

%Set default percentage of white
if nargin<3
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

map = equalize_divcmap(map, min_L, Nr, false);
