:- dynamic(diary/2).
:- dynamic(day/1).

day(1).

house :-
    % inHouse,
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