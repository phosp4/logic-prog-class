%%%%% pomocne z minula

spojZoznamy([],L,L).
spojZoznamy([H|T],L,[H|TL]):- spojZoznamy(T,L,TL).

%%%%% bubblesort - moj pokus - nedokoncene

porovnaj([H1,H2|T],[H2,H1|T]):-H2=<H1.
porovnaj([H1,H2|T],[H1,H2|T]):-H1=<H2.

% Ldone je pole do ktoreho davame
% prvky pola ktore sme presli v aktualnej iteracii
% potom bude treba toto robit pre kazdy prvok v poli

% jedenPrechod([],[]).
% jedenPrechod([X],[X]).
% jedenPrechod([H1,H2|T],Ldone, Out):-
%     porovnaj([H1,H2|T],[Hout|Tout]),
%     jedenPrechod(Tout, OutRest),
%     spojZoznamy(H1, OutRest, Out).

jedenPrechod([], []).
jedenPrechod([X], [X]).

jedenPrechod([H1, H2 | T], [H2 | Rest]) :-
    H1 > H2,
    jedenPrechod([H1 | T], Rest).

jedenPrechod([H1, H2 | T], [H1 | Rest]) :-
    H1 =< H2,
    jedenPrechod([H2 | T], Rest).

%% hotove - by Kaja

bubble([],[]).
bubble([X],[X]).

% jedno prebublanie
bubble([H1,H2|T],L):-
    H1<H2,
    bubble([H2|T], M),
    spojZoznamy([H1],M,L).
bubble([H1,H2|T],L):-
    H1>=H2,
    bubble([H1|T], M),
    spojZoznamy([H2],M,L).

% samotny sort, N je dlzka pola
bubbleSort(M,0,M).
bubbleSort(M,N,T):-
    N>0,
    bubble(M,L),
    N1 is N-1,
    bubbleSort(L,N1,T).