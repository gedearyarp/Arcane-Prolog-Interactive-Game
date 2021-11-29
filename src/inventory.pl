:- dynamic(sizeInventory/1).
:- dynamic(currInventory/1).

% DECLARE VALUE %
maxInventory(100).
currInventory([]).

inventory :-
    showInventory,
    write('\nWhat do you want to do?\n'),
    write('1. Use Item\n'),
    write('2. Throw Item\n'),
    write('3. Exit\n'),
    write('Enter command: '), read(Input), nl,
    (
    Input == 1 -> 
    sizeUseableInventory(SizeUseableInventory),
    (SizeUseableInventory == 0 ->
    write('You don\'t have any usable item in your inventory.\n');
    showUseableInventory,
    write('\nWhat do you want to use? (please input the COMMAND form) '), 
    read(InputUseable), nl,
    currInventory(Inventory),
    (member(InputUseable, Inventory) ->
    useItemInventory(InputUseable),
    item(CtgUse, InputUseable),
    (CtgUse = potion -> 
    usePotion(InputUseable), !;
    useUseable(InputUseable), !
    );
    format('You don\'t have ~w in your inventory or you input the wrong command.\n', [InputUseable]), !
    ), !);

    Input == 2 ->
    sizeInventory(SizeInventory),
    ( SizeInventory == 0 ->
    write('Your inventory is empty, you don\'t have any items to throw.');
    showRemoveableInventory,
    write('\nWhat do you want to throw? (please input the COMMAND form) '),
    read(InputThrow), nl,
    currInventory(Inventory),
    (member(InputThrow, Inventory) -> 
    itemName(InputThrow, ItemThrowName),
    cntItemInventory(InputThrow, Inventory, CntThrow),
    format('You have ~w ~w. How many do you want to throw?\n', [CntThrow, ItemThrowName]),
    read(InputManyThrow), nl,
    (InputManyThrow > CntThrow ->
    format('You don’t have enough ~w. Cancelling...\n', [ItemThrowName]);
    throwItem(InputThrow, InputManyThrow),
    format('You threw away ~w ~w.\n', [InputManyThrow, ItemThrowName])
    );
    format('You don\'t have ~w in your inventory or you input the wrong command.\n', [InputThrow])
    ), !);

    Input == 3 -> !;
    write('Wrong input! Please input the right command\n'),
    inventory,
    !).

% ADD ITEM TO INVENTORY %
addItem(Item) :-
    sizeInventory(SizeInventory),
    maxInventory(MaxInventory),
    (SizeInventory == MaxInventory -> !, write('Your inventory is full.'), fail;
    currInventory(CurrInventory),
    append(CurrInventory, [Item], NewInventory),
    retractall(currInventory(_)),
    asserta(currInventory(NewInventory)),!).

addItem(Item) :-
    currInventory(CurrInventory),
    append(CurrInventory, [Item], NewInventory),
    retractall(currInventory(_)),
    asserta(currInventory(NewInventory)),!.

addItem(_,0) :- !.

addItem(Item, Amount) :-
    addItem(Item),
    NewAmount is (Amount - 1),
    addItem(Item, NewAmount).

% COUNT SPECIFIC ITEM IN INVENTORY %
cntItemInventory(_,[],0).

cntItemInventory(H, [H|T], N) :- 
    cntItemInventory(H, T, NewN), 
    N is 1 + NewN, !.

cntItemInventory(H, [_|T], N) :- 
    cntItemInventory(H, T, NewN), 
    N is NewN, !.

% COUNT SPECIFIC CATEGORY IN INVENTORY %
cntCategoryInventory(_, [], 0).

cntCategoryInventory(Ctg, [H|T],N) :- 
    item(Category, H),
    (Category == Ctg -> 
    cntCategoryInventory(Ctg, T, NewN),
    N is NewN + 1, !;
    cntCategoryInventory(Ctg, T, NewN),
    N is NewN, !
    ).

testctg :-
    currInventory(Inventory),
    cntCategoryInventory(animal, Inventory, Quantity),
    format('kategori hewan ~w',[Quantity]).

% COUNT SIZE OF INVENTORY %
cntInventory([], 0).

cntInventory([_|T], Count) :-
    cntInventory(T, NewCount),
    Count is (NewCount + 1),!.

cntUsableInventory([], 0).

cntUsableInventory([H|T], Count) :-
    item(Category, H),
    ((Category = ranching; Category = fishing; Category = farming ; Category = potion) -> 
    cntUsableInventory(T, NewCount),
    Count is NewCount +1;
    cntUsableInventory(T, NewCount),
    Count is NewCount, !
    ), !.

cntSellableInventory([], 0).

cntSellableInventory([H|T], Count) :-
    item(Category, H),
    item(Category, H),
    ((Category = animal; Category = potion; Category = equipment) -> 
    cntSellableInventory(T, NewCount),
    Count is NewCount;
    cntSellableInventory(T, NewCount),
    Count is NewCount + 1, !
    ), !.

sizeInventory(SizeInventory) :-
    currInventory(Inventory),
    cntInventory(Inventory,SizeInventory),!.

sizeUseableInventory(SizeInventory) :-
    currInventory(Inventory),
    cntUsableInventory(Inventory,SizeInventory),!.

% PRINT INVENTORY %
printInventory([]) :- !.

printInventory([H|T]) :-
    currInventory(Inventory),
    item(Category, H),
    (Category == 'animal' -> !;
    Category == 'equipment' -> itemName(H,ItemName),
    equipment(H, Level), itemGrade(Level, Rarity),
    format('~w ~w\n', [Rarity, ItemName]);
    
    cntItemInventory(H, Inventory, Quantity),
    itemName(H, ItemName),
    format('~w ~ws\n',[Quantity, ItemName]),!
    ),
    printInventory(T), !.

printUseableInventory([]) :- !.

printUseableInventory([H|T]) :-
    currInventory(Inventory),
    item(Category, H),
    (Category == 'ranching' -> 
    cntItemInventory(H, Inventory, Quantity),
    itemName(H, ItemName),
    format('~w ~ws (COMMAND: ~w)\n',[Quantity, ItemName, H]),!;!
    ),
    (Category == 'fishing' -> 
    cntItemInventory(H, Inventory, Quantity),
    itemName(H, ItemName),
    format('~w ~ws (COMMAND: ~w)\n',[Quantity, ItemName, H]),!;!
    ),
    (Category == 'farming' -> 
    cntItemInventory(H, Inventory, Quantity),
    itemName(H, ItemName),
    format('~w ~ws (COMMAND: ~w)\n',[Quantity, ItemName, H]),!;!
    ),
    (Category == 'potion' -> 
    cntItemInventory(H, Inventory, Quantity),
    itemName(H, ItemName),
    format('~w ~ws (COMMAND: ~w)\n',[Quantity, ItemName, H]),!;!
    ),
    printUseableInventory(T), !.

printRemoveableInventory([]) :- !.

printRemoveableInventory([H|T]) :-
    currInventory(Inventory),
    item(Category, H),
    (Category == 'animal'; Category == 'equipment'-> !;
    cntItemInventory(H, Inventory, Quantity),
    itemName(H, ItemName),
    format('~w ~ws (COMMAND: ~w)\n',[Quantity, ItemName, H]),!
    ),
    printRemoveableInventory(T), !.

printSellableInventory([]) :- !.

printSellableInventory([H|T]) :-
    currInventory(Inventory),
    item(Category, H),
    (Category == 'animal'; Category == 'equipment'; Category == 'potion'-> !;
    cntItemInventory(H, Inventory, Quantity),
    itemName(H, ItemName),
    format('~w ~ws (COMMAND: ~w)\n',[Quantity, ItemName, H]),!
    ),
    printRemoveableInventory(T), !.

% SHOW INVENTORY %
showInventory :-
    currInventory(Inventory),
    (Inventory = [],
    write('Your inventory is empty\n'),!;
    maxInventory(MaxInventory),
    sizeInventory(SizeInventory),
    format('Your inventory (~w / ~w)\n',[SizeInventory, MaxInventory]),
    sort(Inventory),
    printInventory(Inventory),! 
    ).

showUseableInventory :-
    currInventory(Inventory),
    (Inventory = [],
    write('Your inventory is empty\n'),!;
    write('Inventory\n'),
    sort(Inventory),
    printUseableInventory(Inventory),! 
    ).

showRemoveableInventory :-
    currInventory(Inventory),
    (Inventory = [],
    write('Your inventory is empty\n'),!;
    write('Inventory\n'),
    sort(Inventory),
    printRemoveableInventory(Inventory),! 
    ).

showSellableInventory :-
    currInventory(Inventory),
    cntSellableInventory(Inventory, Size),
    (Size = 0,
    write('Your inventory is empty\n'),!;
    write('Inventory\n'),
    sort(Inventory),
    printSellableInventory(Inventory),! 
    ).

% USE ITEM FROM INVENTORY %
useUseable(Item) :-
    itemEnergy(Item, Power),
    increaseEnergy(Power),
    throwItem(Item).

useItemInventory(Item) :- 
    currInventory(Inventory),
    itemName(Item, ItemName),
    \+ member(Item,Inventory), !, format('There is no ~w in your inventory!\n', [ItemName]), fail. 

useItemInventory(Item) :-
    currInventory(Inventory),
    retractall(currInventory(_)),
    select(Item,Inventory, NewInventory),
    asserta(currInventory(NewInventory)),!.

% THROW ITEM FROM INVENTORY %
throwItem(Item) :- 
    currInventory(Inventory),
    \+ member(Item, Inventory), !, 
    itemName(Item, ItemName),
    format('There is no ~w in your inventory!\n', [ItemName]), fail.


throwItem(Item) :-
    currInventory(Inventory),
    retractall(currInventory(_)),
    select(Item, Inventory, NewInventory),
    asserta(currInventory(NewInventory)),!.

throwItem(_, 0) :- !.

throwItem(Item, _) :- 
    currInventory(Inventory),
    \+ member(Item, Inventory), !, 
    itemName(Item, ItemName),
    format('There is no ~w in your inventory!\n', [ItemName]), fail. 

throwItem(Item, Amount) :- 
    currInventory(Inventory),
    cntItemInventory(Item, Inventory, Quantity),
    itemName(Item, ItemName),
    (Quantity < Amount -> !, format('There is only ~w ~w in inventory!\n', [Quantity, ItemName]), fail;
    retractall(currInventory(_)),
    select(Item, Inventory, NewInventory),
    asserta(currInventory(NewInventory)),
    NewAmount is Amount - 1,
    throwItem(Item, NewAmount),!).