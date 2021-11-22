:- dynamic(expRanching/2).
:- dynamic(levelRanching/2).

/* To Do:
    - validate player's location in ranch atau ga
    - cara buat access owned animal masih not fixed
    - set animal production cooldown
    - insert ranch production to player's inventory
    - adding general exp from ranching   */


/* Animal List */
isAnimal(chicken).
isAnimal(sheep).
isAnimal(cow).
isAnimal(goat).


/* Animal Cooldown List */
cooldownAnimal(chicken, 1).
cooldownAnimal(sheep, 3).
cooldownAnimal(cow, 2).
cooldownAnimal(goat, 1).


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
