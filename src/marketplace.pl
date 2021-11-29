% TODO : Check if in market, Equipments level, Sync inventory

% DEBUG CODE STARTS HERE
% :- dynamic(gold/1).
% :- include('inventory.pl').
% :- include('items.pl').
% :- include('musim.pl').
% :- dynamic(inMarket/1).
% :- dynamic(totalGold/1).
% inMarket(t).

% totalGold(5000).
% gold(5000).
% DEBUG CODE ENDS HERE

/* Sell Price Rate (based on player's job level) */
priceRate(1, 0.133).
priceRate(2, 0.333).
priceRate(3, 0.533).
priceRate(4, 0.733).
priceRate(5, 0.933).

market :-
    inMarket(_),
    write('Welcome to the secret shop!'),nl,
    write('1. Beli'),nl,
    write('2. Jual'),nl,
    write('3. Upgrade Equipment'), nl,
    write('4. Mo pulang ajh'), nl,
    write('Masukkan pilihan: '),read(X),
    (X =:= 1 -> !, beli;
    X =:= 2 -> !, jual;
    X =:= 3 -> !, upgradeEq;
    X =:= 4 -> !, exitMarket;
    market, write('Wrong input, please choose a number (1-4)')),nl,
    !.

market :-
    \+inMarket(_),
    write('Kamu tidak berada pada market.'),nl,
    !.


beli :-
    write('Mau beli apa?'),nl,
    write('1. Seed'),nl,
    write('2. Ranch animal'),nl,
    write('3. Animal food'),nl,
    
    write('Masukkan pilihan: '), read(X),
    (X =:= 1 -> !, buySeed;
    X =:= 2 -> !, buyAnimal;
    X =:= 3 -> !, buyAnimalFood;
    X =:= 4 -> !, exitMarket, fail;
    write('Invalid input.'), nl, nl, market),nl,nl,
    !.

printMarket([]).
printMarket([A|B]) :-
    itemName(A, Nama),
    priceItem(A, Harga),
    write('- '), write(Nama), write(' ('), write(Harga), write(' G)'), write(', Kode: '), write(A),nl,
    printMarket(B).

buySeed :-
    write('Seed market. The finest there is.'), nl,
    currentSeason(Season),
    findall(Nama, itemSeason(Season, Nama), ListNama),
    printMarket(ListNama), nl,
    write('Pilihanmu (kode): '),
    read(Input), nl,
    write('Mau beli berapa banyak: '),
    read(Amount), nl,
    (item(seed,Input) -> buyItem(Input, Amount);
    \+item(seed,Input) -> !, write('Tidak ada item itu hei! Balik sana ke market!'), nl, nl, market),
    !.


buyAnimal :-
    write('TOKO HEWAN FFfFFfAy o((>ω< ))o.'), nl,
    findall(Nama, item(animal, Nama), ListNama),
    printMarket(ListNama), nl,
    write('Pilihanmu (kode): '),
    read(Input), nl,
    write('Mau beli berapa banyak: '),
    read(Amount), nl,
    (item(animal,Input) -> buyItem(Input, Amount);
    \+item(animal,Input) -> !, write('Tidak ada item itu hei! Balik sana ke market!'), nl, nl, market),
    !.

buyAnimalFood :-
    write('Animal food market. Your cow will love it.'), nl,
    findall(Nama, item(feed, Nama), ListNama),
    printMarket(ListNama), nl,
    write('Pilihanmu (kode): '),
    read(Input), nl,
    write('Mau beli berapa banyak: '),
    read(Amount), nl,
    (item(feed,Input) -> buyItem(Input, Amount);
    \+item(feed,Input) -> !, write('Tidak ada item itu hei! Balik sana ke market!'), nl, nl, market),
    !.

buyItem(Item, Amount) :-
    gold(G),
    priceItem(Item, OnePrice),
    Price is OnePrice * Amount,
    G >= Price,
    GNew is G - Price,
    item(Category, Item),
    (Category \= animal -> true(_); Category = animal -> initAnimal(Item)),
    addItem(Item, Amount),
    retract(gold(G)),
    asserta(gold(GNew)),
    itemName(Item, Name),
    format('Berhasil membeli ~w ~w!', [Amount, Name]), nl,
    write('Mau beli apa lagi?'), nl, nl,
    market,
    !.

buyItem(Item, Amount) :-
    gold(G),
    priceItem(Item, OnePrice),
    Price is OnePrice * Amount,
    G < Price,
    write('Duit kamu kurang :( Sana kerja lagi!'), nl,
    market,
    !.

buyItem(_, Amount) :-
    Amount < 1,
    write('Jumlah invalid. Mengembalikan ke market\n'),
    market,
    !.

exitMarket :-
    write('Buh-bye!'), nl,
    !.

jual :-
    currInventory(Inventory),
    cntSellableInventory(Inventory, Size),
    (Size = 0 -> write('Item kamu ga ada yang bisa dijual. Apa yang mau dijual coba -_-\n') , market, fail;
    true(_)),
    showSellableInventory, nl,
    write('Pilihanmu (COMMAND): '), read(Input),nl,
    (
    member(Input, Inventory) -> write('Mau jual berapa? '), read(Amount), nl, jualItem(Input, Amount);
    write('Invalid input. Mengembalikan ke market.\n'), market),
    !.

bonusPrice(Item, BonusPrice) :-
    item(Category, Item),
    priceItem(Item, BasePrice),
    fishingLevel(FishingLevel),
    ranchingLevel(RanchingLevel),
    farmingLevel(FarmingLevel),        
    (Category = farming -> Level is FarmingLevel;
    Category = fishing -> Level is FishingLevel;
    (Category = ranching; Category = ranchingNonUseable) -> Level is RanchingLevel;
    Level is 0),
    (Level =:= 0 ->
    write(''),
    BonusPrice is 0, !;

    priceRate(Level, Rate),
    BonusRate is round(BasePrice * Rate),
    BonusPrice is BonusRate + BasePrice, !), !.

seedfeedPrice(Item, NegPrice) :-
    item(Category, Item),
    priceItem(Item, BasePrice),
    Mult is BasePrice * 0.6,
    MultB is ceiling(Mult),
    (Category = seed -> NegPrice is MultB;
    Category = feed -> NegPrice is MultB;
    NegPrice is 0, !).

jualItem(_, Amount) :-
    Amount < 1,
    write('Invalid amount. Mengembalikan ke menu jual...'),
    jual,
    !.

jualItem(Input, Amount) :-
    gold(G),
    totalGold(TG),
    throwItem(Input,Amount),
    priceItem(Input,Price),
    itemName(Input, ItemName),
    bonusPrice(Input, BonusPrice),
    seedfeedPrice(Input, SPrice),
    PrevTotalPrice is Amount * Price,
    TotalPrice is PrevTotalPrice + BonusPrice,
    GrandTotalPrice is TotalPrice - SPrice,
    GNew is G + TotalPrice,
    TGNew is TG + TotalPrice,
    retract(gold(G)),
    asserta(gold(GNew)),
    retract(totalGold(TG)),
    asserta(totalGold(TGNew)),
    format('Berhasil menjual ~w sebanyak ~w buah!', [ItemName,Amount]), nl,
    format('Anda mendapatkan ~w gold.', [GrandTotalPrice]),nl,
    write('Mengembalikan ke menu market..'), nl, nl,
    market,
    !.


upgradeEq :-
    equipment(shovel, ShovelLevel),
    equipment(fishing_rod, RodLevel),
    equipment(knife, KnifeLevel),
    itemGrade(ShovelLevel, SGrade),
    itemGrade(RodLevel, RGrade),
    itemGrade(KnifeLevel, KGrade),
    write('Level equipment sekarang: '), nl,
    format('1. ~w Shovel (Level ~w)', [SGrade, ShovelLevel]), nl,
    format('2. ~w Fishing Rod (Level ~w)', [RGrade, RodLevel]), nl,
    format('3. ~w Knife (Level ~w)', [KGrade, KnifeLevel]), nl,
    write('Ingin upgrade yang mana? (command angka): '), read(Choice), nl,
    (Choice =:= 1 -> upgradeItem(shovel, ShovelLevel);
    Choice =:= 2 -> upgradeItem(fishing_rod, RodLevel);
    Choice =:= 3 -> upgradeItem(knife, KnifeLevel);
    write('Invalid input.'), nl, nl, market),
    !.

upgradeItem(Type,1) :-
    priceEquipment(Type,2,Price),
    gold(G),
    G < Price,
    write('Duit kamu kurang :( Sana kerja lagi!'), nl,
    market,
    !.

upgradeItem(Type, 1) :-
    priceEquipment(Type,2,Price),
    gold(G),
    G >= Price,
    GNew is G - Price,
    retract(gold(G)),
    asserta(gold(GNew)),
    retract(equipment(Type,_)),
    asserta(equipment(Type,2)),
    itemName(Type, Name),
    write('Berhasil mengupgrade '), write(Name), write('!'), nl,
    write('Mau beli apa lagi?'), nl, nl,
    market,
    !.

upgradeItem(Type,2) :-
    priceEquipment(Type,3,Price),
    gold(G),
    G < Price,
    write('Duit kamu kurang :( Sana kerja lagi!'), nl,
    market,
    !.

upgradeItem(Type, 2) :-
    priceEquipment(Type,3,Price),
    gold(G),
    G >= Price,
    GNew is G - Price,
    retract(gold(G)),
    asserta(gold(GNew)),
    retract(equipment(Type,_)),
    asserta(equipment(Type,3)),
    itemName(Type, Name),
    write('Berhasil mengupgrade '), write(Name), write('!'), nl,
    write('Mau beli apa lagi?'), nl, nl,
    market,
    !.

upgradeItem(_,3) :-
    write('Level equipment sudah maksimal.'), nl,
    market,
    !.

itemCheat :-
    addItem(cow),
    addItem(tuna),
    addItem(shark),
    addItem(chicken_meat,5),
    addItem(cow_milk, 7).