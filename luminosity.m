function lux = luminosity(RGB_mat)
%LUMINOSITY Computes luminosity in lux
%
%   Usage:
%   lux = luminosity(RGB_mat)
%
%   Input:
%   RGB_mat: N x 3 divergent colormap
%   min_lux: minimum lux on either end (default: .3)
%   N: Number of points in colormap (final N will be odd to keep max value)
%   plot_on: plot output (default: false)
%
%   Output:
%   lux: 1xN double lux = 0.2126.*R + 0.7152.*G + 0.0722.*B
%
%   Example:
%
%     plot(luminosity(jet));
%
%   Copyright 2022 Michael J. Prerau, Ph.D. - http://www.sleepEEG.org
%
%********************************************************************

assert(max(RGB_mat,[],'all')<= 1 && min(RGB_mat,[],'all')>=0, 'Error RGB values must be between 0 and 1')

lux = 0.2126.*RGB_mat(:,1) + 0.7152.*RGB_mat(:,2) + 0.0722.*RGB_mat(:,3);

end