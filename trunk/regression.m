function n=regression(site)
lambda=(3.0*10^8)/(site.cellSite.freq*10^6);
PLref=20*log10(lambda/(4*pi));
i=1;

sum1=0;
sum2=0;
for(r=1:1:site.nrows)
    for(c=1:1:site.ncols)
        if(site.data(r,c) ~= 0)
            d=distance([830 630 site.cellSite.height],[c r 2]);
            PL(i)=double(site.cellSite.erp) - double(site.data(r,c)) + 3 + PLref;
            logref=log10(d);
            sum1=sum1+(PL(i)*logref);
            sum2=sum2+(logref^2);
            i=i+1;
        end
    end
end
n=sum1/(10*sum2);