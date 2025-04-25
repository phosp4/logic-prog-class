% popis ulohy - najst koncepty z kontextoveho zvazu
% kazdy dalsi riadok prienikujeme s kazdym ktory uz je v A
% treba nam nejaky set

% prienik
porovnaj(0,0,0).
porovnaj(0,1,0).
porovnaj(1,0,0).
porovnaj(1,1,1).
prienik([],[],[]).
prienik([H1|T1],[H2|T2],[H3|T3]):-
    prienik(T1,T2,T3),
    porovnaj(H1,H2,H3).

% jeden riadok prienikuj s kazdym v A
prienikuj(_,[],[]). % riadok, A matica, vysledok
prienikuj(L,[H1|T1],[H2|T2]):-
    prienik(L,H1,H2), % H1 je zoznam
    prienikuj(L,T1,T2).

% to je custom union funkcia
spoj([],M,M).
spoj([H|T],M,[H|T2]) :- spoj(T,M,T2).

odstranDuplicity([],[]).
odstranDuplicity([H|T],Out):-
    member(H,T),
    odstranDuplicity(T,Out).
% druha vetva - musime zachranit H
odstranDuplicity([H|T],[H|T2]):-
    \+member(H,T), % musi to tu byt inak by davalo vsetky verzie
    odstranDuplicity(T,T2).

% prechadzaj kazdym riadkom matice a preved nan prienikuj a vysledok zjednot s A
oi([],A,A).
oi([H|T],A,Out):-
    prienikuj(H,A,B),
    spoj(A,B,A2),
    odstranDuplicity(A2,A3),
    oi(T,A3,Out).

% TESTOVACIE VSTUPY
% prienikuj([1,0,0,0,1], [[1,1,1,1,1],[1,0,0,1,0]], X).
% oi([[1,0,0,0,1],[0,1,0,1,0],[1,1,0,1,1],[1,0,1,0,0],[0,0,0,0,1],[1,1,1,0,0]], [[1,1,1,1,1]], X).
% zjednot([[1,2,3],[30]],[[2,3,4],[3,4,5]],X).
% odstranDuplicity([1,2,3,3,4,2],X).
% oi([[1,0,0,1],[0,1,1,0],[0,1,1,1]], [[1,1,1,1]], X).