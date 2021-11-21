:- dynamic(mapObject/3).

mapObject(7, 3, 'Q').
mapObject(10, 5, 'R').
mapObject(7, 6, 'H').
mapObject(8, 7, 'P').
mapObject(5, 8, 'o').
mapObject(6, 8, 'o').
mapObject(7, 8, 'o').
mapObject(4, 9, 'o').
mapObject(5, 9, 'o').
mapObject(6, 9, 'o').
mapObject(7, 9, 'o').
mapObject(8, 9, 'o').
mapObject(5, 10, 'o').
mapObject(6, 10, 'o').
mapObject(7, 10, 'o').
mapObject(10, 12, 'M').


mapSize(14, 17).

map :- startGame(true), !, drawMap.

% DRAW BORDERS
% Right
drawPoint(X, Y) :- mapSize(W, H),
                    X =:= W + 1,
                    Y =< H + 1,
                    write('# '), nl,
                    Y1 is Y+1,
                    drawPoint(0, Y1).

% Left
drawPoint(X, Y) :- mapSize(_, H),
                    X =:= 0,
                    Y =< H + 1,
                    write('# '),
                    X1 is X + 1,
                    drawPoint(X1, Y).

% Top
drawPoint(X, Y) :- mapSize(W, _),
                    X < W + 1,
                    X > 0,
                    Y =:= 0,
                    write('# '),
                    X1 is X + 1, 
                    drawPoint(X1, Y).

% Bottom
drawPoint(X, Y) :- mapSize(W, H),
                    X < W + 1,
                    X > 0,
                    Y =:= H + 1,
                    write('# '),
                    X1 is X + 1,
                    drawPoint(X1, Y).
					
% DRAW MAP INSIDE
drawPoint(X, Y) :- mapSize(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					mapObject(X, Y, Obj), !,
					write(Obj),
                    write(' '),
					X1 is X+1,
					drawPoint(X1, Y).

% Empty tile
drawPoint(X, Y) :- mapSize(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					(\+ mapObject(X, Y, _)),
					write('_ '),
					X1 is X+1,
					drawPoint(X1, Y).


drawMap :- drawPoint(0, 0).