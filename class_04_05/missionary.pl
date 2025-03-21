%%%%% kanibali

start([3,3,left,0,0]).
goal([0,0,right,3,3]).

legal(CL, ML, CR, MR):-
    ML>=0,MR>=0,CL>=0,CR>=0,
    (ML>=CL;ML=0),
    (MR>=CR;MR=0).

% musia byt definovane vsetky moznosti (je ich 10) - [1 misionar, 1 kanibal, 1 misionar 1 kanibal, 2 misionari, 2 kanibali], zpravadolava/zlavadoprava
% da sa to mozno aj nejako smart jednoduchsie, ale toto je asi pochopitelnejsie

% presun dvoch misionarov zlava doprava
presun([CL,ML1,left,CR,MR1], [CL,ML2,right,CR,MR2]):-
    ML2 is ML1-2,
    MR2 is MR1+2,
    legal(CL,ML2,CR,MR2).

% presun dvoch kanibalov zlava doprava
presun([CL1,ML,left,CR1,MR], [CL2,ML,right,CR2,MR]):-
    CL2 is CL1-2,
    CR2 is CR1+2,
    legal(CL2,ML,CR2,MR).

% presun kanibala a misionara zlava doprava
presun([CL1,ML1,left,CR1,MR1], [CL2,ML2,right,CR2,MR2]):-
    ML2 is ML1-1,
    MR2 is MR1+1,
    CL2 is CL1-1,
    CR2 is CR1+1,
    legal(CL2,ML2,CR2,MR2).

% presun misionara zlava doprava
presun([CL,ML1,left,CR,MR1], [CL,ML2,right,CR,MR2]):-
    ML2 is ML1-1,
    MR2 is MR1+1,
    legal(CL,ML2,CR,MR2).

% presun kanibala zlava doprava
presun([CL1,ML,left,CR1,MR], [CL2,ML,right,CR2,MR]):-
    CL2 is CL1-1,
    CR2 is CR1+1,
    legal(CL2,ML,CR2,MR).

%%% opacny smer

% presun dvoch misionarov zprava dolava
presun([CL,ML1,right,CR,MR1], [CL,ML2,left,CR,MR2]):-
    ML2 is ML1+2,
    MR2 is MR1-2,
    legal(CL,ML2,CR,MR2).

% presun dvoch kanibalov zprava dolava
presun([CL1,ML,right,CR1,MR], [CL2,ML,left,CR2,MR]):-
    CL2 is CL1+2,
    CR2 is CR1-2,
    legal(CL2,ML,CR2,MR).

% presun kanibala a misionara z prava dolava
presun([CL1,ML1,right,CR1,MR1], [CL2,ML2,left,CR2,MR2]):-
    ML2 is ML1+1,
    MR2 is MR1-1,
    CL2 is CL1+1,
    CR2 is CR1-1,
    legal(CL2,ML2,CR2,MR2).

% presun misionara zprava dolava
presun([CL,ML1,right,CR,MR1], [CL,ML2,left,CR,MR2]):-
    ML2 is ML1+1,
    MR2 is MR1-1,
    legal(CL,ML2,CR,MR2).

% presun kanibala zprava dolava
presun([CL1,ML,right,CR1,MR], [CL2,ML,left,CR2,MR]):-
    CL2 is CL1+1,
    CR2 is CR1-1,
    legal(CL2,ML,CR2,MR).

% built in predikaty su member, write, not, ...
cesta([CL1,ML1,B1,CR1,MR1],[CL2,ML2,B2,CR2,MR2], Navstivene, ZoznamPresunov):-
    presun([CL1,ML1,B1,CR1,MR1],[CL3,ML3,B3,CR3,MR3]),
    not(member([CL3,ML3,B3,CR3,MR3], Navstivene)),
    cesta([CL3,ML3,B3,CR3,MR3], % rekurzia
          [CL2,ML2,B2,CR2,MR2], % pridame to na zaciatok
          [[CL3,ML3,B3,CR3,MR3]|Navstivene],
          [[[CL3,ML3,B3,CR3,MR3], [CL1,ML1,B1,CR1,MR1]]|ZoznamPresunov]).

% najdene riesenie - ked sa aktualny stav rovna hladanemu stavu
cesta([CL,ML,B,CR,MR], [CL,ML,B,CR,MR], _, ZoznamPresunov):-
      write('Solution found!'), nl,
      vystup(ZoznamPresunov).

vystup([]):-nl. % new line
vystup([[A,B]|Zoznam]):-
    vystup(Zoznam),
    write(B), write(' -> '), write(A), nl.

find:-
    cesta([3,3,left,0,0],[0,0,right,3,3],[[3,3,left,0,0]],_).

% ale napr pre toto vracia false, samozrejme
% find:-
%     cesta([3,3,left,0,0],[0,0,right,4,3],[[3,3,left,0,0]],_).