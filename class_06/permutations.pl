% uloha - vratit vsetky permutacie zoznamu

perm([],[]).
perm([H|T],L) :-
    write("permutating: "), write(T),
    perm(T,T1), % zvysok prepermutuj a pridaj hlavu
    vloz(H,T1,L). % H vloz *hocikde* do T1 (hocikde - teda bude skusat vsetky rozne miesta)

vloz(X,L,L1) :- zmaz(X,L1,L). % vlozit je inverzna operacia od zmazat - teda ako musi vyzerat pole kde som zmazal X !! to je smart

zmaz(X,[X|T],T).
zmaz(X,[H|T],[H|T1]):-zmaz(X,T,T1).

% spustanie: lists:perm([1,2,3,4,5],L)
% alebo aj : lists:perm([1,2,3,4,5],L),L=[_,2,3|_].
% ++ nebolo by zle doplnit nech to vypisuje co robi