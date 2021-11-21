hitEdge :- 
    write('You\'re in the edge of the map. We are sorry, but you can\'t move any further, try using \'map.\'').

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
    assertz(mapObject(X,Y1,'P')).

% Move berhasil
w :-
	startGame(true),
    mapObject(X,Y,'P'),
    Y1 is Y-1,
    (\+ mapObject(X, Y1, 'o')),
    mapSize(_, H),
    Y1 > 0, Y1 =< H, !,
    retract(mapObject(X, Y, 'P')),
    assertz(mapObject(X,Y1,'P')),
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
    assertz(mapObject(X1,Y,'P')).

% Move berhasil
d:- 
	startGame(true),
    mapObject(X,Y,'P'),
    X1 is X+1,
    (\+ mapObject(X1, Y, 'o')),
    mapSize(W, _),
    X1 > 0, X1 =< W, !,
    retract(mapObject(X, Y, 'P')),
    assertz(mapObject(X1,Y,'P')),
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
    assertz(mapObject(X,Y1,'P')).

% Move berhasil
s :- 
	startGame(true),
    mapObject(X,Y,'P'),
    Y1 is Y+1,
    (\+ mapObject(X, Y1, 'o')),
    mapSize(_, H),
    Y1 > 0, Y1 =< H, !,
    retract(mapObject(X, Y, 'P')), 
    assertz(mapObject(X,Y1,'P')),
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
    assertz(mapObject(X1,Y,'P')).

% move berhasil
a :- 
	startGame(true),
    mapObject(X,Y,'P'),
    X1 is X-1,
    (\+ mapObject(X1, Y, 'o')),
    mapSize(W, _),
    X1 > 0, X1 =< W, !,
    retract(mapObject(X, Y, 'P')),
    assertz(mapObject(X1,Y,'P')),
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