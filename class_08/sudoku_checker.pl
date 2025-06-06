%%%%%    hlavny predikat    %%%%%

skontrolujSudoku(M,Predloha):-
    length(M,Dlzka),
    skontrolujRiadky(M,Dlzka,Predloha),
    transponuj(M,M2),
    skontrolujRiadky(M2,Dlzka,Predloha).

%%%%%   permutacie   %%%%%

perm([],[]).
perm([H|T],L) :-
    perm(T,T1),
    vloz(H,T1,L).

vloz(X,L,L1) :- zmaz(X,L1,L).
zmaz(X,[X|T],T).
zmaz(X,[H|T],[H|T1]):-zmaz(X,T,T1).

%%%%%    inverzia matice     %%%%%

% napr. [[1,2],[3,4]] -> [1,3] %
invertujHlavy([],[]).
invertujHlavy([[H|_]|T2],[H|T3]):- invertujHlavy(T2,T3).

% napr. [[1,2],[3,4]] -> [[2],[4]] %
odstranHlavy([],[]).
odstranHlavy([[_|T1]|T], [T1|X]) :-
    odstranHlavy(T, X). % X sa ako neznama posuva az do bazy

% napr. [[1,2],[3,4]] -> [[1,3], [2,4]] %
transponuj([[]|_],[]). % [[]|_] je formalita
transponuj(M,[H2|L2]):-
    invertujHlavy(M,H2),
    odstranHlavy(M,M2),
    transponuj(M2,L2).

%%%%%    kontrola opakovania prvkov v zoznamoch    %%%%%

skontrolujRiadky(_,0,_).
skontrolujRiadky([H|T],C,Predloha):-
    perm(Predloha,H), % opacne to fsr vracalo false
    C1 is C - 1,
    skontrolujRiadky(T,C1,Predloha).