% odhadovanie pi pomocou monte carlo metody
% pi(Kolkokrat to zbehne, Kolkokrat to zbehlo, Kolkokrat padlo dnu, Vysledok)

pi(N,N,InCount,R):- R is (InCount/N) * 4.

pi(N,AllCount,InCount,R):-
    random(1,10000, X0), X is X0/10000,
    random(1,10000, Y0), Y is Y0/10000,
    Dist is (X*X)+(Y*Y),
    % jeden alebo druhy riadok sa vykona kvoli bodkociarke
    ((Dist =< 1, InCount2 is InCount + 1, AllCount2 is AllCount + 1, pi(N,AllCount2,InCount2,R));
    (InCount2 is InCount, AllCount2 is AllCount + 1, pi(N,AllCount2,InCount2,R))).