function map = redbluemap(N_raw, white_prct)
%REDBLUEMAP  Creates a red blue colormap
%
%   Usage:
%   map = redbluemap(N, white_prct)
%
%   Input:
%   N: number of points (default: 1024)
%   white_prct: percent white in the middle (default: 0.01)
%
%   Output:
%   map: Nx3 colormap
%
%   Example:
%
%     figure
%     imagesc(randn(1000));
%     colormap(redbluemap);
%     caxis([-3 3]); %Must set +- caxes to be equal magnitude to center on zero
%
%   Copyright 2022 Michael J. Prerau, Ph.D. - http://www.sleepEEG.org
%   This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
%   (http://creativecommons.org/licenses/by-nc-sa/4.0/)
%
%   Last modified 02/19/2022
%********************************************************************

%Set default N
if nargin<1
    N=1024;
end

%Set default percentage of white
if nargin<2
    white_prct=.01;
end

%Create the blue and red components
N_raw = 1000; %Starting N before interpolation

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
map(:,1) = interp1(linspace(0,1,Nr), map_raw(:,1), linspace(0,1,N));
map(:,2) = interp1(linspace(0,1,Nr), map_raw(:,2), linspace(0,1,N));
map(:,3) = interp1(linspace(0,1,Nr), map_raw(:,3), linspace(0,1,N));
