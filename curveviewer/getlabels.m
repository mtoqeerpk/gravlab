function  str=getlabels()
%renvoie les labels des diff�rentes courbes dans une chaine de caractere
%separ�s par des |

str=[];
Xzfiles=evalin('base','session.Xzfiles;');
for i=1:length(Xzfiles)
    str=[str,Xzfiles(i).label,'|'];
end
str(length(str))=[];

end