:- dynamic(harvestCrop/4).
:- dynamic(cooldownHarvest/4).
:- dynamic(canPlant/3).

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


/* Add Farming Exp */
/* Farming exp calculation */
expFarming(Crop, FarmingExp) :-
    expCrop(Crop, ExpCrop),
    equipment(shovel, LevelEquipment),
    (LevelEquipment =:= 1 -> ExpRate is 0;
    LevelEquipment =:= 2 -> ExpRate is 0.3;
    LevelEquipment =:= 3 -> ExpRate is 0.75),
    ExpEquipment is round(ExpRate * ExpCrop),

    (job('Farmer') ->
    ExpSpeciality is round(0.2 * ExpCrop),
    FarmingExp is ExpCrop + ExpSpeciality + ExpEquipment;

    \+job('Farmer') ->
    FarmingExp is ExpCrop + ExpEquipment).
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
    currInventory(Inventory),
    (\+member(Seed, Inventory) ->
    write('You don\'t have that seed!'), nl;
    
    energy(Energy),
    (Energy < 10 ->
    write('You\'re way too tired.'), nl;

    reduceEnergy(3),
    % Inventory Control
    throwItem(Seed),
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
    write('You planted '), write(Crop), write(' seed.'), nl)).


/* Reduction Process */
harvestCooldown(X, Y, Crop) :-
    cooldownHarvest(X, Y, Crop, PrevCooldown),
    retract(cooldownHarvest(X, Y, Crop, PrevCooldown)),
    CurrentCooldown is PrevCooldown - 1,

    (CurrentCooldown =:= 0 ->
    retract(harvestCrop(X, Y, Crop, false)),
    asserta(harvestCrop(X, Y, Crop, true));  

    asserta(cooldownHarvest(X, Y, Crop, CurrentCooldown))).


/* Reset Tile */
resetTile(X, Y) :-
    (harvestCrop(X, Y, Crop, _) ->
    cropSymbol(Crop, Symbol),

    (cooldownHarvest(X, Y, Crop, _) -> retract(cooldownHarvest(X, Y, Crop, _));
    write('')),

    retract(harvestCrop(X, Y, Crop, _)),
    retract(mapObject(X, Y, Symbol));
    
    write('')). 


/* Farming Process while Sleeping */
resetDig :-
    (\+mapObject(_, _, '=') -> write('');
    retractall(mapObject(_, _, '='))).
updateFarm :-
    resetDig,
    ((\+cooldownHarvest(_, _, _, _)) -> write('');
    harvestCooldown(_, _, _)).


/* Farming */
dig :-
    mapObject(X, Y, 'P'),
    emptyTile(X, Y),
    energy(Energy),

    (canDig(true) ->
    (Energy < 10 ->
    write('You\'re way too tired.'), nl;
    
    resetTile(X, Y),
    (\+mapObject(X, Y, '=') -> assertz(mapObject(X, Y, '=')); write('')),  % Tile hasn't been dug before
    (\+canPlant(X, Y, _) -> asserta(canPlant(X, Y, true));
    retract(canPlant(X, Y, _)), asserta(canPlant(X, Y, true))),
    reduceEnergy(2),
    write('You digged the tile.'), nl);
    
    (\+canPlant(X, Y, _) -> asserta(canPlant(X, Y, false));
    retract(canPlant(X, Y, _)), asserta(canPlant(X, Y, false))),    
    write('You can\'t dig there...'), nl).
plant :-
    mapObject(X, Y, 'P'),
    currInventory(Inventory),    
    
    (canPlant(X, Y, true) ->
    currInventory(Inventory),
    cntCategoryInventory(seed, Inventory, SeedQty),
    
    (SeedQty =:= 0 -> write('You have no seeds. Go buy some in the marketplace!'), nl;
    
    write('You have:'), nl,
    (cntItemInventory(corn_seed, Inventory, CountCorn), (CountCorn =\= 0 -> write('- '), write(CountCorn), write(' corn seed'), nl; write(''))),
    (cntItemInventory(apple_seed, Inventory, CountApple), (CountApple =\= 0 -> write('- '), write(CountApple), write(' apple seed'), nl; write(''))),
    (cntItemInventory(watermelon_seed, Inventory, CountWatermelon), (CountWatermelon =\= 0 -> write('- '), write(CountWatermelon), write(' watermelon seed'), nl; write(''))),
    (cntItemInventory(grape_seed, Inventory, CountGrape), (CountGrape =\= 0 -> write('- '), write(CountGrape), write(' grape seed'), nl; write(''))),
    (cntItemInventory(tomato_seed, Inventory, CountTomato), (CountTomato =\= 0 -> write('- '), write(CountTomato), write(' tomato seed'), nl; write(''))),
    (cntItemInventory(potato_seed, Inventory, CountPotato), (CountPotato =\= 0 -> write('- '), write(CountPotato), write(' potato seed'), nl; write(''))),
    (cntItemInventory(eggplant_seed, Inventory, CountEggplant), (CountEggplant =\= 0 -> write('- '), write(CountEggplant), write(' eggplant seed'), nl; write(''))), 
    write('What do you want to plant?'), nl,    
    read(Input), nl,
    (Input = 'corn' -> plantSeed(corn_seed);
    Input = 'apple' -> plantSeed(apple_seed);
    Input = 'watermelon' -> plantSeed(watermelon_seed);
    Input = 'grape' -> plantSeed(grape_seed);
    Input = 'tomato' -> plantSeed(tomato_seed);
    Input = 'potato' -> plantSeed(potato_seed);
    Input = 'eggplant' -> plantSeed(eggplant_seed);
    write('What kind of seed is that?'), nl));
    
    write('You can\'t plant seeds there...'), nl).
harvest :-
    mapObject(X, Y, 'P'),

    (harvestCrop(X, Y, Crop, true) ->
    cropSymbol(Crop, Symbol),
    retract(mapObject(X, Y, Symbol)),
    retract(harvestCrop(X, Y, Crop, true)),
    write('You harvested '), write(Crop), write('!'), nl,
    addItem(Crop),
    expFarming(Crop, FarmingExp),
    addExpFarming(FarmingExp),
    reduceEnergy(2),
    decrementCrop;

    \+harvestCrop(X, Y, Crop, true) ->
    write('Nothing to harvest there.'), nl).