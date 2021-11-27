:- dynamic(player/10).
:- dynamic(job/1).
:- dynamic(level/1).
:- dynamic(farmingLevel/1).
:- dynamic(farmingExp/1).
:- dynamic(fishingLevel/1).
:- dynamic(fishingExp/1).
:- dynamic(ranchingLevel/1).
:- dynamic(ranchingExp/1).
:- dynamic(exp/1).
:- dynamic(baseExp/1).
:- dynamic(gold/1).

% job('').
% level(1).
% farmingLevel(1). 
% farmingExp (1).
% fishingLevel(1). 
% fishingExp(1).
% ranchingLevel(1).
% ranchingExp(1).    
% exp(1).
% baseExp(1). 
% gold(1).

initPlayer :-   write('In order to play, please choose your role in this world(1-3).'), nl,
                write('1. Fisherman'), nl,
                write('2. Farmer'), nl,
                write('3. Rancher'), nl,
                read(Input), nl, 
                (Input =:= 1 -> asserta(job('Fisherman')), asserta(level(1)), asserta(farmingLevel(1)), asserta(farmingExp(56)), asserta(fishingLevel(1)), asserta(fishingExp(76)), asserta(ranchingLevel(1)), asserta(ranchingExp(56)), asserta(exp(0)), asserta(baseExp(300)), asserta(gold(500));
                Input =:= 2 -> asserta(job('Farmer')), asserta(level(1)), asserta(farmingLevel(1)), asserta(farmingExp(76)), asserta(fishingLevel(1)), asserta(fishingExp(56)), asserta(ranchingLevel(1)), asserta(ranchingExp(56)), asserta(exp(0)), asserta(baseExp(300)), asserta(gold(500));
                Input =:= 3 -> asserta(job('Rancher')), asserta(level(1)), asserta(farmingLevel(1)), asserta(farmingExp(56)), asserta(fishingLevel(1)), asserta(fishingExp(56)), asserta(ranchingLevel(1)), asserta(ranchingExp(76)), asserta(exp(0)), asserta(baseExp(300)), asserta(gold(500));
                write('Wrong input! Please input the right command'), nl, initPlayer).

initPlayer :-   write('The player has already created, you can\'t initialize again.').

status :-       job(A),
                level(B),
                farmingLevel(C), 
                farmingExp(D),
                fishingLevel(E), 
                fishingExp(F),
                ranchingLevel(G),
                ranchingExp(H),    
                exp(I),
                baseExp(J), 
                gold(K),
                write(':\'######::\'########::::\'###::::\'########:\'##::::\'##::\'######::'), nl,
                write('\'##... ##:... ##..::::\'## ##:::... ##..:: ##:::: ##:\'##... ##:'), nl,
                write(' ##:::..::::: ##:::::\'##:. ##::::: ##:::: ##:::: ##: ##:::..::'), nl,
                write('. ######::::: ##::::\'##:::. ##:::: ##:::: ##:::: ##:. ######::'), nl,    
                write(':..... ##:::: ##:::: #########:::: ##:::: ##:::: ##::..... ##:'), nl,
                write('\'##::: ##:::: ##:::: ##.... ##:::: ##:::: ##:::: ##:\'##::: ##:'), nl,
                write('. ######::::: ##:::: ##:::: ##:::: ##::::. #######::. ######::'), nl,
                write(':......::::::..:::::..:::::..:::::..::::::.......::::......:::'), nl, nl,
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