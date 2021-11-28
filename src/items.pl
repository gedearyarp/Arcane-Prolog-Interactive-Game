:- dynamic(equipment/2).

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

/* ANIMAL ITEM */
item(animal, chicken).
item(animal, cow).
item(animal, sheep).
item(animal, goat).

/* FISHING ITEMS */
item(fishing, carp).
item(fishing, eel).
item(fishing, salmon).
item(fishing, sardine).
item(fishing, shark).
item(fishing, tuna).

/* POTION ITEMS */
item(potion, potion_fishing_level).
item(potion, potion_ranching_level).
item(potion, potion_farming_level).
item(potion, potion_player_level).
item(potion, potion_super_level).

/* EQUIPMENT ITEMS */
item(equipment, shovel).
item(equipment, fishing_rod).
item(equipment, knife).

/* EQUIPMENT DETAIL */
equipment(shovel, 1).
equipment(fishing_rod, 1).
equipment(knife, 1).

/* PRICE EQUIPMENT */
priceEquipment(shovel, 2, 1000).
priceEquipment(fishing_rod, 2, 1000).
priceEquipment(knife, 2, 1000).

priceEquipment(shovel, 3, 1500).
priceEquipment(fishing_rod, 3, 1500).
priceEquipment(knife, 3, 1500).

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

priceItem(chicken_feed, 10).
priceItem(cow_feed, 30).
priceItem(goat_feed, 20).
priceItem(sheep_feed, 25).

priceItem(cow, 2000).
priceItem(chicken, 1000).
priceItem(sheep, 1500).
priceItem(goat, 1200).

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

priceItem(potion_fishing_level, 3000).
priceItem(potion_ranching_level, 3000).
priceItem(potion_farming_level, 3000).
priceItem(potion_player_level, 4000).
priceItem(potion_super_level, 5000).

/* ITEMS NAME */
itemName(shovel, 'Shovel').
itemName(fishing_rod, 'Fishing Rod').
itemName(knife, 'Knife').

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

itemName(chicken, 'Chicken').
itemName(cow, 'Cow').
itemName(sheep, 'Sheep').
itemName(goat, 'Goat').

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

itemName(potion_fishing_level, 'F15h1nG Potion').
itemName(potion_ranching_level, 'R4nch1n6 Potion').
itemName(potion_farming_level, 'F@rM!nG Potion').
itemName(potion_player_level, '66 64M1N6 Potion').
itemName(potion_super_level, '5UP3R 66 64M1N6 Potion').

/* ITEMS GRADE */
itemGrade(1, 'Normal').
itemGrade(2, 'Improved').
itemGrade(3, 'Antique').
itemGrade(4, 'Epic').
itemGrade(5, 'Exotic').