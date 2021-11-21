:- dynamic(player/10).

% player(Job, Level, FarmLevel, FarmExp, FishingLevel, FishingExp, RanchLevel, RanchExp, Exp, BaseExp, Gold)
% player(A,B,C,D,E,F,G,H,I,J,K)

initPlayer :-   write('In order to play, please choose your role in this world.'), nl,
                write('1. Fisherman'), nl,
                write('2. Farmer'), nl,
                write('3. Rancher'), nl,
                read(Input), nl, 
                (Input =:= 1, asserta(player('Fisherman', 1, 1, 76, 1, 56, 1, 56, 0, 300, 1000));
                Input =:= 2, asserta(player('Farmer', 1, 1, 56, 1, 76, 1, 56, 0, 300, 1000));
                Input =:= 3, asserta(player('Rancher', 1, 1, 56, 1, 56, 1, 76, 0, 300, 1000))).

status :-   player(A,B,C,D,E,F,G,H,I,J,K),
            write('  _// //  _/// _//////      _/       _/// _//////_//     _//  _// //  '), nl,
            write('_//    _//     _//         _/ //          _//    _//     _//_//    _//'), nl,
            write(' _//           _//        _/  _//         _//    _//     _// _//      '), nl,
            write('   _//         _//       _//   _//        _//    _//     _//   _//    '), nl,    
            write('      _//      _//      _////// _//       _//    _//     _//      _// '), nl,
            write('_//    _//     _//     _//       _//      _//    _//     _//_//    _//'), nl,
            write('  _// //       _//    _//         _//     _//      _/////     _// //  '), nl,
            write('Job              : '), write(A), nl,
            write('Level            : '), write(B), nl,
            write('Farming Level    : '), write(C), nl,
            write('Farming Exp      : '), write(D), nl,
            write('Fishing Level    : '), write(E), nl,
            write('Fishing Exp      : '), write(F), nl, 
            write('Ranching Level   : '), write(G), nl,
            write('Ranching Exp     : '), write(H), nl,
            write('Exp              : '), write(I), write('/'), write(J), nl,
            write('Gold             : '), write(K).
