:- dynamic(fedAnimal/2).
:- dynamic(collectAnimal/2).
:- dynamic(cooldownCollect/2).
:- dynamic(inventory/2).

/* To Do:
    - cara buat access owned animal masih not fixed
    - insert ranch production to player's inventory
    - buying animal resulting in:
        cooldownCollect(Animal, Cooldown) --> do nothing if animal is owned; asserta cooldownCollect ngikutin cooldownAnimal if not owned before
        fedAnimal(Animal, Boolean) --> retract and asserta fedAnimal(Animal, true) if animal owned; asserta only if not owned before
        collectAnimal(Animal, Boolean) --> do nothing if animal is owned; asserta collectAnimal(Animal, false) if not owned before
    - pas bobo, kalo ada fedAnimal(Animal, true) --> retract, terus feedCooldown(Animal) */


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
expAnimalProduction(chicken, 12).
expAnimalProduction(sheep, 30).
expAnimalProduction(cow, 25).
expAnimalProduction(goat, 20).


/* TRIAL 
inventory(chicken, 2).
inventory(chicken_feed, 4).
cooldownCollect(chicken, 3).
fedAnimal(chicken, false).
collectAnimal(chicken, true). */


/* Add Ranching Exp */
/* Ranching exp calculation */
expRanching(Animal, Count, RanchingExp) :-
    (job('Rancher') ->
    expAnimalProduction(Animal, ExpAnimal),
    TotalExpAnimal is ExpAnimal * Count,
    ExpSpeciality is round(0.2 * TotalExpAnimal),
    RanchingExp is TotalExpAnimal + ExpSpeciality;

    \+job('Rancher') ->
    expAnimalProduction(Animal, ExpAnimal),
    TotalExpAnimal is ExpAnimal * Count,
    RanchingExp is TotalExpAnimal).
/* Adding ranching exp to player state */
addExpRanching(RanchingExp) :-    
    ranchingExp(PrevExp),
    exp(PrevGeneralExp),
    ranchingLevel(Level),
    retract(ranchingExp(PrevExp)),
    retract(exp(PrevGeneralExp)),
    CurrentExp is PrevExp + RanchingExp,
    CurrentGeneralExp is PrevGeneralExp + RanchingExp,
    write('You gained '), write(RanchingExp), write(' ranching exp!'), nl,

    (Level < 2, CurrentExp >= 500 ->
    retract(ranchingLevel(Level)),
    asserta(ranchingLevel(2)),
    FinalExp is CurrentExp - 500,
    asserta(ranchingExp(FinalExp)),
    write('Level up! Yey naik ke level 2'), nl;

    Level < 3, CurrentExp >= 1000 ->
    retract(ranchingLevel(Level)),
    asserta(ranchingLevel(3)),
    FinalExp is CurrentExp - 1000,
    asserta(ranchingExp(FinalExp)),
    write('Level up! Yey naik ke level 3'), nl;

    Level < 4, CurrentExp >= 2000 ->
    retract(ranchingLevel(Level)),
    asserta(ranchingLevel(4)),
    FinalExp is CurrentExp - 2000,
    asserta(ranchingExp(FinalExp)),
    write('Level up! Yey naik ke level 4'), nl;

    Level < 5, CurrentExp >= 5000 ->
    retract(ranchingLevel(Level)),
    asserta(ranchingLevel(5)),
    FinalExp is CurrentExp - 5000,
    asserta(ranchingExp(FinalExp)),
    write('Level up! Yey naik ke level 5,, wah keren bangeDDDzz level maksimum'), nl;

    asserta(exp(CurrentGeneralExp)),
    asserta(ranchingExp(CurrentExp))).


/* Feeding */
/* Reduction process */
feedReduction(AnimalFeed, Count) :-
    retract(inventory(AnimalFeed, PrevQty)),    
    CurrentQty is PrevQty - Count,
    asserta(inventory(AnimalFeed, CurrentQty)).   
feedCooldown(Animal) :-
    cooldownCollect(Animal, PrevCooldown),
    retract(cooldownCollect(Animal, PrevCooldown)),
    CurrentCooldown is PrevCooldown - 1,

    (CurrentCooldown =:= 0 ->
    ranchingLevel(Level),
    cooldownAnimal(Level, Animal, MaxCooldown),
    asserta(cooldownCollect(Animal, MaxCooldown)),
    retract(collectAnimal(Animal, false)),
    asserta(collectAnimal(Animal, true));  

    asserta(cooldownCollect(Animal, CurrentCooldown))).
/* Feeding process */
feed(Animal) :-
    (\+inventory(Animal, _) ->
    write('You don\'t have '), write(Animal), write('. Go buy some in the marketplace!'), nl;
    
    inventory(Animal, Count),
    (Animal = chicken -> AnimalFeed = chicken_feed;
    Animal = cow -> AnimalFeed = cow_feed;
    Animal = sheep -> AnimalFeed = sheep_feed;
    Animal = goat -> AnimalFeed = goat_feed),
    inventory(AnimalFeed, Qty),
    
    (fedAnimal(Animal, false) ->
    (Qty < Count ->
    write('You don\'t have enough '), write(Animal), write(' feed.'), nl;

    feedReduction(AnimalFeed, Count),
    retract(fedAnimal(Animal, false)),
    asserta(fedAnimal(Animal, true)),
    write('You finished feeding your '), write(Animal), write('(s).'), nl);
    
    fedAnimal(Animal, true) ->
    write('You already fed your '), write(Animal), write('(s).'), nl)).    


/* Collecting Animal Production */
collect(Animal) :-
    (\+inventory(Animal, _) ->
    write('You don\'t have '), write(Animal), write('. Go buy some in the marketplace!'), nl;
    
    inventory(Animal, Count),
    ranchingLevel(Level),
    
    (collectAnimal(Animal, true) ->
    retract(collectAnimal(Animal, true)),
    asserta(collectAnimal(Animal, false)),
    write('You collected '), write(Count), 
    (Animal = chicken -> write(' egg(s)!'), nl;
    Animal = cow -> write(' bottle(s) of cow milk!'), nl;
    Animal = sheep -> write(' wool(s)!'), nl;
    Animal = goat -> write(' bottle(s) of goat milk!'), nl),

    expRanching(Animal, Count, RanchingExp),
    addExpRanching(RanchingExp);
    
    (Animal = chicken -> write('There are no eggs yet...'), nl;
    Animal = cow -> write('There is no cow milk yet...'), nl;
    Animal = sheep -> write('Your sheep is still bald...'), nl;
    Animal = goat -> write('There is no goat milk yet...'), nl))).


/* Ranching */
ranch :-
    mapObject(X, Y, 'P'),
    inRanch(X, Y),
    (canRanch(true) ->
    write('Welcome to the Ranch!'), nl, 
    
    (\+inventory(chicken, _), \+inventory(sheep, _), \+inventory(cow, _), \+inventory(goat, _) ->
    write('You have no animals. Go buy some in the marketplace!'), nl;
    
    write('You have:'), nl,
    (inventory(chicken, Count) -> write(Count), write(' chicken'), nl; write('')),
    (inventory(sheep, Count) -> write(Count), write(' sheep'), nl; write('')),
    (inventory(cow, Count) -> write(Count), write(' cow'), nl; write('')),
    (inventory(goat, Count) -> write(Count), write(' goat'), nl; write('')),  
    write('What do you want to do?'), nl,
    write('1. Feed animal'), nl,
    write('2. Collect animal\'s production'), nl,
    write('Enter command: '), read(Input), nl,
    (Input =:= 1 ->
    write('Which animal would you like to feed?'), nl,
    write('1. Chicken'), nl,
    write('2. Cow'), nl,
    write('3. Sheep'), nl,
    write('4. Goat'), nl,
    write('Enter command: '), read(InputAnimal), nl,
    (InputAnimal =:= 1 -> feed(chicken);
    InputAnimal =:= 2 -> feed(cow);
    InputAnimal =:= 3 -> feed(sheep);
    InputAnimal =:= 4 -> feed(goat);
    write('Wrong input! Please input the right command'), nl, ranch);
    
    Input =:= 2 ->
    write('Which animal\'s production would you like to collect?'), nl,
    write('1. Chicken'), nl,
    write('2. Cow'), nl,
    write('3. Sheep'), nl,
    write('4. Goat'), nl,
    write('Enter command: '), read(InputAnimal), nl,
    (InputAnimal =:= 1 -> collect(chicken);
    InputAnimal =:= 2 -> collect(cow);
    InputAnimal =:= 3 -> collect(sheep);
    InputAnimal =:= 4 -> collect(goat);
    write('Wrong input! Please input the right command'), nl, ranch);
    
    write('Wrong input! Please input the right command'), nl, ranch));

    write('You\'re not in Ranch.'), nl).
