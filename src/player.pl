:- dynamic(player/10).
:- dynamic(job/1).
:- dynamic(level/1).
:- dynamic(farmLevel/1).
:- dynamic(farmExp/1).
:- dynamic(fishingLevel/1).
:- dynamic(fishingExp/1).
:- dynamic(ranchingLevel/1).
:- dynamic(ranchingExp/1).
:- dynamic(exp/1).
:- dynamic(baseExp/1).
:- dynamic(gold/1).

% job('').
% level(1).
% farmLevel(1). 
% farmExp (1).
% fishingLevel(1). 
% fishingExp(1).
% ranchLevel(1).
% ranchExp(1).    
% exp(1).
% baseExp(1). 
% gold(1).

initPlayer :-   write('In order to play, please choose your role in this world(1-3).'), nl,
                write('1. Fisherman'), nl,
                write('2. Farmer'), nl,
                write('3. Rancher'), nl,
                read(Input), nl, 
                (Input =:= 1 -> asserta(job('Fisherman')), asserta(level(1)), asserta(farmLevel(1)), asserta(farmExp(56)), asserta(fishingLevel(1)), asserta(fishingExp(76)), asserta(ranchLevel(1)), asserta(ranchExp(56)), asserta(exp(0)), asserta(baseExp(300)), asserta(gold(500));
                Input =:= 2 -> asserta(job('Farmer')), asserta(level(1)), asserta(farmLevel(1)), asserta(farmExp(76)), asserta(fishingLevel(1)), asserta(fishingExp(56)), asserta(ranchLevel(1)), asserta(ranchExp(56)), asserta(exp(0)), asserta(baseExp(300)), asserta(gold(500));
                Input =:= 3 -> asserta(job('Rancher')), asserta(level(1)), asserta(farmLevel(1)), asserta(farmExp(56)), asserta(fishingLevel(1)), asserta(fishingExp(56)), asserta(ranchLevel(1)), asserta(ranchExp(76)), asserta(exp(0)), asserta(baseExp(300)), asserta(gold(500));
                write('Wrong input! Please input the right command'), nl, initPlayer).

initPlayer :-   write('The player has already created, you can\'t initialize again.').

status :-       job(A),
                level(B),
                farmLevel(C), 
                farmExp(D),
                fishingLevel(E), 
                fishingExp(F),
                ranchingLevel(G),
                ranchingExp(H),    
                exp(I),
                baseExp(J), 
                gold(K),
                write('  _// //  _/// _//////      _/       _/// _//////_//     _//  _// //  '), nl,
                write('_//    _//     _//         _/ //          _//    _//     _//_//    _//'), nl,
                write(' _//           _//        _/  _//         _//    _//     _// _//      '), nl,
                write('   _//         _//       _//   _//        _//    _//     _//   _//    '), nl,    
                write('      _//      _//      _////// _//       _//    _//     _//      _// '), nl,
                write('_//    _//     _//     _//       _//      _//    _//     _//_//    _//'), nl,
                write('  _// //       _//    _//         _//     _//      _/////     _// //  '), nl, nl,
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