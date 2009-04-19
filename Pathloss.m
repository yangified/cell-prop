function grid=Pathloss(SiteFile,txloc,n_in)

eirp=SiteFile.cellSite.erp;
azimuth=SiteFile.cellSite.azimuth;
htx=SiteFile.cellSite.height+double(SiteFile.terrain(txloc(1),txloc(2)));
f=(SiteFile.cellSite.freq)*10^6;
l=(3.0*10^8)/f;
Gr=2;
mean_correct=12.1;
n=n_in;

grid=zeros(SiteFile.nrows,SiteFile.ncols)-127;
tx=txloc(2);
ty=txloc(1);
for(r=1:1:SiteFile.nrows)
    for(c=1:1:SiteFile.ncols)
        point=[c r];
        angle=angleTo([tx ty],point);
        d=distance([tx ty htx],[point(1) point(2) 2+double(SiteFile.terrain(r,c))]); % Assuming receiver is 2m high
%         if angle<=azimuth+width/2 && angle>=azimuth-width/2
%             power=eirp+Gr+20*log10(l/(4*pi))+10*n*log10(1/d);
%             grid(r,c)=power;  
        if(azimuth > 180)
            angle=mod(angle+(360-azimuth),360);
        else
            angle=abs(angle-azimuth);
        end
        if(angle > 180)
            angle=360-angle;
        end
        Gt=cos(angle*pi/180*.246335667)^20.6; % Gain based on difference between receiver angle and azimuth
        Gt=10*log10(Gt); % Convert to decibels
        grid(r,c)=eirp + Gt + Gr + 20*log10(l/(4*pi)) + 10*n*log10(1/d) + mean_correct;
    end
end

        