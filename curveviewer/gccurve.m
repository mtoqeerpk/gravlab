function Xzfilenumber = gccurve()
%renvoie le num�ro de la courbe qui est affich� dans le curve manager
%en cherchant lequel des onglets est selectionn�

fig = evalin('base', 'windows.curveopenfig.handle');
Xzfilenumber = str2num(get(findobj(fig, 'selected','on'),'tag')); %#ok<ST2NM>