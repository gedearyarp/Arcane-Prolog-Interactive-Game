:- dynamic(harvestCrop/4).
:- dynamic(cooldownHarvest/4).
:- dynamic(canPlant/3).

/* To Do:
    - cara buat access owned seeds masih not fixed
    - insert crop to inventory
    - pas bobo, cek mapObject yang ada crop symbolnya, terus harvestCooldown(_, _, Crop) */


/* Crop List */
isCrop(corn).
isCrop(apple).
isCrop(watermelon).
isCrop(grape).
isCrop(tomato).
isCrop(potato).
isCrop(eggplant).


/* Crop Exp List */
expCrop(corn, 12). 
expCrop(apple, 15).
expCrop(watermelon, 20).
expCrop(grape, 18).
expCrop(tomato, 10).
expCrop(potato, 16).
expCrop(eggplant, 9).


/* Crop Seeds */
cropSeed(corn, corn_seed).
cropSeed(apple, apple_seed).
cropSeed(watermelon, watermelon_seed).
cropSeed(grape, grape_seed).
cropSeed(tomato, tomato_seed).
cropSeed(potato, potato_seed).
cropSeed(eggplant, eggplant_seed).


/* Crop Symbol */
cropSymbol(corn, 'c').
cropSymbol(apple, 'a').
cropSymbol(watermelon, 'w').
cropSymbol(grape, 'g').
cropSymbol(tomato, 't').
cropSymbol(potato, 'p').
cropSymbol(eggplant, 'e').


/* Harvest Cooldown List */
cooldownCrop(corn, 3).
cooldownCrop(apple, 4).
cooldownCrop(watermelon, 6).
cooldownCrop(grape, 5).
cooldownCrop(tomato, 3).
cooldownCrop(potato, 5).
cooldownCrop(eggplant, 2).


/* TRIAL
inventory(corn_seed, 4). */


/* Add Farming Exp */
/* Farming exp calculation */
expFarming(Crop, FarmingExp) :-
    (job('Farmer') ->
    expCrop(Crop, ExpCrop),
    ExpSpeciality is round(0.2 * ExpCrop),
    FarmingExp is ExpCrop + ExpSpeciality;

    \+job('Farmer') ->
    expCrop(Animal, ExpCrop),
    FarmingExp is ExpCrop).
/* Adding farming exp to player state */
addExpFarming(FarmingExp) :-    
    farmingExp(PrevExp),
    exp(PrevGeneralExp),
    farmingLevel(Level),
    retract(farmingExp(PrevExp)),
    retract(exp(PrevGeneralExp)),
    CurrentExp is PrevExp + FarmingExp,
    CurrentGeneralExp is PrevGeneralExp + FarmingExp,
    asserta(exp(CurrentGeneralExp)),
    write('You gained '), write(FarmingExp), write(' farming exp!'), nl,

    (Level < 2, CurrentExp >= 500 ->
    retract(farmingLevel(Level)),
    asserta(farmingLevel(2)),
    FinalExp is CurrentExp - 500,
    asserta(farmingExp(FinalExp)),
    write('Level up! Yey naik ke level 2'), nl;

    Level < 3, CurrentExp >= 1000 ->
    retract(farmingLevel(Level)),
    asserta(farmingLevel(3)),
    FinalExp is CurrentExp - 1000,
    asserta(farmingExp(FinalExp)),
    write('Level up! Yey naik ke level 3'), nl;

    Level < 4, CurrentExp >= 2000 ->
    retract(farmingLevel(Level)),
    asserta(farmingLevel(4)),
    FinalExp is CurrentExp - 2000,
    asserta(farmingExp(FinalExp)),
    write('Level up! Yey naik ke level 4'), nl;

    Level < 5, CurrentExp >= 5000 ->
    retract(farmingLevel(Level)),
    asserta(farmingLevel(5)),
    FinalExp is CurrentExp - 5000,
    asserta(farmingExp(FinalExp)),
    write('Level up! Yey naik ke level 5,, wah keren bangeDDDzz level maksimum'), nl;

    asserta(farmingExp(CurrentExp))).


/* Planting Seeds */
plantSeed(Seed) :-
    (\+inventory(Seed, _) ->
    write('You don\'t have that seed!'), nl;
    
    inventory(Seed, PrevCount) ->
    % Inventory Control
    retract(inventory(Seed, PrevCount)),
    Count is PrevCount - 1,
    asserta(inventory(Seed, Count)),
    % Map Control
    cropSeed(Crop, Seed),
    cropSymbol(Crop, Symbol),
    mapObject(X, Y, 'P'),
    retract(mapObject(X, Y, '=')),
    assertz(mapObject(X, Y, Symbol)),
    % Cooldown Control
    cooldownCrop(Crop, MaxCooldown),
    asserta(cooldownHarvest(X, Y, Crop, MaxCooldown)),
    asserta(harvestCrop(X, Y, Crop, false)),
    % Tile Control
    retract(canPlant(X, Y, true)),
    asserta(canPlant(X, Y, false)),
    write('You planted '), write(Crop), write(' seed.'), nl).


/* Reduction Process */
harvestCooldown(X, Y, Crop) :-
    cooldownHarvest(X, Y, Crop, PrevCooldown),
    retract(cooldownHarvest(X, Y, Crop, PrevCooldown)),
    CurrentCooldown is PrevCooldown - 1,

    (CurrentCooldown =:= 0 ->
    retract(harvestCrop(X, Y, Crop, false)),
    asserta(harvestCrop(X, Y, Crop, true));  

    asserta(cooldownHarvest(X, Y, Crop, CurrentCooldown))).


/* Farming */
dig :-
    mapObject(X, Y, 'P'),
    emptyTile(X, Y),

    (canDig(true) ->
    
    (harvestCrop(X, Y, Crop, _) -> % Digging in planted tile resulting in all farming states on the tile removed
    cropSymbol(Crop, Symbol),
    (cooldownHarvest(X, Y, Crop, _) -> retract(cooldownHarvest(X, Y, Crop, _)); write('')),
    retract(harvestCrop(X, Y, Crop, _)),
    retract(mapObject(X, Y, Symbol));
    write('')),

    (\+mapObject(X, Y, '=') -> assertz(mapObject(X, Y, '=')); write('')),  % Tile hasn't been dug before
    (\+canPlant(X, Y, _) -> asserta(canPlant(X, Y, true));
    retract(canPlant(X, Y, _)), asserta(canPlant(X, Y, true))),    
    write('You digged the tile.'), nl;
    
    (\+canPlant(X, Y, _) -> asserta(canPlant(X, Y, false));
    retract(canPlant(X, Y, _)), asserta(canPlant(X, Y, false))),    
    write('You can\'t dig there...'), nl).
plant :-
    mapObject(X, Y, 'P'),
    
    (canPlant(X, Y, true) ->
    write('You have:'), nl,
    (inventory(corn_seed, Count) -> write('- '), write(Count), write(' corn seed'), nl; write('')),
    (inventory(apple_seed, Count) -> write('- '), write(Count), write(' apple seed'), nl; write('')),
    (inventory(watermelon_seed, Count) -> write('- '), write(Count), write(' watermelon seed'), nl; write('')),
    (inventory(grape_seed, Count) -> write('- '), write(Count), write(' grape seed'), nl; write('')),
    (inventory(tomato_seed, Count) -> write('- '), write(Count), write(' tomato seed'), nl; write('')),
    (inventory(potato_seed, Count) -> write('- '), write(Count), write(' potato seed'), nl; write('')),
    (inventory(eggplant_seed, Count) -> write('- '), write(Count), write(' eggplant seed'), nl; write('')), 
    write('What do you want to plant?'), nl,    
    read(Input), nl,
    (Input = 'corn' -> plantSeed(corn_seed);
    Input = 'apple' -> plantSeed(apple_seed);
    Input = 'watermelon' -> plantSeed(watermelon_seed);
    Input = 'grape' -> plantSeed(grape_seed);
    Input = 'tomato' -> plantSeed(tomato_seed);
    Input = 'potato' -> plantSeed(potato_seed);
    Input = 'eggplant' -> plantSeed(eggplant_seed);
    write('What kind of seed is that?'), nl);
    
    write('You can\'t plant seeds there...'), nl).
harvest :-
    mapObject(X, Y, 'P'),

    (harvestCrop(X, Y, Crop, true) ->
    cropSymbol(Crop, Symbol),
    retract(mapObject(X, Y, Symbol)),
    retract(harvestCrop(X, Y, Crop, true)),
    write('You harvested '), write(Crop), write('!'), nl,
    expFarming(Crop, FarmingExp),
    addExpFarming(FarmingExp);

    \+harvestCrop(X, Y, Crop, true) ->
    write('Nothing to harvest there.'), nl).