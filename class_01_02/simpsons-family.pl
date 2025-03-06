% poznamky
%   pri paroch sa pise muz ako prvy
%   vymyslene postavy pre potreby kontroly su popisane v komentaroch
%   zdroj vztahov: serial The Simpsons
%   zdroj nazvov: https://lepsiden.sk/pribuzenske-vztahy-nazvy-pomenovanie/

% rodicia

rodic(homer,bart).
rodic(homer,lisa).
rodic(homer,maggie).
rodic(marge,bart).
rodic(marge,lisa).
rodic(marge,maggie).
 
rodic(abraham,herb).
rodic(abraham,homer).
rodic(mona,homer).

rodic(abraham,abbey). % vymyslene
rodic(mona,abbey).
 
rodic(clancy,marge).
rodic(jackie,marge).
rodic(clancy,patty).
rodic(jackie,patty).
rodic(clancy,selma).
rodic(jackie,selma).
rodic(selma,ling).
rodic(sam,mona).
rodic(sam,steve).

% manzelia

manzelia(homer,marge).
manzelia(abraham,mona).
manzelia(clancy,jackie).
manzelia(herb,sue).
manzelia(selma,bob).
manzelia(andy,abbey). % vymyslene
manzelia(steve,alice). % vymyslene

% pohlavia

muz(homer).
muz(bart).
muz(herb).
muz(abraham).
muz(clancy).
muz(bob). % vymyslene, Selmin manzel
muz(andy). % vymyslene, Homerovej sestry Abbey manzel
muz(steve). % vymyslene, Monin brat
muz(sam). % vymyslene, Monin otec
 
zena(marge).
zena(maggie).
zena(lisa).
zena(mona).
zena(jackie).
zena(patty).
zena(selma).
zena(ling).
zena(sue). % vymyslene, Herbova manzelka
zena(abbey). % vymyslene, Homerova sestra
zena(alice). % vymyslene, Stevova manzelka (Homerova teta)
 
% stary rodicia

staryRodic(X,Y):-rodic(X,Z),rodic(Z,Y).
staraMama(X,Y):-staryRodic(X,Y),zena(X).
staryOtec(X,Y):-staryRodic(X,Y),muz(X).

vnuca(X,Y):-staryRodic(Y,X).
vnuk(X,Y):-vnuca(X,Y),muz(X).
vnucka(X,Y):-vnuca(X,Y),zena(X).

% nuklearna rodina

otec(X,Y):-rodic(X,Y),muz(X).
mama(X,Y):-rodic(X,Y),zena(X).
dieta(X,Y):-rodic(Y,X).
syn(X,Y):-dieta(X,Y),muz(X).
dcera(X,Y):-dieta(X,Y),zena(X).

surodenec(X,Y):-rodic(Z,Y),rodic(Z,X),X\==Y.
brat(X,Y):-surodenec(X,Y),muz(X).
sestra(X,Y):-surodenec(X,Y),zena(X).

% rozsirena / vzdialena rodina

stryko(X,Y):-otec(Z,Y),brat(X,Z).
stryna(X,Y):-stryko(Z,Y),manzelia(Z,X).

%%
ujo(X,Y):-mama(Z,Y),brat(X,Z).
ujcina(X,Y):-ujo(Z,Y),manzelia(Z,X).

teta(X,Y):-rodic(Z,Y),sestra(X,Z).
svako(X,Y):-teta(Z,Y),manzelia(X,Z).

%bratranec(X,Y):-vnuca(X,STARY_RODIC),vnuca(Y,STARY_RODIC), \+ surodenec(X,Y), X \== Y. % alternative
cousin(X,Y):-surodenec(A,B),dieta(X,A),dieta(Y,B).

bratranec(X,Y):-cousin(X,Y),muz(X).
sesternica(X,Y):-cousin(X,Y),zena(X).

sestrenec(X,Y):-sestra(RODIC,Y),rodic(RODIC,X),muz(X).
sestrica(X,Y):-sestra(RODIC,Y),rodic(RODIC,X),zena(X).

bratavec(X,Y):-brat(RODIC,Y),rodic(RODIC,X),muz(X).
bratavica(X,Y):-brat(RODIC,Y),rodic(RODIC,X),zena(X).

synovec(X,Y):-sestrenec(X,Y);bratavec(X,Y). % bodkociarka je alebo
neter(X,Y):-sestrica(X,Y);bratavica(X,Y).

% pribuzne vztahy po svadbe

svokor(X,Y):-otec(X,Z),manzelia(Z,Y),muz(X),zena(Y).
svokra(X,Y):-svokor(Z,Y),manzelia(Z,X),zena(X),zena(Y).
svokrovci(X,Y):-svokor(X,Z),svokra(Y,Z),manzelia(X,Y).

test(X,Y):-otec(X,Z),manzelia(Y,Z),muz(Y),muz(X).
testina(X,Y):-test(Z,Y),manzelia(Z,X),zena(X),muz(Y).
testovci(X,Y):-test(X,Z),testina(Y,Z),manzelia(X,Y).

zat(X,Y):-test(Y,X);testina(Y,X).
nevesta(X,Y):-svokor(Y,X);svokra(Y,X).

svat(X,Y):-rodic(X,Z),(manzelia(Z,W);manzelia(W,Z)),rodic(Y,W),muz(X).
svatka(X,Y):-rodic(X,Z),(manzelia(Z,W);manzelia(W,Z)),rodic(Y,W),zena(X).
svatovci(X,Y,Z):-manzelia(X,Y),svat(X,Z),svatka(Y,Z).

svagor(X,Y):-muz(X),(manzelia(Y,Z);manzelia(Z,Y)),surodenec(Z,X). % partnerov brat
svagrina(X,Y):-zena(X),(manzelia(Y,Z);manzelia(Z,Y)),surodenec(Z,X). % partnerova sestra

dever(X,Y):-brat(X,Z),manzelia(Z,Y),muz(X),muz(Z). % manzelov brat
manzelova_sestra(X,Y):-sestra(X,Z),manzelia(Z,Y),zena(X),zena(Y).
zolva(X,Y):-manzelova_sestra(X,Y), \+ manzelia(W,X). % manzelova slobodna sestra
deverica(X,Y):-manzelova_sestra(X,Y),manzelia(W,X). % manzelova vydata sestra

jatrvenica(X,Y):-zena(X),zena(Y),manzelia(Z,X),surodenec(Z,W),manzelia(W,Y). % zena manzelovho brata

sur(X,Y):-muz(X),muz(Y),manzelia(Y,Z),surodenec(Z,X).  % manzelkin brat
sura(X,Y):-zena(X),muz(Y),manzelia(Y,Z),surodenec(Z,X). % manzelkina sestra

prastryko(X,Y):-rodic(Z,Y),(stryko(X,Z);ujo(X,Z);svako(X,Z)).
prateta(X,Y):-rodic(Z,Y),(stryna(X,Z);ujcina(X,Z);teta(X,Z)). % Y rodica stryna alebo teta alebo ujcina

% class 03

predok(X,Y):-rodic(X,Y).
predok(X,Y):-rodic(X,Z),predok(Z,Y). % rekurzivne