% Outputs the distance between a=[ax ay az] and b=[bx by bz]

function d=distance(a,b)
dx=(b(1)-a(1))*30;
dy=(b(2)-a(2))*30;
dz=b(3)-a(3);
d=sqrt(dx^2 + dy^2 + dz^2);