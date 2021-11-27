:- dynamic(currentQuest/2).
:- dynamic(fishQuest/1).
:- dynamic(cropQuest/1).
:- dynamic(dairyQuest/1).

% inQuest(true).


% Crop, Fish, Dairy, Gold, Xp

initQuest :-
    currentQuest(_,_),nl,
    write('Anda sedang menjalankan quest. Sarannya sih, selesaiin dulu, daripada keos.'),
    nl, !.

initQuest :-
    \+(currentQuest(_,_)),
    random(1,10,Crop),
    random(1,10,Fish),
    random(1,10,Dairy),
    G is (Crop+Fish+Dairy)*10,
    X is (Crop+Fish+Dairy)*10,
    asserta(currentQuest(G,X)),
    asserta(fishQuest(Fish)),
    asserta(cropQuest(Crop)),
    asserta(dairyQuest(Dairy)),
    write('Anda mendapat quest baru. Kumpulkan '), write(Crop), write(' buah crop, '),
    write(Fish), write(' ekor ikan, dan '), write(Dairy), write(' buah dairy. Goodluck!'), nl,
    !.


checkQuest :-
    currentQuest(0,0,0,G,X),
    gold(OldG),
    xp(OldX),
    NewG is G + OldG,
    NewX is X + OldX,
    retract(gold(_)),
    asserta(gold(NewG)),
    retract(xp(_)),
    asserta(xp(NewX)),
    write('Selamat, anda telah menyelesaikan Quest!'), nl,
    write('Gold yang didapat: '), write(G), nl,
    write('Experience yang didapat: '), write(X),nl,
    !.


quest :-
    \+(inQuest(_)),
    \+(currentQuest(_,_)),
    write('Tidak ada quest yang sedang dijalankan.'),
    !.

quest :-
    currentQuest(_,_),
    write('Anda sedang menjalankan quest. Sisa aktivitas yang dibutuhkan: '),nl,
    (fishQuest(Fish) -> write('Fish: '), write(Fish), nl),
    (cropQuest(Crop) -> write('Crop: '), write(Crop), nl),
    (dairyQuest(Dairy) -> write('Dairy: '), write(Dairy), nl),
    !.

quest :- 
    inQuest(_),
    \+currentQuest(_,_),
    write('Anda menemukan sebuah Quest!'),nl,
    initQuest,
    !.

decrementFish :-
    \+(fishQuest(_)),
    !.

decrementFish :-
    fishQuest(Fish),
    X is Fish - 1,
    retract(fishQuest(_)),
    asserta(fishQuest(X)),
    !.

decrementCrop :-
    \+(fishQuest(_)),
    !.

decrementCrop :-
    cropQuest(Crop),
    X is Crop - 1,
    retract(cropQuest(_)),
    asserta(cropQuest(X)),
    !.

decrementDairy(N) :-
    N is N,
    \+(dairyQuest(_)),
    !.

decrementDairy(N) :-
    dairyQuest(Dairy),
    (N > Dairy -> X is 0;
    Dairy >= N -> X is Dairy-N),
    retract(dairyQuest(_)),
    asserta(dairyQuest(X)),
    !.