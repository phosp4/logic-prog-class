% vsetky funkcie vracaju boolean, nikdy nic ine
% donutime ho tak ze na vstup dame to co chceme na vystupe

%%%%% zakladne funkcie

plus(X,Y,Z):-Z is X+Y.
minus(X,Y,Z):-Z is X-Y.
krat(X,Y,Z):-Z is X*Y.
mocnina(X,Y,Z):-Z is X^Y.

maximum(X,Y,X):- X>=Y. % vrat X ak to plati, teda najdi maximum z X a Y, je to X?, je to Y?
maximum(X,Y,Y):- Y>X. % ide zhora nadol, ak neplati prve, urobi druhe

%%%%% rekurzivne vztahy - caste pre prolog

faktorial(0,1). % 0! = 1, baza
faktorial(N, F):-
    N>0,
    N1 is N - 1,
    faktorial(N1, F1),
    F is N*F1.

fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,F):-
    N>1,
    N1 is N-1,
    N2 is N-2,
    fibonacci(N1, F1),
    fibonacci(N2, F2),
    F is F1+F2.

%%%%% zoznamy

dlzka([],0).
dlzka([_|T], N):-   % _ je anonymna premenna
    dlzka(T, N1),
    N is N1+1.

sucetZoznamu([],0).
sucetZoznamu([H|T], S):-
    sucetZoznamu(T, S1),
    S is S1+H.

minimum(X,Y,X):-X=<Y. % =< treba pouzit namiesto <= !!!
minimum(X,Y,Y):-Y<X.

minZoznamu([H],H).
minZoznamu([H|T],M):-
    minZoznamu(T,M1),
    minimum(H,M1,M).

jeClenomZoznamu(X,[X|_]).
jeClenomZoznamu(X,[_|T]):-
    jeClenomZoznamu(X,T).

spojZoznamy([],L,L).
spojZoznamy([H|T],L,[H|TL]):- spojZoznamy(T,L,TL).

%%%%% mergesort
% sklada sa to z viacerych casti
% najlepsie si to nasymulovat...

% baza
mergeSortedArrays(A,[],A).
mergeSortedArrays([],B,B).

% tretia cast mergesortu
mergeSortedArrays([H1|T1],[H2|T2], [H1|Tm]):- % [Hm,Tm] je vystup
    H1=<H2,
    mergeSortedArrays(T1, [H2|T2], Tm).

mergeSortedArrays([H1|T1],[H2|T2], [H2|Tm]):- % [Hm,Tm] je vystup
    H1>H2,
    mergeSortedArrays([H1|T1], T2, Tm).

% pomocna - rozdelovanie poli
rozdelPolePodla(0,L,[],L). % posledne dva su to co vraciame, dva rozdelene
rozdelPolePodla(1,[H|T], H, T).
rozdelPolePodla(N,[H|T], [H|T1], L):-
    N1 is N-1,
    rozdelPolePodla(N1, T, T1, L).

% pociatocna cast
rozdelPoleNapoly([],[],[]).
rozdelPoleNapoly(L,L1,L2):-
    dlzka(L,D),
    D2 is div(D,2),
    rozdelPolePodla(D2, L, L1, L2).

% finalny predikat
mergeSort([],[]).
mergeSort([X],[X]).
mergeSort(LI,LOUT):-
    rozdelPoleNapoly(LI, L1, L2),
    mergeSort(L1,LOUT1),
    mergeSort(L2,LOUT2),
    mergeSortedArrays(LOUT1, LOUT2, LOUT).