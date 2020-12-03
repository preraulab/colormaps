
% Red and blue color map
function col = blueredbluemap(N,wp)
% to transition from blue to white to red to white to blue so that the
% peak is at 0 and the troughs are at pi and -pi 

if nargin<2
    N=1024;
end

if nargin<1
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