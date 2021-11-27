
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
asserta(item(equipment, shovel, 1)).
asserta(item(equipment, meat_knife, 1)).
asserta(item(equipment, fishing_net, 1)).

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
priceItem(cow_meat, 350)
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

/* LEVEL UP EQUIPMENTS */


/* USE ITEM */
