% TODO : Check if in market, Equipments level, Sync inventory

% DEBUG CODE STARTS HERE
% :- dynamic(gold/1).
% :- include('items.pl')

% debugMarket :-
%     asserta(gold(1000)).
% DEBUG CODE ENDS HERE

market :-
    write('Mau jual apa beli BOS?'),nl,
    write('1. Beli'),nl,
    write('2. Jual'),nl,
    write('3. Upgrade Equipment'), nl,
    write('Masukkan pilihan: '),read(X),
    (X =:= 1 -> beli;
    X =:= 2 -> jual;
    X =:= 3 -> upgradeEq),nl,
    !.

beli :-
    write('Mau beli apa?'),nl,
    write('1. Seed'),nl,
    write('2. Ranch animal'),nl,
    write('3. Animal food'),nl,
    write('Masukkan pilihan: '), read(X),
    (X =:= 1 -> buySeed;
    X =:= 2 -> buyAnimal;
    X =:= 3 -> buyAnimalFood),nl,
    !.

buySeed :-

buyAnimal :-

buyAnimalFood :-

% jual :-

% upgradeEq :-

% beli :-
%     write('Mau beli apa niech?'),nl,
%     write('1. Carrot seed (50 G)'),nl,
%     write('2. Corn seed (50 G)'),nl,
%     write('3. Tomato seed (50 G)'),nl,
%     write('4. Potato seed (50 G)'),nl,
%     write('5. Chicken (500 G)'),nl,
%     write('6. Sheep (1000 G)'),nl,
%     write('7. Cow (1500 G)'),nl,
%     write('Masukkan pilihan: '),read(X),
%     (X =:= 1 -> buy_carrot_seed;
%     X =:= 2 -> buy_corn_seed;
%     X =:= 3 -> buy_tomato_seed;
%     X =:= 4 -> buy_potato_seed;
%     X =:= 5 -> buy_chicken;
%     X =:= 6 -> buy_sheep;
%     X =:= 7 -> buy_cow),nl,
%     !.

% Kasus duit gacukup
buy_carrot_seed :-
    gold(G),
    G < 50,nl,
    write('Duit anda kurang pak. Sana kerja lagi!'),nl,
    !.

% Kasus duit memenuhi
buy_carrot_seed :-
    gold(G),
    G >= 50,
    NewG is G - 50,
    retract(gold(G)),
    asserta(gold(NewG)),nl,
    write('Pembelian sukses. Yey jadi banyak barang!'),nl,
    % Belom ada masukin ke inven
    !.

% Kasus duit gacukup
buy_corn_seed :-
    gold(G),
    G < 50,nl,
    write('Duit anda kurang pak. Sana kerja lagi!'),nl,
    !.

% Kasus duit memenuhi
buy_corn_seed :-
    gold(G),
    G >= 50,
    NewG is G - 50,
    retract(gold(G)),
    asserta(gold(NewG)),nl,
    write('Pembelian sukses. Yey jadi banyak barang!'),nl,
    % Belom ada masukin ke inven
    !.


% Kasus duit gacukup
buy_tomato_seed :-
    gold(G),
    G < 50,nl,
    write('Duit anda kurang pak. Sana kerja lagi!'),nl,
    !.

% Kasus duit memenuhi
buy_tomato_seed :-
    gold(G),
    G >= 50,
    NewG is G - 50,
    retract(gold(G)),
    asserta(gold(NewG)),nl,
    write('Pembelian sukses. Yey jadi banyak barang!'),nl,
    % Belom ada masukin ke inven
    !.

% Kasus duit gacukup
buy_potato_seed :-
    gold(G),
    G < 50,nl,
    write('Duit anda kurang pak. Sana kerja lagi!'),nl,
    !.

% Kasus duit memenuhi
buy_potato_seed :-
    gold(G),
    G >= 50,
    NewG is G - 50,
    retract(gold(G)),
    asserta(gold(NewG)),nl,
    write('Pembelian sukses. Yey jadi banyak barang!'),nl,
    % Belom ada masukin ke inven
    !.


% Kasus duit gacukup
buy_chicken :-
    gold(G),
    G < 500,nl,
    write('Duit anda kurang pak. Sana kerja lagi!'),nl,
    !.

% Kasus duit memenuhi
buy_chicken :-
    gold(G),
    G >= 500,
    NewG is G - 500,
    retract(gold(G)),
    asserta(gold(NewG)),nl,
    write('Pembelian sukses. Yey jadi banyak barang!'),nl,
    % Belom ada masukin ke inven
    !.


% Kasus duit gacukup
buy_sheep :-
    gold(G),
    G < 1000,nl,
    write('Duit anda kurang pak. Sana kerja lagi!'),nl,
    !.

% Kasus duit memenuhi
buy_sheep :-
    gold(G),
    G >= 1000,
    NewG is G - 1000,
    retract(gold(G)),
    asserta(gold(NewG)),nl,
    write('Pembelian sukses. Yey jadi banyak barang!'),nl,
    % Belom ada masukin ke inven
    !.

% Kasus duit gacukup
buy_cow :-
    gold(G),
    G < 1500,nl,
    write('Duit anda kurang pak. Sana kerja lagi!'),nl,
    !.

% Kasus duit memenuhi
buy_cow :-
    gold(G),
    G >= 1500,
    NewG is G - 1500,
    retract(gold(G)),
    asserta(gold(NewG)),nl,
    write('Pembelian sukses. Yey jadi banyak barang!'),nl,
    % Belom ada masukin ke inven
    !.