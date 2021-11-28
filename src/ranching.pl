:- dynamic(fedAnimal/2).
:- dynamic(collectAnimal/2).
:- dynamic(cooldownCollect/2).

/* To Do:
    - buying animal resulting in:
        cooldownCollect(Animal, Cooldown) --> do nothing if animal is owned; asserta cooldownCollect ngikutin cooldownAnimal if not owned before
        fedAnimal(Animal, Boolean) --> retract and asserta fedAnimal(Animal, true) if animal owned; asserta only if not owned before
        collectAnimal(Animal, Boolean) --> do nothing if animal is owned; asserta collectAnimal(Animal, false) if not owned before */


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


/* Animal Initialization */
initAnimal(Animal) :-
    currInventory(Inventory),
    (\+member(Animal, Inventory) ->
    ranchingLevel(Level),
    cooldownAnimal(Level, Animal, Cooldown),
    asserta(cooldownCollect(Animal, Cooldown)),
    asserta(fedAnimal(Animal, true)),
    asserta(collectAnimal(Animal, false));
    
    member(Animal, Inventory) ->
    retract(fedAnimal(Animal, _)),
    asserta(fedAnimal(Animal, true))).


/* Add Ranching Exp */
/* Ranching exp calculation */
expRanching(Animal, Count, RanchingExp) :-
    expAnimalProduction(Animal, ExpAnimal),
    equipment(knife, LevelEquipment),
    (LevelEquipment =:= 1 -> ExpRate is 0.133;
    LevelEquipment =:= 2 -> ExpRate is 0.333;
    LevelEquipment =:= 3 -> ExpRate is 0.733),
    ExpEquipment is round(ExpRate * ExpAnimal * Count),

    (job('Rancher') ->
    TotalExpAnimal is ExpAnimal * Count,
    ExpSpeciality is round(0.2 * TotalExpAnimal),
    RanchingExp is TotalExpAnimal + ExpSpeciality + ExpEquipment;

    \+job('Rancher') ->
    TotalExpAnimal is ExpAnimal * Count,
    RanchingExp is TotalExpAnimal + ExpEquipment), !.
/* Adding ranching exp to player state */
addExpRanching(RanchingExp) :-    
    ranchingExp(PrevExp),
    exp(PrevGeneralExp),
    ranchingLevel(Level),
    retract(ranchingExp(PrevExp)),
    retract(exp(PrevGeneralExp)),
    CurrentExp is PrevExp + RanchingExp,
    CurrentGeneralExp is PrevGeneralExp + RanchingExp,
    asserta(exp(CurrentGeneralExp)),
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

    asserta(ranchingExp(CurrentExp))).


/* Feeding */  
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
feed(Animal) :-
    currInventory(Inventory),
    (\+member(Animal, Inventory) ->
    write('You don\'t have '), write(Animal), write('. Go buy some in the marketplace!'), nl;
    
    cntItemInventory(Animal, Inventory, Count),
    (Animal = chicken -> AnimalFeed = chicken_feed;
    Animal = cow -> AnimalFeed = cow_feed;
    Animal = sheep -> AnimalFeed = sheep_feed;
    Animal = goat -> AnimalFeed = goat_feed),
    cntItemInventory(AnimalFeed, Inventory, Qty),
    
    (fedAnimal(Animal, false) ->
    (Qty < Count ->
    write('You don\'t have enough '), write(Animal), write(' feed.'), nl;

    throwItem(AnimalFeed, Count),
    retract(fedAnimal(Animal, false)),
    asserta(fedAnimal(Animal, true)),
    write('You finished feeding your '), write(Animal), write('(s).'), nl);
    
    fedAnimal(Animal, true) ->
    write('You already fed your '), write(Animal), write('(s).'), nl)).    


/* Ranching Process while Sleeping */
updateRanch :-
    currInventory(Inventory),
    ((\+member(chicken, Inventory) -> write('');
    feedCooldown(chicken),
    (\+fedAnimal(chicken, _) -> asserta(fedAnimal(chicken, false));
    retract(fedAnimal(chicken, _)), asserta(fedAnimal(chicken, false)))),

    (\+member(sheep, Inventory) -> write('');
    feedCooldown(sheep),
    (\+fedAnimal(sheep, _) -> asserta(fedAnimal(sheep, false));
    retract(fedAnimal(sheep, _)), asserta(fedAnimal(sheep, false)))),

    (\+member(cow, Inventory) -> write('');
    feedCooldown(cow),
    (\+fedAnimal(cow, _) -> asserta(fedAnimal(cow, false));
    retract(fedAnimal(cow, _)), asserta(fedAnimal(cow, false)))),

    (\+member(goat, Inventory) -> write('');
    feedCooldown(goat),
    (\+fedAnimal(goat, _) -> asserta(fedAnimal(goat, false));
    retract(fedAnimal(goat, _)), asserta(fedAnimal(goat, false))))).


/* Collecting Animal Production */
collect(Animal) :-
    (\+member(Animal, Inventory) ->
    write('You don\'t have '), write(Animal), write('. Go buy some in the marketplace!'), nl;
    
    cntItemInventory(Animal, Inventory, Count),
    
    (collectAnimal(Animal, true) ->
    retract(collectAnimal(Animal, true)),
    asserta(collectAnimal(Animal, false)),
    write('You collected '), write(Count), 
    (Animal = chicken -> write(' egg(s)!'), nl, addItem(egg, Count);
    Animal = cow -> write(' bottle(s) of cow milk!'), nl, addItem(cow_milk, Count);
    Animal = sheep -> write(' wool(s)!'), nl, addItem(wool, Count);
    Animal = goat -> write(' bottle(s) of goat milk!'), nl, addItem(goat_milk, Count)),

    reduceEnergy(3),
    expRanching(Animal, Count, RanchingExp),
    addExpRanching(RanchingExp),
    decrementDairy(Count);
    
    (Animal = chicken -> write('There are no eggs yet...'), nl;
    Animal = cow -> write('There is no cow milk yet...'), nl;
    Animal = sheep -> write('Your sheep is still bald...'), nl;
    Animal = goat -> write('There is no goat milk yet...'), nl))).


/* Slaughter Animal */
resetAnimalState(Animal) :-
    currInventory(Inventory),
    (member(Animal, Inventory) ->
    write('');
    
    \+member(Animal, Inventory) ->
    (\+fedAnimal(Animal, _) -> write(''); retract(fedAnimal(Animal, _))),
    (\+collectAnimal(Animal, _) -> write(''); retract(collectAnimal(Animal, _))),
    (\+cooldownCollect(Animal, _) -> write(''); retract(cooldownCollect(Animal, _)))).
slaughter(Animal) :-
    currInventory(Inventory),
    (\+member(Animal, Inventory) ->
    write('You don\'t have '), write(Animal), write('. Go buy some in the marketplace!'), nl;
    
    energy(Energy),
    (Energy < 20 ->
    write('You\'re way too tired.'), nl;

    throwItem(Animal),
    resetAnimalState(Animal),
    write('You got '), 
    (Animal = chicken -> write('chicken meat!'), nl, addItem(chicken_meat);
    Animal = cow -> write('cow meat!'), nl, addItem(cow_meat);
    Animal = sheep -> write('sheep meat!'), nl, addItem(sheep_meat);
    Animal = goat -> write('goat meat!'), nl, addItem(goat_meat)),

    reduceEnergy(5),
    expRanching(Animal, 1, RanchingExp),
    addExpRanching(RanchingExp))).


/* Ranching */
ranch :-
    mapObject(X, Y, 'P'),
    inRanch(X, Y),
    (canRanch(true) ->
    write('Welcome to the Ranch!'), nl,
    currInventory(Inventory),
    cntCategoryInventory(animal, Inventory, AnimalQty),
    (AnimalQty == 0 ->
    write('You have no animals. Go buy some in the marketplace!'), nl;
    
    write('You have:'), nl,
    (cntItemInventory(chicken, Inventory, CountChicken), (CountChicken =\= 0 -> write('- '), write(CountChicken), write(' chicken'), nl; write(''))),
    (cntItemInventory(sheep, Inventory, CountSheep), (CountSheep =\= 0 -> write('- '), write(CountSheep), write(' sheep'), nl; write(''))),
    (cntItemInventory(cow, Inventory, CountCow), (CountCow =\= 0 -> write('- '), write(CountCow), write(' cow'), nl; write(''))),
    (cntItemInventory(goat, Inventory, CountGoat), (CountGoat =\= 0 -> write('- '), write(CountGoat), write(' goat'), nl; write(''))),  
    write('What do you want to do?'), nl,
    write('1. Feed animal'), nl,
    write('2. Collect animal\'s production'), nl,
    write('3. Slaughter animal'), nl,
    write('4. Exit ranch'), nl,
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
    write('Wrong input! Please input the right command'), nl);
    
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
    write('Wrong input! Please input the right command'), nl);

    Input =:= 3 ->
    write('Which animal do you want to slaughter?'), nl,
    write('1. Chicken'), nl,
    write('2. Cow'), nl,
    write('3. Sheep'), nl,
    write('4. Goat'), nl,
    write('Enter command: '), read(InputAnimal), nl,
    (InputAnimal =:= 1 -> slaughter(chicken);
    InputAnimal =:= 2 -> slaughter(cow);
    InputAnimal =:= 3 -> slaughter(sheep);
    InputAnimal =:= 4 -> slaughter(goat);
    write('Wrong input! Please input the right command'), nl);  

    Input =:= 4 ->
    write('Exiting ranch...'), nl;
    
    write('Wrong input! Please input the right command'), nl));

    write('You\'re not in Ranch.'), nl).
