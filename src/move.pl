:- dynamic(canFish/1).
:- dynamic(canRanch/1).
:- dynamic(canDig/1).

hitEdge :- 
    write('You\'re in the edge of the map. We are sorry, but you can\'t move any further, try using \'map.\''), nl.

encounterMarket(X, Y) :-
    mapObject(X, Y, 'M'),
    write('You are in Marketplace.'), nl.

encounterRanch(X, Y) :-
    mapObject(X, Y, 'R'),
    write('You are in the Ranch.'), nl.

encounterHouse(X, Y) :-
    mapObject(X, Y, 'H'),
    write('You are in your house.'), nl.

encounterQuest(X, Y) :- 
    mapObject(X, Y, 'Q'),
    write('You encountered a quest.'), nl.

encounterWater(X, Y) :-
    mapObject(X, Y, 'o'),
    write('You can\'t go into water'), nl.

aroundWater(X, Y) :-
    X1 is X + 1,
    X2 is X - 1,
    Y1 is Y + 1,
    Y2 is Y - 1,
    ((mapObject(X1, Y, 'o'); mapObject(X2, Y, 'o'); mapObject(X, Y1, 'o'); mapObject(X, Y2, 'o')) ->  
    (\+canFish(_) -> asserta(canFish(true));
    retract(canFish(_)), asserta(canFish(true)));
    
    (\+canFish(_) -> asserta(canFish(false));
    retract(canFish(_)), asserta(canFish(false)))).

inRanch(X, Y) :-
    (mapObject(X, Y, 'R') ->
    (\+canRanch(_) -> asserta(canRanch(true));
    retract(canRanch(_)), asserta(canRanch(true)));    

    (\+canRanch(_) -> asserta(canRanch(false));
    retract(canRanch(_)), asserta(canRanch(false)))).

emptyTile(X, Y) :-
    (\+mapObject(X, Y, 'R'), \+mapObject(X, Y, 'Q'), \+mapObject(X, Y, 'H'), \+mapObject(X, Y, 'M') ->
    (\+canDig(_) -> asserta(canDig(true));
    retract(canDig(_)), asserta(canDig(true)));    

    (\+canDig(_) -> asserta(canDig(false));
    retract(canDig(_)), asserta(canDig(false)))).    


% Move Up(w)
% Ketemu Objektif
w :- 
    startGame(true),
    mapObject(X,Y,'P'),
    Y1 is Y-1,
    (encounterMarket(X, Y1);
    encounterRanch(X, Y1);
    encounterHouse(X, Y1);
    encounterQuest(X, Y1)), !,
    retract(mapObject(X, Y, 'P')),
    asserta(mapObject(X,Y1,'P')).

% Move berhasil
w :-
	startGame(true),
    mapObject(X,Y,'P'),
    Y1 is Y-1,
    (\+ mapObject(X, Y1, 'o')),
    mapSize(_, H),
    Y1 > 0, Y1 =< H, !,
    retract(mapObject(X, Y, 'P')),
    asserta(mapObject(X,Y1,'P')),
    write('You moved up.').

% Ketemu air
w :-
    startGame(true),
    mapObject(X, Y, 'P'),
    Y1 is Y-1,
    encounterWater(X, Y1), !.

w :-
    startGame(false), !,
	write('Game has not started, use \'start.\' to play the game').

w :-
    hitEdge.

% Move Right(d)

% Ketemu Objektif
d :- 
    startGame(true),
    mapObject(X,Y,'P'),
    X1 is X+1,
    (encounterMarket(X1, Y);
    encounterRanch(X1, Y);
    encounterHouse(X1, Y);
    encounterQuest(X1, Y)), !,
    retract(mapObject(X, Y, 'P')),
    asserta(mapObject(X1,Y,'P')).

% Move berhasil
d:- 
	startGame(true),
    mapObject(X,Y,'P'),
    X1 is X+1,
    (\+ mapObject(X1, Y, 'o')),
    mapSize(W, _),
    X1 > 0, X1 =< W, !,
    retract(mapObject(X, Y, 'P')),
    asserta(mapObject(X1,Y,'P')),
    write('You moved right.').

% Ketemu air
d :-
    startGame(true),
    mapObject(X, Y, 'P'),
    X1 is X+1,
    encounterWater(X1, Y), !.

d :-
    startGame(false), !,
	write('Game has not started, use \'start.\' to play the game').

d :-
    hitEdge.

% Move Down(s)
% Ketemu Objektif
s :- 
    startGame(true),
    mapObject(X,Y,'P'),
    Y1 is Y+1,
    (encounterMarket(X, Y1);
    encounterRanch(X, Y1);
    encounterHouse(X, Y1);
    encounterQuest(X, Y1)), !,
    retract(mapObject(X, Y, 'P')),
    asserta(mapObject(X,Y1,'P')).

% Move berhasil
s :- 
	startGame(true),
    mapObject(X,Y,'P'),
    Y1 is Y+1,
    (\+ mapObject(X, Y1, 'o')),
    mapSize(_, H),
    Y1 > 0, Y1 =< H, !,
    retract(mapObject(X, Y, 'P')), 
    asserta(mapObject(X,Y1,'P')),
    write('You moved down.').

% Ketemu air
s :-
    startGame(true),
    mapObject(X, Y, 'P'),
    Y1 is Y+1,
    encounterWater(X, Y1), !.

s :-
    startGame(false), !,
	write('Game has not started, use \'start.\' to play the game').

s :-
    hitEdge.

% Move Left(d)
% Ketemu Objektif
a :- 
    startGame(true),
    mapObject(X,Y,'P'),
    X1 is X-1,
    (encounterMarket(X1, Y);
    encounterRanch(X1, Y);
    encounterHouse(X1, Y);
    encounterQuest(X1, Y)), !,
    retract(mapObject(X, Y, 'P')),
    asserta(mapObject(X1,Y,'P')).

% move berhasil
a :- 
	startGame(true),
    mapObject(X,Y,'P'),
    X1 is X-1,
    (\+ mapObject(X1, Y, 'o')),
    mapSize(W, _),
    X1 > 0, X1 =< W, !,
    retract(mapObject(X, Y, 'P')),
    asserta(mapObject(X1,Y,'P')),
    write('You moved left').


% Ketemu air
a :-
    startGame(true),
    mapObject(X, Y, 'P'),
    X1 is X-1,
    encounterWater(X1, Y), !.

a :-
    startGame(false), !,
	write('Game has not started, use \'start.\' to play the game').

a :-
    hitEdge.