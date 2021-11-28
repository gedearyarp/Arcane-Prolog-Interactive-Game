:- dynamic(currentSeason/1).

currentSeason(autumn).

season(autumn, 1, 12).
season(spring, 13, 26).
season(fall, 27, 38).
season(winter, 39, 50).
seasonName(autumn, 'Autumn').
seasonName(spring, 'Spring').
seasonName(fall, 'Fall').
seasonName(winter, 'winter').
itemSeason(autumn, corn_seed).
itemSeason(autumn, apple_seed).
itemSeason(autumn, watermelon_seed).
itemSeason(autumn, grape_seed).
itemSeason(spring, watermelon_seed).
itemSeason(spring, grape_seed).
itemSeason(spring, tomato_seed).
itemSeason(spring, potato_seed).
itemSeason(fall, corn_seed).
itemSeason(fall, grape_seed).
itemSeason(fall, tomato_seed).
itemSeason(fall, apple_seed).
itemSeason(winter, eggplant_seed).
itemSeason(winter, potato_seed).
itemSeason(winter, watermelon_seed).
itemSeason(winter, grape_seed).

checkSeason :-
    day(CurrDay),
    (CurrDay =:= 13 -> changeSeason(spring);
    CurrDay =:= 27 -> changeSeason(fall);
    CurrDay =:= 39 -> changeSeason(winter);
    true(_)),
    !.

changeSeason(spring) :-
    write('Matahari menyinari. Sekarang sedang musim panas! Cek market untuk melihat seeds terbaru.'), nl,
    retract(currentSeason(_)),
    asserta(currentSeason(spring)),
    !.

changeSeason(fall) :-
    write('Daun-daun berguguran. Sekarang sedang musim gugur!! Cek market untuk melihat seeds terbaru.'), nl,
    retract(currentSeason(_)),
    asserta(currentSeason(fall)),
    !.

changeSeason(winter) :-
    write('Brr... Dingin... Jangan lupakan jaketmu karena sekarang musim dingin! Cek market untuk melihat seeds terbaru.'), nl,
    retract(currentSeason(_)),
    asserta(currentSeason(winter)),
    !.