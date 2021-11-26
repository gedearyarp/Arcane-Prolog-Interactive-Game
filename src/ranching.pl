:- dynamic(expRanching/2).
:- dynamic(levelRanching/2).
:- dynamic(fedAnimal/2).
:- dynamic(exp/2).

/* To Do:
    - validate player's location in ranch atau ga
    - cara buat access owned animal masih not fixed
    - insert ranch production to player's inventory
    - state fedAnimal(Player, Animal) YANG DI ASSERTA harus di retract pas bobo biar feeding sekali sehari
    - state cooldown(Animal, 0) reset balik ke max pas lagi bobo  */


/* Animal List */
isAnimal(chicken).
isAnimal(sheep).
isAnimal(cow).
isAnimal(goat).


/* Animal Cooldown List (based on player's ranching level) */
/* Level 1 */
cooldownAnimal(1, chicken, 3).
cooldownAnimal(1, sheep, 7).
cooldownAnimal(1, cow, 6).
cooldownAnimal(1, goat, 4).
/* Level 2 */
cooldownAnimal(2, chicken, 2).
cooldownAnimal(2, sheep, 6).
cooldownAnimal(2, cow, 5).
cooldownAnimal(2, goat, 3).
/* Level 3 */
cooldownAnimal(3, chicken, 2).
cooldownAnimal(3, sheep, 5).
cooldownAnimal(3, cow, 4).
cooldownAnimal(3, goat, 3).
/* Level 4 */
cooldownAnimal(4, chicken, 1).
cooldownAnimal(4, sheep, 4).
cooldownAnimal(4, cow, 3).
cooldownAnimal(4, goat, 2).
/* Level 5 */
cooldownAnimal(5, chicken, 1).
cooldownAnimal(5, sheep, 3).
cooldownAnimal(5, cow, 2).
cooldownAnimal(5, goat, 1).


/* Animal Production Exp List */
expAnimalProduction(egg, 12).
expAnimalProduction(wool, 30).
expAnimalProduction(cow_milk, 25).
expAnimalProduction(goat_milk, 20).


/* Add Ranching Exp */
/* Ranching exp calculation */
ranchingExp(Animal, Count, RanchingExp) :-
    (speciality(Player, ranching) ->
    expAnimalProduction(Animal, ExpAnimal),
    TotalExpAnimal is ExpAnimal * Count
    ExpSpeciality is round(0.2 * TotalExpAnimal),
    RanchingExp is TotalExpAnimal + ExpSpeciality;

    \+speciality(Player, ranching) ->
    expAnimalProduction(Animal, ExpAnimal),
    TotalExpAnimal is ExpAnimal * Count,
    RanchingExp is TotalExpAnimal).
/* Adding ranching exp to player state */
addRanchingExp(Player, RanchingExp) :-    
    expRanching(Player, PrevExp),
    exp(Player, PrevGeneralExp),
    levelRanching(Player, Level),
    retract(expRanching(Player, PrevExp)),
    retract(exp(Player, PrevGeneralExp)),
    CurrentExp is PrevExp + RanchingExp,
    CurrentGeneralExp is PrevGeneralExp + RanchingExp,
    write('You gained '), write(RanchingExp), write(' ranching exp!'), nl,

    (Level < 2, CurrentExp >= 500 ->
    retract(levelRanching(Player, Level)),
    asserta(levelRanching(Player, 2)),
    FinalExp is CurrentExp - 500,
    asserta(expRanching(Player, FinalExp)),
    write('Level up! Yey naik ke level 2'), nl;

    Level < 3, CurrentExp >= 1000 ->
    retract(levelRanching(Player, Level)),
    asserta(levelRanching(Player, 3)),
    FinalExp is CurrentExp - 1000,
    asserta(expRanching(Player, FinalExp)),
    write('Level up! Yey naik ke level 3'), nl;

    Level < 4, CurrentExp >= 2000 ->
    retract(levelRanching(Player, Level)),
    asserta(levelRanching(Player, 4)),
    FinalExp is CurrentExp - 2000,
    asserta(expRanching(Player, FinalExp)),
    write('Level up! Yey naik ke level 4'), nl;

    Level < 5, CurrentExp >= 5000 ->
    retract(levelRanching(Player, Level)),
    asserta(levelRanching(Player, 5)),
    FinalExp is CurrentExp - 5000,
    asserta(expRanching(Player, FinalExp)),
    write('Level up! Yey naik ke level 5,, wah keren bangeDDDzz level maksimum'), nl;

    asserta(exp(Player, CurrentGeneralExp)),
    asserta(expRanching(Player, CurrentExp))).


/* Feeding */
/* Reduction process */
feedReduction(AnimalFeed, Count) :-
    retract(inventory(Player, AnimalFeed, PrevQty)),    
    CurrentQty is PrevQty - Count,
    asserta(inventory(Player, AnimalFeed, CurrentQty)).   
feedCooldown(Animal) :-
    cooldown(Animal, PrevCooldown),
    retract(cooldown(Animal, PrevCooldown)),
    CurrentCooldown is PrevCooldown - 1,
    asserta(cooldown(Animal, CurrentCooldown)).
/* Feeding process */    
feedChicken :-
    (\+inventory(Player, chicken, _) ->
    write('You don\'t have chicken! Go buy some in the marketplace!'), nl;
    
    inventory(Player, chicken, Count),
    inventory(Player, chicken_feed, Qty),
    
    (\+fedAnimal(Player, chicken) ->
    (Qty < Count ->
    write('You don\'t have enough chicken feed.'), nl;

    feedReduction(chicken_feed, Count),
    feedCooldown(chicken),
    asserta(fedAnimal(Player, chicken)),
    write('You finished feeding your chicken(s).'), nl);
    
    fedAnimal(Player, chicken) ->
    write('You already fed your chicken(s)'), nl)).
feedCow :-
    (\+inventory(Player, cow, _) ->
    write('You don\'t have cow! Go buy some in the marketplace!'), nl;
    
    inventory(Player, cow, Count),
    inventory(Player, cow_feed, Qty),

    (\+fedAnimal(Player, cow) ->   
    (Qty < Count ->
    write('You don\'t have enough cow feed.'), nl;

    feedReduction(cow_feed, Count),
    feedCooldown(cow),
    asserta(fedAnimal(Player, cow)),
    write('You finished feeding your cow(s).'), nl);
    
    fedAnimal(Player, cow) ->
    write('You already fed your cow(s).'), nl)).
feedSheep :-
    (\+inventory(Player, sheep, _) ->
    write('You don\'t have sheep! Go buy some in the marketplace!'), nl;
    
    inventory(Player, sheep, Count),
    inventory(Player, sheep_feed, Qty),
    
    (\+fedAnimal(Player, sheep) ->     
    (Qty < Count ->
    write('You don\'t have enough sheep feed.'), nl;

    feedReduction(sheep_feed, Count),
    feedCooldown(sheep),
    asserta(fedAnimal(Player, sheep)),    
    write('You finished feeding your sheep(s).'), nl);
    
    fedAnimal(Player, sheep) ->
    write('You already fed your cow(s).'), nl)).
feedGoat :-
    (\+inventory(Player, goat, _) ->
    write('You don\'t have goat! Go buy some in the marketplace!'), nl;
    
    inventory(Player, goat, Count),
    inventory(Player, goat_feed, Qty),
    
    (\+fedAnimal(Player, goat) ->     
    (Qty < Count ->
    write('You don\'t have enough goat feed.'), nl;

    feedReduction(goat_feed, Count),
    feedCooldown(goat),
    asserta(fedAnimal(Player, goat)),      
    write('You finished feeding your goat(s).'), nl);
    
    fedAnimal(Player, goat) ->
    write('You already fed your goat(s).'), nl)).


/* Collecting Animal Production */
chicken :-
    (\+inventory(Player, chicken, _) ->
    write('You don\'t have chicken! Go buy some in the marketplace!'), nl;
    
    inventory(Player, chicken, Count),
    levelRanching(Player, Level),
    cooldownAnimal(Level, chicken, MaxCooldown),
    cooldown(chicken, CurrentCooldown),
    
    (CurrentCooldown =:= MaxCooldown ->
    write('You collected '), write(Count), write(' egg(s)!'), nl,
    ranchingExp(chicken, Count, RanchingExp),
    addRanchingExp(Player, RanchingExp);
    
    write('There are no eggs yet...'), nl)).
cow :-
    (\+inventory(Player, cow, _) ->
    write('You don\'t have cow! Go buy some in the marketplace!'), nl;
    
    inventory(Player, cow, Count),
    levelRanching(Player, Level),
    cooldownAnimal(Level, cow, MaxCooldown),
    cooldown(cow, CurrentCooldown),
    
    (CurrentCooldown =:= MaxCooldown ->
    write('You collected '), write(Count), write(' bottle(s) of cow milk!'), nl,
    ranchingExp(cow, Count, RanchingExp),
    addRanchingExp(Player, RanchingExp);
    
    write('There is no cow milk yet...'), nl)).
sheep :-
    (\+inventory(Player, sheep, _) ->
    write('You don\'t have sheep! Go buy some in the marketplace!'), nl;
    
    inventory(Player, sheep, Count),
    levelRanching(Player, Level),
    cooldownAnimal(Level, sheep, MaxCooldown),
    cooldown(sheep, CurrentCooldown),
    
    (CurrentCooldown =:= MaxCooldown ->
    write('You collected '), write(Count), write(' wool(s)!'), nl,
    ranchingExp(sheep, Count, RanchingExp),
    addRanchingExp(Player, RanchingExp);
    
    write('Your sheep is still bald...'), nl)).
goat :-
    (\+inventory(Player, goat, _) ->
    write('You don\'t have goat! Go buy some in the marketplace!'), nl;
    
    inventory(Player, goat, Count),
    levelRanching(Player, Level),
    cooldownAnimal(Level, goat, MaxCooldown),
    cooldown(goat, CurrentCooldown),
    
    (CurrentCooldown =:= MaxCooldown ->
    write('You got '), write(Count), write(' bottle(s) of goat milk!'), nl,
    ranchingExp(goat, Count, RanchingExp),
    addRanchingExp(Player, RanchingExp);
    
    write('There is no goat milk yet...'), nl)).


/* Ranching */
ranch :-
    write('Welcome to the ranch!'), 
    
    (\+inventory(Player, chicken, _), \+inventory(Player, sheep, _), \+inventory(Player, cow, _), \+inventory(Player, goat, _) ->
    write('You have no animals. Go buy some in the marketplace!'), nl;
    
    write('You have:'), nl,
    (inventory(Player, chicken, Count) ->
    write(Count), write(' chicken'), nl;
    write('')),
    
    (inventory(Player, sheep, Count) ->
    write(Count), write(' sheep'), nl;
    write('')),

    (inventory(Player, cow, Count) ->
    write(Count), write(' cow'), nl;
    write('')),

    (inventory(Player, goat, Count) ->
    write(Count), write(' goat'), nl;
    write('')),
      
    write('What do you want to do?'), nl).
