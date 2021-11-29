:- dynamic(potionBought/1).

/* To Do:
    - insert item to inventory
    - tambahin encounterAlchemist di move.pl tapi gatau caranya
      encounterAlchemist bakal asserta inAlchemist(true) */


/* Potion List */
isPotion(potion_fishing_level).
isPotion(potion_ranching_level).
isPotion(potion_farming_level).
isPotion(potion_player_level).
isPotion(potion_super_level).


/* Use Potion */
usePotion(Potion) :-
    farmingLevel(FarmingLevel),
    ranchingLevel(RanchingLevel),
    fishingLevel(FishingLevel),
    level(Level),

    (Potion = potion_fishing_level ->
    (FishingLevel =:= 5 -> write('You don\'t feel anything.'), nl;
    retract(fishingLevel(FishingLevel)),
    NextLevel is FishingLevel + 1,
    asserta(fishingLevel(NextLevel)),
    write('Wow! Suddenly, you feel like you could get bigger fish.'), nl);

    Potion = potion_ranching_level ->
    (RanchingLevel =:= 5 -> write('You don\'t feel anything.'), nl;
    retract(ranchingLevel(RanchingLevel)),
    NextLevel is RanchingLevel + 1,
    asserta(ranchingLevel(NextLevel)),
    write('Wow! Suddenly, you feel like you could get more animal product.'), nl);

    Potion = potion_farming_level ->
    (FarmingLevel =:= 5 -> write('You don\'t feel anything.'), nl;
    retract(farmingLevel(FarmingLevel)),
    NextLevel is FarmingLevel + 1,
    asserta(farmingLevel(NextLevel)),
    write('Wow! Suddenly, you feel like you\'ve become... a better farmer?'), nl);

    Potion = potion_player_level ->
    (Level =:= 5 -> write('You don\'t feel anything.'), nl;
    retract(level(Level)),
    NextLevel is Level + 1,
    asserta(level(NextLevel)),
    write('Wow! Suddenly, you feel way much better.'), nl);

    Potion = potion_super_level ->
    (FishingLevel =:= 5 -> write('');
    retract(fishingLevel(FishingLevel)),
    NextLevel is FishingLevel + 1,
    asserta(fishingLevel(NextLevel))),
    (RanchingLevel =:= 5 -> write('');
    retract(ranchingLevel(RanchingLevel)),
    NextLevel is RanchingLevel + 1,
    asserta(ranchingLevel(NextLevel))),
    (FarmingLevel =:= 5 -> write('');
    retract(farmingLevel(FarmingLevel)),
    NextLevel is FarmingLevel + 1,
    asserta(farmingLevel(NextLevel))),
    (Level =:= 5 -> write('');
    retract(level(Level)),
    NextLevel is Level + 1,
    asserta(level(NextLevel))),
    write('Eh... what happened?'), nl),
    
    throwItem(Potion).


/* Buy Potion */
buyPotion(Potion) :-
    (\+potionBought(Potion) ->
    gold(Gold),
    priceItem(Potion, Price),
    (Price > Gold ->
    write('You\'re too poor...'), nl;
    
    CurrentGold is Gold - Price,
    retract(gold(Gold)),
    asserta(gold(CurrentGold)),
    addItem(Potion),
    asserta(potionBought(Potion)),
    write('Thank you for buying... xixixi...'), nl);
    
    potionBought(Potion) ->
    write('You\'ve ever bought that before, have you? What a greedy human.'), nl).


/* Alchemist */
alchemist :-
    alchemist(true),
    day(Date),
    mapObject(X, Y, 'P'),
    enterAlchemist(X, Y),

    (inAlchemist(true) ->
    (Date =:= 10 ->
    write('Xixixixi..... Hello there commoner.....'), nl,
    write('Greetings.... I am 1S@slkfds13, the most well-known alchemist that ever lived in this planet.'), nl,
    write('Here I sell some wondrous-magical-phenomenal-marvelous-awesome items that'),nl,
    write('you never thought they even existed in the first place.'), nl,
    write('Do you want to take a peek? xixixi....'), nl;
    Date =:= 11 ->
    write('Xixixi... have we ever met before, commoner?'), nl,
    write('Welcome to my wondrous-magical-phenomenal-marvelous-awesome shop....'), nl,
    write('Come here, let me show you my wondrous-magical-phenomenal-marvelous-awesome items.'), nl;
    Date =:= 12 ->
    write('Xixixixxixixixixi..... xixixixi.....'), nl,
    write('Xixixixi? Xixixixixxixixi.....'), nl),

    write('1. Take a peek'), nl,
    write('2. Exit'), nl,
    write('Enter command: '), read(Input), nl,
    (Input =:= 1 ->
    write('What do you want to buy?'), nl,
    write('1. F15h1nG Potion'), nl,
    write('2. R4nch1n6 Potion'), nl,    
    write('3. F@rM!nG Potion'), nl,
    write('4. 66 64M1N6 Potion'), nl,
    write('5. 5UP3R 66 64M1N6 Potion'), nl,
    write('Enter option: '), read(InputPotion), nl,
    (InputPotion =:= 1 -> buyPotion(potion_fishing_level);
    InputPotion =:= 2 -> buyPotion(potion_ranching_level);
    InputPotion =:= 3 -> buyPotion(potion_farming_level);
    InputPotion =:= 4 -> buyPotion(potion_player_level);
    InputPotion =:= 5 -> buyPotion(potion_super_level);
    write('Xixixi?'), nl);

    write('Xixixi...'), nl);
    
    inAlchemist(false) ->
    write('There\'s an odd sign with \'alchemist\' written on it...'), nl).
    
alchemist :-
    \+alchemist(_),
    write('What is alchemist? They\'re not real, are they?'), nl.