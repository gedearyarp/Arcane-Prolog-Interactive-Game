
/* FARMING SEEDS */
item(seed, corn_seed).
item(seed, apple_seed).
item(seed, watermelon_seed).
item(seed, grape_seed).
item(seed, tomato_seed).
item(seed, potato_seed).
item(seed, eggplant_seed).

/* FARMING ITEMS */
item(farming, corn).
item(farming, apple).
item(farming, watermelon).
item(farming, grape).
item(farming, tomato).
item(farming, potato).
item(farming, eggplant).

/* RANCHING FEEDS */
item(feed, chicken_feed).
item(feed, cow_feed).
item(feed, goat_feed).
item(feed, sheep_feed).

/* RANCHING ITEMS */
item(ranching, chicken_meat).
item(ranching, cow_meat).
item(ranching, goat_meat).
item(ranching, sheep_meat).
item(ranching, egg).
item(ranching, wool).
item(ranching, cow_milk).
item(ranching, goat_milk).


/* FISHING ITEMS */
item(fishing, carp).
item(fishing, eel).
item(fishing, salmon).
item(fishing, sardine).
item(fishing, shark).
item(fishing, tuna).

/* EQUIPMENTS */
% asserta(item(equipment, shovel, 1)).
% asserta(item(equipment, meat_knife, 1)).
% asserta(item(equipment, fishing_net, 1)).

/* PRICE ITEMS */
priceItem(corn_seed, 15).
priceItem(apple_seed, 20).
priceItem(watermelon_seed, 25).
priceItem(grape_seed, 20).
priceItem(tomato_seed, 15).
priceItem(potato_seed, 20).
priceItem(eggplant_seed, 10).

priceItem(corn, 75).
priceItem(apple, 100).
priceItem(watermelon, 125).
priceItem(grape, 100).
priceItem(tomato, 75).
priceItem(potato, 100).
priceItem(eggplant, 50).

priceItem(chicken_feed, 40).
priceItem(cow_feed, 75).
priceItem(goat_feed, 50).
priceItem(sheep_feed, 60).

priceItem(chicken_meat, 200).
priceItem(cow_meat, 350).
priceItem(goat_meat, 250).
priceItem(sheep_meat, 300).
priceItem(egg, 50).
priceItem(wool, 300).
priceItem(cow_milk, 120).
priceItem(goat_milk, 80).

priceItem(carp, 100).
priceItem(eel, 120).
priceItem(salmon, 300).
priceItem(sardine, 75).
priceItem(shark, 250).
priceItem(tuna, 225).

priceItem(shovel, 750).
priceItem(meat_knife, 750).
priceItem(fishing_net, 750).

% Item Names
itemName(corn_seed, 'Corn Seed').
itemName(apple_seed, 'Apple Seed').
itemName(watermelon_seed, 'Watermelon Seed').
itemName(grape_seed, 'Grape Seed').
itemName(tomato_seed, 'Tomato Seed').
itemName(potato_seed, 'Potato Seed').
itemName(eggplant_seed, 'Eggplant Seed').

itemName(corn, 'Corn').
itemName(apple, 'Apple').
itemName(watermelon, 'Watermelon').
itemName(grape, 'Grape').
itemName(tomato, 'Tomato').
itemName(potato, 'Potato').
itemName(eggplant, 'Eggplant').

itemName(chicken_feed, 'Chicken Food').
itemName(cow_feed, 'Cow Food').
itemName(goat_feed, 'Goat Food').
itemName(sheep_feed, 'Sheep Food').

itemName(chicken_meat, 'Chicken Meat').
itemName(cow_meat, 'Cow Meat').
itemName(goat_meat, 'Goat Meat').
itemName(sheep_meat, 'Sheep Meat').
itemName(egg, 'Egg').
itemName(wool, 'Wool').
itemName(cow_milk, 'Cow Milk').
itemName(goat_milk, 'Goat Milk').

itemName(carp, 'Carp').
itemName(eel, 'Eel').
itemName(salmon, 'Salmon').
itemName(sardine, 'Sardine').
itemName(shark, 'Shark').
itemName(tuna, 'Tuna').

itemName(shovel, 'Shovel').
itemName(meat_knife, 'Meat Knife').
itemName(fishing_net, 'Fishing Net').

% Item Grades
itemGrade(1, 'Normal').
itemGrade(2, 'Improved').
itemGrade(3, 'Antique').
itemGrade(4, 'Epic').
itemGrade(5, 'Exotic').

/* LEVEL UP EQUIPMENTS */


/* USE ITEM */
