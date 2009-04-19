function grid=Pathloss(SiteFile,txloc,n_in)

eirp=SiteFile.cellSite.erp;     % ERP of the transmitter
azimuth=SiteFile.cellSite.azimuth;  % Azimuth of the transmitter
htx=SiteFile.cellSite.height+double(SiteFile.terrain(txloc(1),txloc(2)));   % Height is transmitter height + height above sea level
f=(SiteFile.cellSite.freq)*10^6;    % Frequency of the transmitter
l=(3.0*10^8)/f;     % Wavelength of the signal
Gr=2;               % Receiver gain
mean_correct=12.1;  % Correction factor for the mean error of the model
n=n_in;             % Path-loss exponent

grid=zeros(SiteFile.nrows,SiteFile.ncols);      % Creating the blank grid
tx=txloc(2);        % Transmitter's x-coordinate
ty=txloc(1);        % Transmitter's y-coordinate
for(r=1:1:SiteFile.nrows)
    for(c=1:1:SiteFile.ncols)
        point=[c r];        % Point of interest's cartesian coordinates
        angle=angleTo([tx ty],point);       % Calculate the angle from the transmitter to point of interest
        d=distance([tx ty htx],[point(1) point(2) 2+double(SiteFile.terrain(r,c))]);    % Calculate distance from transmitter to point in 3D
        
        % This block calculates the angle between the transmitter azimuth
        % and the point, from 0-180 degrees
        if(azimuth > 180)
            angle=mod(angle+(360-azimuth),360);
        else
            angle=abs(angle-azimuth);
        end
        if(angle > 180)
            angle=360-angle;
        end
        Gt=cos(angle*pi/180*.246335667)^20.6; % Gain based on difference between receiver angle and azimuth; -3dB at 60degrees from azimuth
        Gt=10*log10(Gt);                      % Convert to decibels
        grid(r,c)=eirp + Gt + Gr + 20*log10(l/(4*pi)) + 10*n*log10(1/d) + mean_correct; % Calculate total received power
    end
end

        