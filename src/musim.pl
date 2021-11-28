:- dynamic(currentSeason/1).

currentSeason(spring).

season(spring, 1, 12).
season(summer, 13, 26).
season(fall, 27, 38).
season(winter, 39, 50).
seasonName(spring, 'Spring').
seasonName(summer, 'Summer').
seasonName(fall, 'Fall').
seasonName(winter, 'winter').
itemSeason(spring, corn_seed).
itemSeason(spring, apple_seed).
itemSeason(spring, watermelon_seed).
itemSeason(spring, grape_seed).
itemSeason(summer, watermelon_seed).
itemSeason(summer, grape_seed).
itemSeason(summer, tomato_seed).
itemSeason(summer, potato_seed).
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
    (CurrDay =:= 13 -> changeSeason(summer);
    CurrDay =:= 27 -> changeSeason(fall);
    CurrDay =:= 39 -> changeSeason(winter);
    true(_)),
    !.

changeSeason(summer) :-
    write('Matahari menyinari. Sekarang sedang musim panas! Cek market untuk melihat seeds terbaru.'), nl,
    retract(currentSeason(_)),
    asserta(currentSeason(summer)),
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