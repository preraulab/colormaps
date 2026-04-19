function lux = luminosity(RGB_mat)
%LUMINOSITY  Compute per-row relative luminosity of an RGB colormap
%
%   Usage:
%       lux = luminosity(RGB_mat)
%
%   Inputs:
%       RGB_mat : Nx3 double - RGB colormap with values in [0, 1] -- required
%
%   Outputs:
%       lux : Nx1 double - luminosity per row, lux = 0.2126*R + 0.7152*G + 0.0722*B
%
%   Example:
%       plot(luminosity(jet));
%
%   See also: equalize_divcmap, redblue_equalized, colormap
%
%   ∿∿∿  Prerau Laboratory MATLAB Codebase · sleepEEG.org  ∿∿∿
%        Source: https://github.com/preraulab/labcode_main


assert(max(RGB_mat,[],'all')<= 1 && min(RGB_mat,[],'all')>=0, 'Error RGB values must be between 0 and 1')

lux = 0.2126.*RGB_mat(:,1) + 0.7152.*RGB_mat(:,2) + 0.0722.*RGB_mat(:,3);

end