function map = hotcoolmap(N, trim_pct)
%HOTCOOLMAP  Divergent hot/cool colormap with dark ends trimmed
%
%   Usage:
%       map = hotcoolmap(N, trim_pct)
%
%   Inputs:
%       N        : integer - number of points in the output colormap (default: 1024)
%       trim_pct : double  - fraction trimmed from each end to drop dark colors
%                            that confuse +/- readability (default: 0.2)
%
%   Outputs:
%       map : Nx3 double - RGB colormap (cool negative values -> hot positive values)
%
%   Example:
%       figure
%       imagesc(randn(1000));
%       colormap(hotcoolmap);
%       caxis([-3 3]);  % set +/- caxes equal to center on zero
%
%   See also: colormap, hot, redbluemap, redblue_equalized, blueredbluemap
%
%   ∿∿∿  Prerau Laboratory MATLAB Codebase · sleepEEG.org  ∿∿∿
%        Source: https://github.com/preraulab/labcode_main

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
