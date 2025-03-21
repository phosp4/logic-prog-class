%%%%% pomocne z minula

spojZoznamy([],L,L).
spojZoznamy([H|T],L,[H|TL]):- spojZoznamy(T,L,TL).

dlzka([],0).
dlzka([_|T], N):-
    dlzka(T, N1),
    N is N1+1.

%%%%% quicksort

vratMensieRovneAko(Val, [], []).
vratMensieRovneAko(Val, [H|T], [H|Tout]):-
    H=<Val,
    vratMensieRovneAko(Val, T, Tout).
vratMensieRovneAko(Val, [H|T], Tout):-
    H>Val,
    vratMensieRovneAko(Val, T, Tout).

%%%% to iste pre vacsie
vratVacsieAko(Val, [], []).
vratVacsieAko(Val, [H|T], [H|Tout]):-
    H>Val,
    vratVacsieAko(Val, T, Tout).
vratVacsieAko(Val, [H|T], Tout):-
    H=<Val,
    vratVacsieAko(Val, T, Tout).

quickSort([],[]).
quickSort([X],[X]).

quickSort([H|T],Out):-
    % pivot bude H
    vratMensieRovneAko(H, T, LeftArr),
    vratVacsieAko(H, T, RightArr),

    quickSort(LeftArr,LeftArrSorted),
    quickSort(RightArr,RightArrSorted),

    % spojit ich
    spojZoznamy(LeftArrSorted, [H|RightArrSorted], Out).