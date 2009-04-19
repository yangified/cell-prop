% Takes vectors a and b (a=[ax ay] and b=[bx by])
% and returns azimuthal angle (where north=0,east=90,etc)

function theta=angleTo(a,b)
dx=(b(1)-a(1));
dy=(b(2)-a(2));
if dx>0 && dy>0     % First quadrant
    theta=90-(atan(dy/dx)*180/pi);
elseif dx<0 && dy>0 % Second quadrant
    theta=270+(atan(dy/abs(dx))*180/pi);
elseif dx<0 && dy<0 % Third quadrant
    theta=270-(atan(abs(dy)/abs(dx))*180/pi);
elseif dx==0
    if dy>0
        theta=0;
    else
        theta=180;
    end
elseif dy==0
    if dx>0
        theta=90;
    else
        theta=270;
    end
else                % Fourth quadrant
    theta=90+(atan(abs(dy)/dx)*180/pi);
end