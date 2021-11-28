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
:- dynamic(totalGold/1).
:- dynamic(day/1).
:- dynamic(energy/1).


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
                addItem(knife), addItem(shovel), addItem(fishing_rod),
                asserta(equipment(knife, 1)), asserta(equipment(shovel, 1)), asserta(equipment(fishing_rod, 1)),
                (Input =:= 1 -> asserta(job('Fisherman')), asserta(level(1)), asserta(farmingLevel(1)), asserta(farmingExp(56)), asserta(fishingLevel(1)), asserta(fishingExp(76)), asserta(ranchingLevel(1)), asserta(ranchingExp(56)), asserta(exp(0)), asserta(baseExp(300)), asserta(gold(500)), asserta(day(1)), asserta(totalGold(500)), asserta(energy(100));
                Input =:= 2 -> asserta(job('Farmer')), asserta(level(1)), asserta(farmingLevel(1)), asserta(farmingExp(76)), asserta(fishingLevel(1)), asserta(fishingExp(56)), asserta(ranchingLevel(1)), asserta(ranchingExp(56)), asserta(exp(0)), asserta(baseExp(300)), asserta(gold(500)), asserta(day(1)), asserta(totalGold(500)), asserta(energy(100));
                Input =:= 3 -> asserta(job('Rancher')), asserta(level(1)), asserta(farmingLevel(1)), asserta(farmingExp(56)), asserta(fishingLevel(1)), asserta(fishingExp(56)), asserta(ranchingLevel(1)), asserta(ranchingExp(76)), asserta(exp(0)), asserta(baseExp(300)), asserta(gold(500)), asserta(day(1)), asserta(totalGold(500)), asserta(energy(100));
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
                day(Day),
                totalGold(Total),
                energy(Energy),
                currentSeason(Season),
                seasonName(Season, SName),
                writeStatusBanner,
                write('Job              : '), write(A), nl,
                write('Energy           : '), write(Energy), write('/'), write('100'), nl,
                write('Level            : '), write(B), nl,
                write('Farming Level    : '), write(C), nl,
                write('Farming Exp      : '), write(D), nl,
                write('Fishing Level    : '), write(E), nl,
                write('Fishing Exp      : '), write(F), nl, 
                write('Ranching Level   : '), write(G), nl,
                write('Ranching Exp     : '), write(H), nl,
                write('Exp              : '), write(I), write('/'), write(J), nl,
                write('Gold             : '), write(K), nl,
                write('Current Day      : '), write(Day), nl,
                write('Total Gold       : '), write(Total), nl,
                write('Current Season   : '), write(SName), nl,
                !.

writeStatusBanner :-
    write(':\'######::\'########::::\'###::::\'########:\'##::::\'##::\'######::'), nl,
    write('\'##... ##:... ##..::::\'## ##:::... ##..:: ##:::: ##:\'##... ##:'), nl,
    write(' ##:::..::::: ##:::::\'##:. ##::::: ##:::: ##:::: ##: ##:::..::'), nl,
    write('. ######::::: ##::::\'##:::. ##:::: ##:::: ##:::: ##:. ######::'), nl,    
    write(':..... ##:::: ##:::: #########:::: ##:::: ##:::: ##::..... ##:'), nl,
    write('\'##::: ##:::: ##:::: ##.... ##:::: ##:::: ##:::: ##:\'##::: ##:'), nl,
    write('. ######::::: ##:::: ##:::: ##:::: ##::::. #######::. ######::'), nl,
    write(':......::::::..:::::..:::::..:::::..::::::.......::::......:::'), nl, nl,
    !.

writeLevelUpBanner :-

write('\'##:::::::\'########:\'##::::\'##:\'########:\'##::::::::::\'##:::\'##:\'########::\'####:\'####:\'####:'), nl,
write(' ##::::::: ##.....:: ##:::: ##: ##.....:: ##:::::::::: ##:::: ##: ##.... ##: ####: ####: ####:'), nl,
write(' ##::::::: ##::::::: ##:::: ##: ##::::::: ##:::::::::: ##:::: ##: ##:::: ##: ####: ####: ####:'), nl,
write(' ##::::::: ######::: ##:::: ##: ######::: ##:::::::::: ##:::: ##: ########::: ##::: ##::: ##::'), nl,
write(' ##::::::: ##...::::. ##:: ##:: ##...:::: ##:::::::::: ##:::: ##: ##.....::::..::::..::::..:::'), nl,
write(' ##::::::: ##::::::::. ## ##::: ##::::::: ##:::::::::: ##:::: ##: ##::::::::\'####:\'####:\'####:'), nl,
write(' ########: ########:::. ###:::: ########: ########::::. #######:: ##:::::::: ####: ####: ####:'), nl,
write('........::........:::::...:::::........::........::::::.......:::..:::::::::....::....::....::'), nl, nl.


checkEndGame :-
    totalGold(TotalGold),
    (TotalGold >= 20000 ->
    write('Congratulations! Akhirnya kelar juga nih game.'),nl,
    write('Ini adalah stats terakhir kamu: '),
    status,
    write('Bye-bye! Selamat menderita kembali ^_^')).

levelUp(Exp, BaseExp) :-

    gold(CurrGold),
    totalGold(TotalGold),

    % Level 1
    (BaseExp == 300 ->
    Exp >= BaseExp, 
    retract(level(_)),
    asserta(level(2)),
    NewExp is Exp-BaseExp,
    retract(exp(_)),
    asserta(exp(NewExp)),
    retract(baseExp(_)),
    asserta(baseExp(500)),
    NewCurrGold is CurrGold + 300,
    retract(gold(_)),
    asserta(gold(NewCurrGold)),
    NewTotalGold is TotalGold + 300,
    retract(totalGold(_)),
    asserta(totalGold(NewTotalGold)),
    writeLevelUpBanner,
    write('Congratulations you got 300 Gold as and advantage of leveling up :D'), nl;

    % Level 2
    BaseExp == 500 ->
    Exp >= BaseExp, 
    retract(level(_)),
    asserta(level(3)),
    NewExp is Exp-BaseExp,
    retract(exp(_)),
    asserta(exp(NewExp)),
    retract(baseExp(_)),
    asserta(baseExp(1000)),
    NewCurrGold is CurrGold + 500,
    retract(gold(_)),
    asserta(gold(NewCurrGold)),
    NewTotalGold is TotalGold + 500,
    retract(totalGold(_)),
    asserta(totalGold(NewTotalGold)),
    writeLevelUpBanner,
    write('Congratulations you got 500 Gold as and advantage of leveling up :D'), nl;

    % Level 3
    BaseExp == 1000 ->
    Exp >= BaseExp, 
    retract(level(_)),
    asserta(level(4)),
    NewExp is Exp-BaseExp,
    retract(exp(_)),
    asserta(exp(NewExp)),
    retract(baseExp(_)),
    asserta(baseExp(2000)),
    NewCurrGold is CurrGold + 1000,
    retract(gold(_)),
    asserta(gold(NewCurrGold)),
    NewTotalGold is TotalGold + 1000,
    retract(totalGold(_)),
    asserta(totalGold(NewTotalGold)),
    writeLevelUpBanner,
    write('Congratulations you got 1000 Gold as and advantage of leveling up :D'), nl;

    % Level 4
    BaseExp == 2000 ->
    Exp >= BaseExp, 
    retract(level(_)),
    asserta(level(5)),
    NewExp is Exp-BaseExp,
    retract(exp(_)),
    asserta(exp(NewExp)),
    retract(baseExp(_)),
    asserta(baseExp(99999999)),
    NewCurrGold is CurrGold + 2000,
    retract(gold(_)),
    asserta(gold(CurrGold+2000)),
    NewTotalGold is TotalGold + 2000,
    retract(totalGold(_)),
    asserta(totalGold(NewTotalGold)),
    writeLevelUpBanner,
    write('Congratulations you got 2000 Gold as and advantage of leveling up :D'), nl,
    write('MENTOK NIIII BOS'), nl;

    BaseExp > 2000).

checkLevelUp :-
    exp(Exp),
    baseExp(BaseExp),

    (Exp >= BaseExp -> levelUp(Exp, BaseExp);
    Exp < BaseExp).

cheatGold :-
    retract(gold(_)),
    asserta(gold(999999)),
    !.

reduceEnergy(Power) :-
    energy(PrevEnergy),
    retract(energy(PrevEnergy)),
    CurrentEnergy is PrevEnergy - Power,
    (CurrentEnergy < 1 -> CurrentEnergy is 1; write('')),
    asserta(energy(CurrentEnergy)).

increaseEnergy(Power) :-
    energy(PrevEnergy),
    retract(energy(PrevEnergy)),
    CurrentEnergy is PrevEnergy + Power,
    (CurrentEnergy > 100 -> CurrentEnergy is 100; write('')),
    write('Somehow, you feel more energized.'), nl,
    asserta(energy(CurrentEnergy)).