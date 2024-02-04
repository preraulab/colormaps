function map = hotcoolmap(N, trim_pct)
%HOTCOOLMAP  Creates a hot/cool colormap
%
%   Usage:
%   map = hotcoolmap(N, trim_pct)
%
%   Input:
%   N: number of points (default: 1024)
%   trim_pct: percent to trim to differentiate +- colors (default: 0.2)
%
%   Output:
%   map: Nx3 colormap
%
%   Example:
%
%     figure
%     imagesc(randn(1000));
%     hotcoolmap(redbluemap);
%     caxis([-3 3]); %Must set +- caxes to be equal magnitude to center on zero
%
%   Copyright 2024 Michael J. Prerau, Ph.D. - http://www.sleepEEG.org
%   This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
%   (http://creativecommons.org/licenses/by-nc-sa/4.0/)
%
%   Last modified 02/19/2022
%********************************************************************
%Set default size
if nargin < 1
    N = 1024;
end

%Define trim percentage, which removes dark colors from the end which are
%hard to distinguish from positive vs. negative
if nargin<2
    trim_pct = .2;
end

%Create hot and cool colormaps
baseline_size = 1000; %size of maps from which to interpolate

hot_map = hot(baseline_size);
cool_map = hot_map(:,[2 3 1]);
hotcool_map = [cool_map; flipud(hot_map)];

trim_size = ceil(trim_pct*baseline_size);

%Trim the map
map_raw = hotcool_map(trim_size:end-trim_size,:);
Nr = size(map_raw,1);

%Interpolate to correct size
map(:,1) = interp1(linspace(0,1,Nr),map_raw(:,1), linspace(0,1,N));
map(:,2) = interp1(linspace(0,1,Nr),map_raw(:,2), linspace(0,1,N));
map(:,3) = interp1(linspace(0,1,Nr),map_raw(:,3), linspace(0,1,N));