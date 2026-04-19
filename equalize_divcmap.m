function cmap_new = equalize_divcmap(cmap,min_L, N, plot_on)
%EQUALIZE_DIVCMAP  Equalize CIELAB lightness on the two arms of a divergent colormap
%
%   Usage:
%       cmap_new = equalize_divcmap(cmap, min_L, N, plot_on)
%
%   Inputs:
%       cmap    : Nx3 double - divergent RGB colormap to equalize -- required
%       min_L   : double     - minimum CIELAB L value retained on each end (default: 0.3)
%       N       : integer    - number of output points; final length will
%                              be odd to preserve the peak (default: size(cmap, 1))
%       plot_on : logical    - if true, plot before/after for QA (default: false)
%
%   Outputs:
%       cmap_new : Nx3 double - divergent colormap resampled so both arms
%                  share the same CIELAB lightness envelope
%
%   Example:
%       equalize_divcmap;  % run demo
%
%   See also: redblue_equalized, luminosity, redbluedark, colormap
%
%   ∿∿∿  Prerau Laboratory MATLAB Codebase · sleepEEG.org  ∿∿∿

if nargin == 0
    cmap = redbluedark;
    equalize_divcmap(cmap,30,500,true);
    return;
end

if nargin<2
    min_L = .3;
end

if nargin<3
    N = size(cmap,1);
end

if nargin<4
    plot_on = false;
end

%Compute L
L = getL(cmap);
assert(~issorted(L,'monotonic'),'Must be divergent colormap');

%Find max lux
[~,imax] = max(L);

%Find edges of lux
istart = find(L>= min_L,1,'first');
iend = find(L>=min_L,1,'last');

%Interpolate ramp up
Rup = interp1(istart:imax,cmap(istart:imax,1),linspace(istart,imax,floor(N/2)))';
Gup = interp1(istart:imax,cmap(istart:imax,2),linspace(istart,imax,floor(N/2)))';
Bup = interp1(istart:imax,cmap(istart:imax,3),linspace(istart,imax,floor(N/2)))';

%Interplot ramp dow
Rdown = interp1(imax:iend,cmap(imax:iend,1),linspace(imax,iend,floor(N/2))');
Gdown = interp1(imax:iend,cmap(imax:iend,2),linspace(imax,iend,floor(N/2))');
Bdown = interp1(imax:iend,cmap(imax:iend,3),linspace(imax,iend,floor(N/2))');

%Make new cmap
cmap_new = [Rup(1:end-1) Gup(1:end-1) Bup(1:end-1); Rdown Gdown Bdown];

if plot_on
    a = peaks(500);
    climits = max(abs(min(a(:))), abs(max(a(:)))) * [-1 1];
    figure
    subplot(211)
    imagesc(a);
    colormap(gca,cmap);
    caxis(gca,climits);
    colorbar
    title('Original')

    subplot(212)
    imagesc(a);
    colormap(gca,cmap_new);
    caxis(gca,climits);
    colorbar
    title('Lux Equalized')

    figure
    hold all
    plot(interp1(linspace(0,1,size(cmap,1)),getL(cmap),linspace(0,1,500)));
    plot(interp1(linspace(0,1,size(cmap_new,1)),getL(cmap_new),linspace(0,1,500)));
    legend('Original','Equalized')
    ylabel('Lightness (L*a*b)')

end

function L = getL(cmap)
LAB = rgb2lab(cmap);
L = LAB(:,1);


