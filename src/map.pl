:- dynamic(map_object/3).

map_object(7, 3, 'Q').
map_object(10, 5, 'R').
map_object(7, 6, 'H').
map_object(8, 7, 'p').
map_object(5, 8, 'o').
map_object(6, 8, 'o').
map_object(7, 8, 'o').
map_object(4, 9, 'o').
map_object(5, 9, 'o').
map_object(6, 9, 'o').
map_object(7, 9, 'o').
map_object(8, 9, 'o').
map_object(5, 10, 'o').
map_object(6, 10, 'o').
map_object(7, 10, 'o').
map_object(10, 12, 'M').


map_size(14, 17).

map :- start_game(true), !, draw_map.

% DRAW BORDERS
% Right
draw_point(X, Y) :- map_size(W, H),
                    X =:= W + 1,
                    Y =< H + 1,
                    write('# '), nl,
                    Y1 is Y+1,
                    draw_point(0, Y1).

% Left
draw_point(X, Y) :- map_size(_, H),
                    X =:= 0,
                    Y =< H + 1,
                    write('# '),
                    X1 is X + 1,
                    draw_point(X1, Y).

% Top
draw_point(X, Y) :- map_size(W, _),
                    X < W + 1,
                    X > 0,
                    Y =:= 0,
                    write('# '),
                    X1 is X + 1, 
                    draw_point(X1, Y).

% Bottom
draw_point(X, Y) :- map_size(W, H),
                    X < W + 1,
                    X > 0,
                    Y =:= H + 1,
                    write('# '),
                    X1 is X + 1,
                    draw_point(X1, Y).
					
% DRAW MAP INSIDE
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					map_object(X, Y, Obj), !,
					write(Obj),
                    write(' '),
					X1 is X+1,
					draw_point(X1, Y).

% Empty tile
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					(\+ map_object(X, Y, _)),
					write('_ '),
					X1 is X+1,
					draw_point(X1, Y).


draw_map :- draw_point(0, 0).