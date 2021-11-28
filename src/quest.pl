:- dynamic(currentQuest/2).
:- dynamic(fishQuest/1).
:- dynamic(cropQuest/1).
:- dynamic(dairyQuest/1).
% :- dynamic(inQuest/1).
% :- dynamic(gold/1).
% :- dynamic(xp/1).
% :- dynamic(totalGold/1).
% inQuest(true).
% gold(500).
% xp(5).
% totalGold(200).



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
    \+fishQuest(0),
    \+cropQuest(0),
    \+dairyQuest(0),
    !.

checkQuest :-
    fishQuest(0),
    cropQuest(0),
    dairyQuest(0),
    currentQuest(G,X),
    gold(OldG),
    totalGold(OldTGold),
    xp(OldX),
    NewG is G + OldG,
    NewTGold is OldTGold + G,
    NewX is X + OldX,
    retract(gold(_)),
    asserta(gold(NewG)),
    retract(totalGold(_)),
    asserta(totalGold(NewTGold)),
    retract(xp(_)),
    asserta(xp(NewX)),
    retract(currentQuest(_,_)),
    write('Selamat, anda telah menyelesaikan Quest!'), nl,
    write('Gold yang didapat: '), write(G), nl,
    write('Experience yang didapat: '), write(X),nl,
    !.


quest :-
    \+inQuest(_),
    \+currentQuest(_,_),
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
    (X >= 0 -> X is X;
    X < 0 -> X is 0),
    retract(fishQuest(_)),
    asserta(fishQuest(X)),
    checkQuest,
    !.

decrementCrop :-
    \+(fishQuest(_)),
    !.

decrementCrop :-
    cropQuest(Crop),
    X is Crop - 1,
    (X >= 0 -> X is X;
    X < 0 -> X is 0),
    retract(cropQuest(_)),
    asserta(cropQuest(X)),
    checkQuest,
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
    checkQuest,
    !.