function break_link(nstr, nsom)

%permet de rompre un lien entre sommets voisins
    profil = evalin('base','profil;');
    scattlinks = find_links(profil,'sommet');
    
    
    I = ((scattlinks(:,1) == nstr) & (scattlinks(:,2) == nsom));
    coo = scattlinks(I,3:4);
    
    
    
    %le sommet doit effectivement �tre un lien
    if isnan(scattlinks(I,5))
        errordlg('this summit is not a link between 2 polygons');
        return        
    end
    %le sommet ne doit pas �tre auto-li�
    if scattlinks(I,16)
        errordlg('cannot break an autolinked summit');
        return
    end
    
    
    
    
    %ligne de scattlinks o� trouver les structures li�es
    Iother = scattlinks(I,[false(1,4),~isnan(scattlinks(I, 5:15)),false]);
    otherstr = scattlinks(Iother,1);
    othersum = scattlinks(Iother,2);
    
    %liste des strctures concern�es par le lien
    strlst = [nstr;otherstr];
    sumlst = [nsom;othersum];
    
    %on eclate le lien en rapprochant chaque sommet du centre de gravit� de
    %son polygone
    dpx = 3;
    limx = diff(xlim());
    limy = diff(ylim());
    Lpx= getpixelposition(gca) * [0;0;1;0];
    Hpx= getpixelposition(gca) * [0;0;0;1];    
    for istr = 1 : length(strlst)
        xo = profil.model(strlst(istr)).polyg(sumlst(istr),1);
        yo = profil.model(strlst(istr)).polyg(sumlst(istr),2);
        [x1, y1] =  ctrgrav(strlst(istr)); 
        %line([xo,x1],[yo,y1])
        c = dpx / sqrt( ((x1-xo)*Lpx/limx)^2 + ((y1-yo)*Hpx/limy)^2 );
        profil.model(strlst(istr)).polyg(sumlst(istr),1) = xo + (x1-xo) * c;
        profil.model(strlst(istr)).polyg(sumlst(istr),2) = yo + (y1-yo) * c;
    end
    %rafaichissement du workspace
    assignin('base' , 'profil', profil)
end
