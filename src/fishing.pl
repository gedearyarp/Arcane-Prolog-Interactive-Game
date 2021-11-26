:- dynamic(expFishing/2).
:- dynamic(levelFishing/2).
:- dynamic(exp/2).

/* To Do:
    - validate player's location whether bisa fishing apa gak
    - fishing rod level effect on exp or drop rate
    - insert fish to player's inventory
    - connect perubahan player state di fishing to main  */


/* Fish List */
isFish(carp).
isFish(eel).
isFish(salmon).
isFish(sardine).
isFish(shark).
isFish(tuna).


/* Fish Exp List */
expFish(carp, 8). 
expFish(eel, 15).
expFish(salmon, 18).
expFish(sardine, 12).
expFish(shark, 24).
expFish(tuna, 10).


/* Add Fishing Exp */
/* Fishing exp calculation */
fishingExp(Fish, FishingExp) :-         
    (speciality(Player, fishing) ->
    expFish(Fish, ExpFish),
    ExpSpeciality is round(0.2 * ExpFish),
    FishingExp is ExpFish + ExpSpeciality;

    \+speciality(Player, fishing) ->
    expFish(Fish, ExpFish),
    FishingExp is ExpFish).
/* Adding fishing exp to player state */
addFishingExp(Player, FishingExp) :-    
    expFishing(Player, PrevExp),
    exp(Player, PrevGeneralExp),
    levelFishing(Player, Level),
    retract(expFishing(Player, PrevExp)),
    retract(exp(Player, PrevGeneralExp)),
    CurrentExp is PrevExp + FishingExp,
    CurrentGeneralExp is PrevGeneralExp + FishingExp,
    write('You gained '), write(FishingExp), write(' fishing exp!'), nl,

    (Level < 2, CurrentExp >= 500 ->
    retract(levelFishing(Player, Level)),
    asserta(levelFishing(Player, 2)),
    FinalExp is CurrentExp - 500,
    asserta(expFishing(Player, FinalExp)),
    write('Level up! Yey naik ke level 2'), nl;

    Level < 3, CurrentExp >= 1000 ->
    retract(levelFishing(Player, Level)),
    asserta(levelFishing(Player, 3)),
    FinalExp is CurrentExp - 1000,
    asserta(expFishing(Player, FinalExp)),
    write('Level up! Yey naik ke level 3'), nl;

    Level < 4, CurrentExp >= 2000 ->
    retract(levelFishing(Player, Level)),
    asserta(levelFishing(Player, 4)),
    FinalExp is CurrentExp - 2000,
    asserta(expFishing(Player, FinalExp)),
    write('Level up! Yey naik ke level 4'), nl;

    Level < 5, CurrentExp >= 5000 ->
    retract(levelFishing(Player, Level)),
    asserta(levelFishing(Player, 5)),
    FinalExp is CurrentExp - 5000,
    asserta(expFishing(Player, FinalExp)),
    write('Level up! Yey naik ke level 5,, wah keren bangeDDDzz level maksimum'), nl;

    asserta(exp(Player, CurrentGeneralExp)),
    asserta(expFishing(Player, CurrentExp))).


/* Fish Randomizer */
fishRandomizer(Level, Fish) :-  
    random(1, 100, X),

    (Level =:= 1 ->
    (X =< 30   -> Fish = none;
    X =< 70    -> Fish = carp;
    X =< 100   -> Fish = tuna);

    Level =:= 2 ->
    (X =< 25   -> Fish = none;
    X =< 60    -> Fish = carp;
    X =< 85    -> Fish = tuna;
    X =< 100   -> Fish = sardine);                                

    Level =:= 3 ->
    (X =< 15   -> Fish = none;
    X =< 45    -> Fish = carp;
    X =< 75    -> Fish = tuna;
    X =< 90    -> Fish = sardine;                
    X =< 100   -> Fish = eel);                                

    Level =:= 4 ->
    (X =< 10   -> Fish = none;
    X =< 40    -> Fish = carp;
    X =< 70    -> Fish = tuna;
    X =< 85    -> Fish = sardine;                
    X =< 95    -> Fish = eel;                
    X =< 100   -> Fish = salmon);                                

    Level =:= 5 ->
    (X =< 5    -> Fish = none;
    X =< 25    -> Fish = carp;
    X =< 48    -> Fish = tuna;
    X =< 66    -> Fish = sardine;                
    X =< 81    -> Fish = eel;                
    X =< 93    -> Fish = salmon;
    X =< 100   -> Fish = shark)). 


/* Fishing */
fish :-                         
    levelFishing(Player, Level),                                               
    fishRandomizer(Level, Fish),
    
    (\+isFish(Fish) ->    
    write('You didn\'t get anything!'), nl,
    addFishingExp(Player, 3);

    isFish(Fish) ->
    write('You got '), write(Fish), write('!'), nl,
    fishingExp(Fish, FishingExp),
    addFishingExp(Player, FishingExp)). 