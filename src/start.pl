:- dynamic(startGame/1).
:- include('player.pl').
:- include('map.pl').
:- include('quest.pl').
:- include('house.pl').
:- include('fishing.pl').
:- include('ranching.pl').
:- include('farming.pl').
:- include('alchemist.pl').
:- include('marketplace.pl').
:- include('move.pl').
:- include('help.pl').
:- include('inventory.pl').
:- include('items.pl').
:- include('musim.pl').



startGame(false).

start :-
    retract(startGame(false)), !,
    asserta(startGame(true)),

    write('\'##:::::\'##:\'########:\'##::::::::\'######:::\'#######::\'##::::\'##:\'########:'), nl,
    write(' ##:\'##: ##: ##.....:: ##:::::::\'##... ##:\'##.... ##: ###::\'###: ##.....::'), nl,
    write(' ##: ##: ##: ##::::::: ##::::::: ##:::..:: ##:::: ##: ####\'####: ##:::::::'), nl,
    write(' ##: ##: ##: ######::: ##::::::: ##::::::: ##:::: ##: ## ### ##: ######:::'), nl,
    write(' ##: ##: ##: ##...:::: ##::::::: ##::::::: ##:::: ##: ##. #: ##: ##...::::'), nl,
    write(' ##: ##: ##: ##::::::: ##::::::: ##::: ##: ##:::: ##: ##:.:: ##: ##:::::::'), nl,
    write('. ###. ###:: ########: ########:. ######::. #######:: ##:::: ##: ########:'), nl,
    write(':...::...:::........::........:::......::::.......:::..:::::..::........::'), nl,

    write('::::::::::::::::::::::::::\'########::\'#######:::::::::::::::::::::::::::::'), nl,
    write('::::::::::::::::::::::::::... ##..::\'##.... ##::::::::::::::::::::::::::::'), nl,
    write('::::::::::::::::::::::::::::: ##:::: ##:::: ##::::::::::::::::::::::::::::'), nl,
    write('::::::::::::::::::::::::::::: ##:::: ##:::: ##::::::::::::::::::::::::::::'), nl,
    write('::::::::::::::::::::::::::::: ##:::: ##:::: ##::::::::::::::::::::::::::::'), nl,
    write('::::::::::::::::::::::::::::: ##:::: ##:::: ##::::::::::::::::::::::::::::'), nl,
    write('::::::::::::::::::::::::::::: ##::::. #######:::::::::::::::::::::::::::::'), nl,
    write(':::::::::::::::::::::::::::::..::::::.......::::::::::::::::::::::::::::::'), nl,
    
    write(':::::::::\'###::::\'########:::\'######:::::\'###::::\'##::: ##:\'########::::::'), nl,
    write('::::::::\'## ##::: ##.... ##:\'##... ##:::\'## ##::: ###:: ##: ##.....:::::::'), nl,
    write(':::::::\'##:. ##:: ##:::: ##: ##:::..:::\'##:. ##:: ####: ##: ##::::::::::::'), nl,
    write('::::::\'##:::. ##: ########:: ##:::::::\'##:::. ##: ## ## ##: ######::::::::'), nl,
    write(':::::: #########: ##.. ##::: ##::::::: #########: ##. ####: ##...:::::::::'), nl,
    write(':::::: ##.... ##: ##::. ##:: ##::: ##: ##.... ##: ##:. ###: ##::::::::::::'), nl,
    write(':::::: ##:::: ##: ##:::. ##:. ######:: ##:::: ##: ##::. ##: ########::::::'), nl,
    write('::::::..:::::..::..:::::..:::......:::..:::::..::..::::..::........:::::::'), nl,nl,

    initPlayer, 

    repeat,
    checkLevelUp,
    nl, write('> '),
    (checkEndGame, !;
    (catch(read(X), _, true), true), (X == 'exit' -> !, write('Thank you for wasting such a precious time to play this game :)'), nl; 
    true(_), (catch(call(X), _, write('Wrong command, use \'help.\' to check all the valid command in ARCANE.')), fail))).

start :-
    write('The game has already started. Use \'help.\' to look at available commands!').

resetGame :-
    retract(startGame(_)),
    asserta(startGame(false)),
    retract(job(_)),
    retract(level(_)),
    retract(farmingLevel(_)), 
    retract(farmingExp(_)),
    retract(fishingLevel(_)), 
    retract(fishingExp(_)),
    retract(ranchingLevel(_)),
    retract(ranchingExp(_)),    
    retract(exp(_)),
    retract(baseExp(_)), 
    retract(gold(_)),
    retract(totalGold(_)),
    retract(day(_)),
    retract(energy(_)),
    retract(mapObject(_,_,'P')),
    asserta(mapObject(8,7,'P')),
    write('RESETTTTTTTTTTTTTTTTTTTTTTTTTTTT'), nl, nl, nl, nl,
    start.