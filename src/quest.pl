:- dynamic(currentQuest/5).


initQuest :-
    currentQuest(_,_,_,_,_),nl,
    write("Anda sedang menjalankan quest. Sarannya sih, selesaiin dulu, daripada keos."),
    nl, !.

initQuest :-
    \+(currentQuest(_,_,_,_,_)),
    random(0,10,Crop),
    random(0,10,Fish),
    random(0,10,Dairy),
    G is (Crop+Fish+Dairy)*10,
    X is (Crop+Fish+Dairy)*10,
    asserta(currentQuest(Crop,Fish,Dairy,G,X)).

finishQuest :-
    gold(OldG),
    % xp(OldX), blm dibuat
    currentQuest(0,0,0,G,X),
    NewG is G + OldG,
    NewX is X + OldX,
    write("Selamat, anda telah menyelesaikan Quest!").
    % Print variablesnya jg
    % Lanjut besok lg


quest :-
    \+(currentQuest(_,_,_,_,_)),nl,
    write("Tidak ada quest yang sedang dijalankan.").
    !.

quest :-
