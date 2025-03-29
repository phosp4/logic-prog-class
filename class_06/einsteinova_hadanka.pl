% dom(Narod, Farba, Zviera, Drink, Cig).

clen(X,[X|_]).
clen(X,[_|T]):-clen(X,T).

vporadi(X,Y,[X,Y|_]).
vporadi(X,Y,[_|T]):-sused(X,Y,T).
sused(X,Y,L):-
    vporadi(X,Y,L);
    vporadi(Y,X,L).

riesenie(Ulica):-
    Ulica=[dom(nor,_,_,_,_),_,dom(_,_,_,mlieko,_),_,_],
    clen(dom(anglican,cervena,_,_,_),Ulica),
    clen(dom(sved,_,psy,_,_),Ulica),
    clen(dom(dan,_,_,caj,_),Ulica),
    vporadi(dom(_,zelena,_,_,_),dom(_,biela,_,_,_),Ulica),
    clen(dom(_,zelena,_,kava,_),Ulica),
    clen(dom(_,_,vtaky,_,pall_mall),Ulica),
    clen(dom(_,zlta,_,_,dun_hill),Ulica),
    clen(dom(_,_,_,pivo,blue_master),Ulica),
    clen(dom(nemec,_,_,_,princ),Ulica),
    sused(dom(_,_,_,_,blends),dom(_,_,macky,_,_),Ulica),
    sused(dom(_,_,kon,_,_), dom(_,_,_,_,dun_hill),Ulica),
    sused(dom(nor,_,_,_,_), dom(_,modra,_,_,_),Ulica),
    sused(dom(_,_,_,_,blends),dom(_,_,_,voda,_),Ulica),
    clen(dom(_,_,ryby,_,_),Ulica).

kto(Narodnost,Zviera):-
    riesenie(Ulica),
    clen(dom(Narodnost,_,Zviera,_,_), Ulica).