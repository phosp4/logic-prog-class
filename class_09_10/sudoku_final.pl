%%%%%    testovacie vstupy    %%%%%

% sudoku([[1,2,3,4],[3,4,1,2],[2,1,4,3],[4,3,2,1]],[1,2,3,4]).
% sudoku([[1,1,3,4],[3,4,1,2],[2,3,4,1],[4,2,2,3]],[1,2,3,4]).
% sudoku([[5,3,4,6,7,8,9,1,2],[6,7,2,1,9,5,3,4,8],[1,9,8,3,4,2,5,6,7],[8,5,9,7,6,1,4,2,3],[4,2,6,8,5,3,7,9,1],[7,1,3,9,2,4,8,5,6],[9,6,1,5,3,7,2,8,4],[2,8,7,4,1,9,6,3,5],[3,4,5,2,8,6,1,7,9]], [1,2,3,4,5,6,7,8,9]).
% sudoku([[5,5,4,6,7,8,9,1,2],[6,7,2,1,9,5,3,4,8],[1,9,8,3,4,2,5,6,7],[8,5,9,7,6,1,4,2,3],[4,2,6,8,5,3,7,9,1],[7,1,3,9,2,4,8,5,6],[9,6,1,5,3,7,2,8,4],[2,8,7,4,1,9,6,3,5],[3,4,5,2,8,6,1,7,9]], [1,2,3,4,5,6,7,8,9]).

%%%%%    hlavny predikat    %%%%%

sudoku(M,Predloha):-
    length(M,Dlzka),
    skontrolujRiadky(M,Dlzka,Predloha),
    transponuj(M,M2),
    skontrolujRiadky(M2,Dlzka,Predloha),
    % rozdelenie do blokov
    DlzkaBloku is integer(sqrt(Dlzka)),
    DlzkaBlokuBez1 is DlzkaBloku - 1,
    findall((X,Y), (between(0, DlzkaBlokuBez1, X), between(0, DlzkaBlokuBez1, Y)), Suradnice), % generacia suradnic
    poblokuj(Suradnice,DlzkaBloku,M,M3),
    skontrolujRiadky(M3,Dlzka,Predloha).

%%%%%    bloky    %%%%
% pouzite su built in funkcie between, findall, append

poblokuj([],_,_,[]).
poblokuj([(X,Y)|DalsieSur],DlzkaBloku,Matica,[Blok1|DalsieBloky]):-
    blok(X,Y,DlzkaBloku,Matica,Blok1),
    poblokuj(DalsieSur,DlzkaBloku,Matica,DalsieBloky).

% bloky sa indexuju napr. pre 9x9 ako (0,0),(0,1),...,(2,2)
blok(X,Y,DlzkaBloku,Matica,Out):-
    Od1 is X * DlzkaBloku,
    sublist(Matica,Od1,DlzkaBloku,Polia),
    Od2 is Y * DlzkaBloku,
    sublistKazdehoPola(Polia,Od2,DlzkaBloku,Out0),
    append(Out0,Out).

% teda nie po kolky prvok ale od ktoreho a kolko prvkov, preto offset
sublist(L,0,Offset,Out):-vyberPrvychXPrvkov(L,Offset,Out).
sublist([_|T],Od,Offset,Out):- Od2 is Od-1, sublist(T,Od2,Offset,Out).

sublistKazdehoPola([],_,_,[]).
sublistKazdehoPola([Pole1|ZvysnePolia],Od,Offset,[H2|T2]):-
    sublist(Pole1,Od,Offset,H2),
    sublistKazdehoPola(ZvysnePolia,Od,Offset,T2).

vyberPrvychXPrvkov(_,0,[]).
vyberPrvychXPrvkov([H|T], X, [H|T2]):- X2 is X-1, vyberPrvychXPrvkov(T,X2,T2).

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