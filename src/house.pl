:- dynamic(diary/2).
:- dynamic(day/1).
:- dynamic(alchemist/1).

:- dynamic(inHouse/1).
% day(9).
% startGame(true).

house :-
    inHouse(_),
    \+(day(50)),
    write('What do you want to do in this sweet, cozy home?'),nl,
    write('1. Sleep'),nl,
    write('2. Write Diary'),nl,
    write('3. Read Diary'), nl,
    write('4. Exit house'), nl,
    write('Masukkan pilihan (dalam bentuk angka): '),read(X),
    (X =:= 1 -> sleep;
    X =:= 2 -> writeDiary;
    X =:= 3 -> readDiary;
    X =:= 4 -> exitHouse),nl,
    !.

house :-
    inHouse(_),
    day(50),
    write('This might be your last day...'),nl,
    write('You look up to the sky and see that you failed...'),nl,
    write('After all, why are you here at the first place?'), nl,
    write('You failed.'),nl,
    retract(startGame(_)),
    !.

house :-
    \+inHouse(_),
    write('Salah rumah woi!!!!'), nl,
    !.

sleep :-
    write('Do you really, really want to sleep?'),nl,
    write('1. Yes'),nl,
    write('2. No thanks i am good'),nl,
    read(X),
    (X =:= 2 -> house;
    X =:= 1 -> sleepInProgress),nl,
    !.

sleepInProgress :-
    random(1,3,Temp),
    (Temp =:= 1 -> write('Ahh.. sleep... I never get this when im still in ITB..');
    Temp =:= 2 -> write('Hu Tao ...??? WANGY WANGY... PLEASE DONT GO....');
    Temp =:= 3 -> write('What a boring sleep.. No dreams whatsoever')), nl,
    day(X),
    CurrDay is X + 1,
    retract(day(X)),
    asserta(day(CurrDay)),
    (CurrDay =:= 10 ->
    nl, write('Seems like there\'s someone new coming to our village...'), nl, write('Hmm... I wonder who is that person?'), nl,
    resetTile(13, 16),
    assertz(mapObject(13, 16, 'A')),
    asserta(alchemist(true))),
    (CurrDay =:= 13 ->
    nl, write('That odd person is leaving today. Will he come back again?'), nl,
    retract(mapObject(13, 16, 'A')),
    retract(alchemist(true))),
    updateRanch,
    updateFarm,
    house.

writeDiary :-
    day(CurrDay),
    write('Day: '),
    write(CurrDay), nl,
    write('Tulis keluh kesahmu hari ini:'),nl,
    read(Entry),
    assertz(diary(CurrDay, Entry)),
    house,
    !.

readDiary :-
    write('Diary hari ke-berapa yang ingin kamu baca?'),nl,
    read(SelectedDay),
    (\+(diary(SelectedDay, _)) -> write('Tidak ada entri untuk hari itu.');
    diary(SelectedDay, Entry) -> write(Entry)
    ),
    nl,
    house,
    !.

exitHouse :-
    write('Buh-bye!'),nl,
    !.