% treba ist od spodu hore oproti tabuli
% moze sa natiahnut? nie, tak moze ist?, nie... (tak to postupuje)
% podobne s tymi misionarmi a kanibalmi...

% pozn.
%% zadavame len podmienky, co musi kedy platit, riesenie nechavame nanho

% natiahnutie po banan
zmena(
    stav(stred, podlaha, stred, nema),
    natiahnut,
    stav(stred, podlaha, stred, ma)
).

% vylezenie na krabicu
zmena(
    stav(H, podlaha, H, B),
    vylez,
    stav(H, krabica, H, B)
).

% posun krabice
zmena(
    stav(H1, podlaha, H1, B),
    posun(H1, H2),
    stav(H2, podlaha, H2, B)
).

% chodza po miestnosti
zmena(
    stav(H1, podlaha, K, B),
    chodza(H1, H2),
    stav(H2, podlaha, K, B)
).

mozeDosiahnut(stav(_,_,_,ma)). % pravda je to vzdy ked ma, nehladiac na stav
mozeDosiahnut(Stav):-
    zmena(Stav, _, Stav2), % skusaj vsetky mozne zmeny, stale kontroluj ci uz moze dosiahnut
    mozeDosiahnut(Stav2).

% inak nemoze... (asi do nekonecna)