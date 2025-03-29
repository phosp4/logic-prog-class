% lodky
% lod(narodnost, farba, odchod, tovar, ciel)

clen(X,[X|_]).
clen(X,[_|T]):-
    clen(X,T).

vPoradi(X, Y, [X,Y|_]).
vPoradi(X,Y, [_|T]):-vPoradi(X,Y,T). % z nejakeho dovodu tu fungovalo aj sused
sused(X,Y,L):-vPoradi(X,Y,L);vPoradi(Y,X,L).

riesenie(Pristav):-
    Pristav=[_,_,lod(_,cierna,_,_,_),_,lod(_,_,_,obilie,_)],
    clen(lod(grecka,_,sest,kava,_),Pristav),
    clen(lod(anglicka,_,devat,_,_),Pristav),
    vPoradi(lod(francuzska, modra, _, _, _), lod(_,_,_,kava,_), Pristav),
    vPoradi(lod(_, _, _, kakao, _), lod(_,_,_,_,Marseille), Pristav),
    clen(lod(brazilska,_,_,_,manila),Pristav),
    sused(lod(_,_,_,ryza,_), lod(_,zelena,_,_,_), Pristav),
    clen(lod(_,_,pat,_,janov), Pristav),
    vPoradi(lod(_,_,_,_,Marseille), lod(spanielska,_,sedem,_,_), Pristav),
    clen(lod(_,cervena,_,_,hamburg), Pristav),
    sused(lod(_,_,sedem,_,_), lod(_,biela,_,_,_), Pristav),
    clen(lod(_,cierna,osem,_,_), Pristav),
    sused(lod(_,_,_,obilie,_), lod(_,_,_,ryza,_), Pristav),
    clen(lod(_, _, sest, _, hamburg), Pristav),
    clen(lod(_, _, _, _, port_said), Pristav),
    clen(lod(_,_,_,caj,_), Pristav).

% toto nie je dokoncene
vypis1(Ciel, Narodnost):-
    riesenie(Pristav),
    clen(lod(Narodnost, _, _, _, Ciel), Pristav).

vypis2(Tovar, Narodnost):-
    riesenie(Pristav),
    clen(lod(Narodnost, _, _, Tovar, _), Pristav).