/*
DROP TABLE cardcolors;
DROP TABLE cardsubtypes;
DROP TABLE cardtypes;
DROP TABLE subtypes;
DROP TABLE types;
DROP TABLE cards;
DROP TABLE rarities;
DROP TABLE expansionsets;
DROP TABLE basecards;
DROP TABLE colors;
*/

CREATE TABLE colors (
  id CHAR(1) NOT NULL PRIMARY KEY,
  color CHAR(9) NOT NULL
  ) ENGINE InnoDB  CHARACTER SET utf8;

INSERT INTO colors (color, id) VALUES ('White','W');
INSERT INTO colors (color, id) VALUES ('Blue','U');
INSERT INTO colors (color, id) VALUES ('Black','B');
INSERT INTO colors (color, id) VALUES ('Red','R');
INSERT INTO colors (color, id) VALUES ('Green','G');
INSERT INTO colors (color, id) VALUES ('Colorless','c');


CREATE TABLE basecards (
  id INT(11) NOT NULL auto_increment PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  rules_text VARCHAR(1000),
  mana_cost VARCHAR(60) NOT NULL DEFAULT '',
  cmc SMALLINT NOT NULL DEFAULT 0,
  power CHAR(4),
  toughness CHAR(4),
  loyalty CHAR(4),
  created_at DATETIME,
  updated_at DATETIME
  ) ENGINE InnoDB  CHARACTER SET utf8;


CREATE TABLE expansionsets (
  id INT(11) NOT NULL auto_increment PRIMARY KEY,
  name VARCHAR(128) NOT NULL UNIQUE
  ) ENGINE InnoDB  CHARACTER SET utf8;


CREATE TABLE rarities (
  id CHAR(1) NOT NULL PRIMARY KEY,
  rarity CHAR(11) NOT NULL,
  sortorder SMALLINT
  ) ENGINE InnoDB  CHARACTER SET utf8;

INSERT INTO rarities (rarity, id, sortorder) VALUES ('Common','c',0);
INSERT INTO rarities (rarity, id, sortorder) VALUES ('Uncommon','u',1);
INSERT INTO rarities (rarity, id, sortorder) VALUES ('Rare','r',2);
INSERT INTO rarities (rarity, id, sortorder) VALUES ('Mythic Rare','m',3);


CREATE TABLE cards (
  expansionset_id INT,
  basecard_id INT,
  rarity CHAR(1),
  multiverseid INT UNIQUE,
  flavor_text VARCHAR(1000),
  created_at DATETIME,
  updated_at DATETIME,
  PRIMARY KEY (expansionset_id, basecard_id),
  FOREIGN KEY (basecard_id) 
        REFERENCES basecards(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
  FOREIGN KEY (expansionset_id)
        REFERENCES expansionsets(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
  FOREIGN KEY (rarity)
        REFERENCES rarities(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
  ) ENGINE InnoDB  CHARACTER SET utf8;


CREATE TABLE types (
  id INT(11) NOT NULL auto_increment PRIMARY KEY,
  type VARCHAR(128) NOT NULL
  ) ENGINE InnoDB  CHARACTER SET utf8;
INSERT INTO types (type) VALUES ('Artifact');
INSERT INTO types (type) VALUES ('Basic');
INSERT INTO types (type) VALUES ('Creature');
INSERT INTO types (type) VALUES ('Enchantment');
INSERT INTO types (type) VALUES ('Instant');
INSERT INTO types (type) VALUES ('Land');
INSERT INTO types (type) VALUES ('Legendary');
INSERT INTO types (type) VALUES ('Ongoing');
INSERT INTO types (type) VALUES ('Phenomenon');
INSERT INTO types (type) VALUES ('Plane');
INSERT INTO types (type) VALUES ('Planeswalker');
INSERT INTO types (type) VALUES ('Scheme');
INSERT INTO types (type) VALUES ('Snow');
INSERT INTO types (type) VALUES ('Sorcery');
INSERT INTO types (type) VALUES ('Tribal');
INSERT INTO types (type) VALUES ('Vanguard');
INSERT INTO types (type) VALUES ('World');


CREATE TABLE subtypes (
  id INT(11) NOT NULL auto_increment PRIMARY KEY,
  subtype VARCHAR(128) NOT NULL
  ) ENGINE InnoDB  CHARACTER SET utf8;
INSERT INTO subtypes (subtype) VALUES ('Advisor');
INSERT INTO subtypes (subtype) VALUES ('Ajani');
INSERT INTO subtypes (subtype) VALUES ('Alara');
INSERT INTO subtypes (subtype) VALUES ('Ally');
INSERT INTO subtypes (subtype) VALUES ('Angel');
INSERT INTO subtypes (subtype) VALUES ('Anteater');
INSERT INTO subtypes (subtype) VALUES ('Antelope');
INSERT INTO subtypes (subtype) VALUES ('Ape');
INSERT INTO subtypes (subtype) VALUES ('Arcane');
INSERT INTO subtypes (subtype) VALUES ('Archer');
INSERT INTO subtypes (subtype) VALUES ('Archon');
INSERT INTO subtypes (subtype) VALUES ('Arkhos');
INSERT INTO subtypes (subtype) VALUES ('Artificer');
INSERT INTO subtypes (subtype) VALUES ('Assassin');
INSERT INTO subtypes (subtype) VALUES ('Assembly-Worker');
INSERT INTO subtypes (subtype) VALUES ('Atog');
INSERT INTO subtypes (subtype) VALUES ('Aura');
INSERT INTO subtypes (subtype) VALUES ('Aurochs');
INSERT INTO subtypes (subtype) VALUES ('Avatar');
INSERT INTO subtypes (subtype) VALUES ('Azgol');
INSERT INTO subtypes (subtype) VALUES ('Badger');
INSERT INTO subtypes (subtype) VALUES ('Barbarian');
INSERT INTO subtypes (subtype) VALUES ('Basilisk');
INSERT INTO subtypes (subtype) VALUES ('Bat');
INSERT INTO subtypes (subtype) VALUES ('Bear');
INSERT INTO subtypes (subtype) VALUES ('Beast');
INSERT INTO subtypes (subtype) VALUES ('Beeble');
INSERT INTO subtypes (subtype) VALUES ('Belenon');
INSERT INTO subtypes (subtype) VALUES ('Berserker');
INSERT INTO subtypes (subtype) VALUES ('Bird');
INSERT INTO subtypes (subtype) VALUES ('Boar');
INSERT INTO subtypes (subtype) VALUES ('Bolas');
INSERT INTO subtypes (subtype) VALUES ('Bolas''s');
INSERT INTO subtypes (subtype) VALUES ('Bringer');
INSERT INTO subtypes (subtype) VALUES ('Brushwagg');
INSERT INTO subtypes (subtype) VALUES ('Camel');
INSERT INTO subtypes (subtype) VALUES ('Carrier');
INSERT INTO subtypes (subtype) VALUES ('Cat');
INSERT INTO subtypes (subtype) VALUES ('Centaur');
INSERT INTO subtypes (subtype) VALUES ('Cephalid');
INSERT INTO subtypes (subtype) VALUES ('Chandra');
INSERT INTO subtypes (subtype) VALUES ('Chimera');
INSERT INTO subtypes (subtype) VALUES ('Cleric');
INSERT INTO subtypes (subtype) VALUES ('Cockatrice');
INSERT INTO subtypes (subtype) VALUES ('Construct');
INSERT INTO subtypes (subtype) VALUES ('Crab');
INSERT INTO subtypes (subtype) VALUES ('Crocodile');
INSERT INTO subtypes (subtype) VALUES ('Curse');
INSERT INTO subtypes (subtype) VALUES ('Cyclops');
INSERT INTO subtypes (subtype) VALUES ('Dauthi');
INSERT INTO subtypes (subtype) VALUES ('Demon');
INSERT INTO subtypes (subtype) VALUES ('Desert');
INSERT INTO subtypes (subtype) VALUES ('Devil');
INSERT INTO subtypes (subtype) VALUES ('Djinn');
INSERT INTO subtypes (subtype) VALUES ('Dominaria');
INSERT INTO subtypes (subtype) VALUES ('Domri');
INSERT INTO subtypes (subtype) VALUES ('Dragon');
INSERT INTO subtypes (subtype) VALUES ('Drake');
INSERT INTO subtypes (subtype) VALUES ('Dreadnought');
INSERT INTO subtypes (subtype) VALUES ('Drone');
INSERT INTO subtypes (subtype) VALUES ('Druid');
INSERT INTO subtypes (subtype) VALUES ('Dryad');
INSERT INTO subtypes (subtype) VALUES ('Dwarf');
INSERT INTO subtypes (subtype) VALUES ('Efreet');
INSERT INTO subtypes (subtype) VALUES ('Egg');
INSERT INTO subtypes (subtype) VALUES ('Elder');
INSERT INTO subtypes (subtype) VALUES ('Eldrazi');
INSERT INTO subtypes (subtype) VALUES ('Elemental');
INSERT INTO subtypes (subtype) VALUES ('Elephant');
INSERT INTO subtypes (subtype) VALUES ('Elf');
INSERT INTO subtypes (subtype) VALUES ('Elk');
INSERT INTO subtypes (subtype) VALUES ('Elspeth');
INSERT INTO subtypes (subtype) VALUES ('Equilor');
INSERT INTO subtypes (subtype) VALUES ('Equipment');
INSERT INTO subtypes (subtype) VALUES ('Ergamon');
INSERT INTO subtypes (subtype) VALUES ('Eye');
INSERT INTO subtypes (subtype) VALUES ('Fabacin');
INSERT INTO subtypes (subtype) VALUES ('Faerie');
INSERT INTO subtypes (subtype) VALUES ('Ferret');
INSERT INTO subtypes (subtype) VALUES ('Fish');
INSERT INTO subtypes (subtype) VALUES ('Flagbearer');
INSERT INTO subtypes (subtype) VALUES ('Forest');
INSERT INTO subtypes (subtype) VALUES ('Fortification');
INSERT INTO subtypes (subtype) VALUES ('Fox');
INSERT INTO subtypes (subtype) VALUES ('Frog');
INSERT INTO subtypes (subtype) VALUES ('Fungus');
INSERT INTO subtypes (subtype) VALUES ('Gargoyle');
INSERT INTO subtypes (subtype) VALUES ('Garruk');
INSERT INTO subtypes (subtype) VALUES ('Gate');
INSERT INTO subtypes (subtype) VALUES ('Giant');
INSERT INTO subtypes (subtype) VALUES ('Gideon');
INSERT INTO subtypes (subtype) VALUES ('Gnome');
INSERT INTO subtypes (subtype) VALUES ('Goat');
INSERT INTO subtypes (subtype) VALUES ('Goblin');
INSERT INTO subtypes (subtype) VALUES ('Golem');
INSERT INTO subtypes (subtype) VALUES ('Gorgon');
INSERT INTO subtypes (subtype) VALUES ('Gremlin');
INSERT INTO subtypes (subtype) VALUES ('Griffin');
INSERT INTO subtypes (subtype) VALUES ('Hag');
INSERT INTO subtypes (subtype) VALUES ('Harpy');
INSERT INTO subtypes (subtype) VALUES ('Hellion');
INSERT INTO subtypes (subtype) VALUES ('Hippo');
INSERT INTO subtypes (subtype) VALUES ('Hippogriff');
INSERT INTO subtypes (subtype) VALUES ('Homarid');
INSERT INTO subtypes (subtype) VALUES ('Homunculus');
INSERT INTO subtypes (subtype) VALUES ('Horror');
INSERT INTO subtypes (subtype) VALUES ('Horse');
INSERT INTO subtypes (subtype) VALUES ('Hound');
INSERT INTO subtypes (subtype) VALUES ('Human');
INSERT INTO subtypes (subtype) VALUES ('Hydra');
INSERT INTO subtypes (subtype) VALUES ('Hyena');
INSERT INTO subtypes (subtype) VALUES ('Illusion');
INSERT INTO subtypes (subtype) VALUES ('Imp');
INSERT INTO subtypes (subtype) VALUES ('Incarnation');
INSERT INTO subtypes (subtype) VALUES ('Innistrad');
INSERT INTO subtypes (subtype) VALUES ('Insect');
INSERT INTO subtypes (subtype) VALUES ('Iquatana');
INSERT INTO subtypes (subtype) VALUES ('Ir');
INSERT INTO subtypes (subtype) VALUES ('Island');
INSERT INTO subtypes (subtype) VALUES ('Jace');
INSERT INTO subtypes (subtype) VALUES ('Jellyfish');
INSERT INTO subtypes (subtype) VALUES ('Juggernaut');
INSERT INTO subtypes (subtype) VALUES ('Kaldheim');
INSERT INTO subtypes (subtype) VALUES ('Kamigawa');
INSERT INTO subtypes (subtype) VALUES ('Karn');
INSERT INTO subtypes (subtype) VALUES ('Kavu');
INSERT INTO subtypes (subtype) VALUES ('Kephalai');
INSERT INTO subtypes (subtype) VALUES ('Kirin');
INSERT INTO subtypes (subtype) VALUES ('Kithkin');
INSERT INTO subtypes (subtype) VALUES ('Knight');
INSERT INTO subtypes (subtype) VALUES ('Kobold');
INSERT INTO subtypes (subtype) VALUES ('Kolbahan');
INSERT INTO subtypes (subtype) VALUES ('Kor');
INSERT INTO subtypes (subtype) VALUES ('Koth');
INSERT INTO subtypes (subtype) VALUES ('Kraken');
INSERT INTO subtypes (subtype) VALUES ('Kyneth');
INSERT INTO subtypes (subtype) VALUES ('Lair');
INSERT INTO subtypes (subtype) VALUES ('Lammasu');
INSERT INTO subtypes (subtype) VALUES ('Leech');
INSERT INTO subtypes (subtype) VALUES ('Leviathan');
INSERT INTO subtypes (subtype) VALUES ('Lhurgoyf');
INSERT INTO subtypes (subtype) VALUES ('Licid');
INSERT INTO subtypes (subtype) VALUES ('Liliana');
INSERT INTO subtypes (subtype) VALUES ('Lizard');
INSERT INTO subtypes (subtype) VALUES ('Locus');
INSERT INTO subtypes (subtype) VALUES ('Lorwyn');
INSERT INTO subtypes (subtype) VALUES ('Manticore');
INSERT INTO subtypes (subtype) VALUES ('Masticore');
INSERT INTO subtypes (subtype) VALUES ('Meditation');
INSERT INTO subtypes (subtype) VALUES ('Mercadia');
INSERT INTO subtypes (subtype) VALUES ('Mercenary');
INSERT INTO subtypes (subtype) VALUES ('Merfolk');
INSERT INTO subtypes (subtype) VALUES ('Metathran');
INSERT INTO subtypes (subtype) VALUES ('Mine');
INSERT INTO subtypes (subtype) VALUES ('Minion');
INSERT INTO subtypes (subtype) VALUES ('Minotaur');
INSERT INTO subtypes (subtype) VALUES ('Mirrodin');
INSERT INTO subtypes (subtype) VALUES ('Moag');
INSERT INTO subtypes (subtype) VALUES ('Monger');
INSERT INTO subtypes (subtype) VALUES ('Mongoose');
INSERT INTO subtypes (subtype) VALUES ('Mongseng');
INSERT INTO subtypes (subtype) VALUES ('Monk');
INSERT INTO subtypes (subtype) VALUES ('Moonfolk');
INSERT INTO subtypes (subtype) VALUES ('Mountain');
INSERT INTO subtypes (subtype) VALUES ('Muraganda');
INSERT INTO subtypes (subtype) VALUES ('Mutant');
INSERT INTO subtypes (subtype) VALUES ('Myr');
INSERT INTO subtypes (subtype) VALUES ('Mystic');
INSERT INTO subtypes (subtype) VALUES ('Nautilus');
INSERT INTO subtypes (subtype) VALUES ('Nephilim');
INSERT INTO subtypes (subtype) VALUES ('New');
INSERT INTO subtypes (subtype) VALUES ('Nightmare');
INSERT INTO subtypes (subtype) VALUES ('Nightstalker');
INSERT INTO subtypes (subtype) VALUES ('Ninja');
INSERT INTO subtypes (subtype) VALUES ('Nissa');
INSERT INTO subtypes (subtype) VALUES ('Noggle');
INSERT INTO subtypes (subtype) VALUES ('Nomad');
INSERT INTO subtypes (subtype) VALUES ('Octopus');
INSERT INTO subtypes (subtype) VALUES ('Ogre');
INSERT INTO subtypes (subtype) VALUES ('Ooze');
INSERT INTO subtypes (subtype) VALUES ('Orc');
INSERT INTO subtypes (subtype) VALUES ('Orgg');
INSERT INTO subtypes (subtype) VALUES ('Ouphe');
INSERT INTO subtypes (subtype) VALUES ('Ox');
INSERT INTO subtypes (subtype) VALUES ('Oyster');
INSERT INTO subtypes (subtype) VALUES ('Pegasus');
INSERT INTO subtypes (subtype) VALUES ('Pest');
INSERT INTO subtypes (subtype) VALUES ('Phelddagrif');
INSERT INTO subtypes (subtype) VALUES ('Phoenix');
INSERT INTO subtypes (subtype) VALUES ('Phyrexia');
INSERT INTO subtypes (subtype) VALUES ('Pirate');
INSERT INTO subtypes (subtype) VALUES ('Plains');
INSERT INTO subtypes (subtype) VALUES ('Plant');
INSERT INTO subtypes (subtype) VALUES ('Power-Plant');
INSERT INTO subtypes (subtype) VALUES ('Praetor');
INSERT INTO subtypes (subtype) VALUES ('Rabbit');
INSERT INTO subtypes (subtype) VALUES ('Rabiah');
INSERT INTO subtypes (subtype) VALUES ('Rat');
INSERT INTO subtypes (subtype) VALUES ('Rath');
INSERT INTO subtypes (subtype) VALUES ('Ravnica');
INSERT INTO subtypes (subtype) VALUES ('Realm');
INSERT INTO subtypes (subtype) VALUES ('Rebel');
INSERT INTO subtypes (subtype) VALUES ('Regatha');
INSERT INTO subtypes (subtype) VALUES ('Rhino');
INSERT INTO subtypes (subtype) VALUES ('Rigger');
INSERT INTO subtypes (subtype) VALUES ('Rogue');
INSERT INTO subtypes (subtype) VALUES ('Salamander');
INSERT INTO subtypes (subtype) VALUES ('Samurai');
INSERT INTO subtypes (subtype) VALUES ('Sarkhan');
INSERT INTO subtypes (subtype) VALUES ('Satyr');
INSERT INTO subtypes (subtype) VALUES ('Scarecrow');
INSERT INTO subtypes (subtype) VALUES ('Scorpion');
INSERT INTO subtypes (subtype) VALUES ('Scout');
INSERT INTO subtypes (subtype) VALUES ('Segovia');
INSERT INTO subtypes (subtype) VALUES ('Serpent');
INSERT INTO subtypes (subtype) VALUES ('Serra''s');
INSERT INTO subtypes (subtype) VALUES ('Shade');
INSERT INTO subtypes (subtype) VALUES ('Shadowmoor');
INSERT INTO subtypes (subtype) VALUES ('Shaman');
INSERT INTO subtypes (subtype) VALUES ('Shandalar');
INSERT INTO subtypes (subtype) VALUES ('Shapeshifter');
INSERT INTO subtypes (subtype) VALUES ('Sheep');
INSERT INTO subtypes (subtype) VALUES ('Shrine');
INSERT INTO subtypes (subtype) VALUES ('Siren');
INSERT INTO subtypes (subtype) VALUES ('Skeleton');
INSERT INTO subtypes (subtype) VALUES ('Slith');
INSERT INTO subtypes (subtype) VALUES ('Sliver');
INSERT INTO subtypes (subtype) VALUES ('Slug');
INSERT INTO subtypes (subtype) VALUES ('Snake');
INSERT INTO subtypes (subtype) VALUES ('Soldier');
INSERT INTO subtypes (subtype) VALUES ('Soltari');
INSERT INTO subtypes (subtype) VALUES ('Sorin');
INSERT INTO subtypes (subtype) VALUES ('Spawn');
INSERT INTO subtypes (subtype) VALUES ('Specter');
INSERT INTO subtypes (subtype) VALUES ('Spellshaper');
INSERT INTO subtypes (subtype) VALUES ('Sphinx');
INSERT INTO subtypes (subtype) VALUES ('Spider');
INSERT INTO subtypes (subtype) VALUES ('Spike');
INSERT INTO subtypes (subtype) VALUES ('Spirit');
INSERT INTO subtypes (subtype) VALUES ('Sponge');
INSERT INTO subtypes (subtype) VALUES ('Squid');
INSERT INTO subtypes (subtype) VALUES ('Squirrel');
INSERT INTO subtypes (subtype) VALUES ('Starfish');
INSERT INTO subtypes (subtype) VALUES ('Surrakar');
INSERT INTO subtypes (subtype) VALUES ('Swamp');
INSERT INTO subtypes (subtype) VALUES ('Tamiyo');
INSERT INTO subtypes (subtype) VALUES ('Tezzeret');
INSERT INTO subtypes (subtype) VALUES ('Thalakos');
INSERT INTO subtypes (subtype) VALUES ('Thopter');
INSERT INTO subtypes (subtype) VALUES ('Thrull');
INSERT INTO subtypes (subtype) VALUES ('Tibalt');
INSERT INTO subtypes (subtype) VALUES ('Tower');
INSERT INTO subtypes (subtype) VALUES ('Trap');
INSERT INTO subtypes (subtype) VALUES ('Treefolk');
INSERT INTO subtypes (subtype) VALUES ('Troll');
INSERT INTO subtypes (subtype) VALUES ('Turtle');
INSERT INTO subtypes (subtype) VALUES ('Ulgrotha');
INSERT INTO subtypes (subtype) VALUES ('Unicorn');
INSERT INTO subtypes (subtype) VALUES ('Urza''s');
INSERT INTO subtypes (subtype) VALUES ('Valla');
INSERT INTO subtypes (subtype) VALUES ('Vampire');
INSERT INTO subtypes (subtype) VALUES ('Vedalken');
INSERT INTO subtypes (subtype) VALUES ('Venser');
INSERT INTO subtypes (subtype) VALUES ('Viashino');
INSERT INTO subtypes (subtype) VALUES ('Volver');
INSERT INTO subtypes (subtype) VALUES ('Vraska');
INSERT INTO subtypes (subtype) VALUES ('Vryn');
INSERT INTO subtypes (subtype) VALUES ('Wall');
INSERT INTO subtypes (subtype) VALUES ('Warrior');
INSERT INTO subtypes (subtype) VALUES ('Weird');
INSERT INTO subtypes (subtype) VALUES ('Werewolf');
INSERT INTO subtypes (subtype) VALUES ('Whale');
INSERT INTO subtypes (subtype) VALUES ('Wildfire');
INSERT INTO subtypes (subtype) VALUES ('Wizard');
INSERT INTO subtypes (subtype) VALUES ('Wolf');
INSERT INTO subtypes (subtype) VALUES ('Wolverine');
INSERT INTO subtypes (subtype) VALUES ('Wombat');
INSERT INTO subtypes (subtype) VALUES ('Worm');
INSERT INTO subtypes (subtype) VALUES ('Wraith');
INSERT INTO subtypes (subtype) VALUES ('Wurm');
INSERT INTO subtypes (subtype) VALUES ('Xerex');
INSERT INTO subtypes (subtype) VALUES ('Yeti');
INSERT INTO subtypes (subtype) VALUES ('Zendikar');
INSERT INTO subtypes (subtype) VALUES ('Zombie');
INSERT INTO subtypes (subtype) VALUES ('Zubera');


CREATE TABLE cardtypes (
  basecard_id INT(11) NOT NULL,
  type_id INT(11) NOT NULL,
  position SMALLINT NOT NULL DEFAULT 0,
  PRIMARY KEY (basecard_id, type_id, position),
  FOREIGN KEY (basecard_id) 
        REFERENCES basecards(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
  FOREIGN KEY (type_id) 
        REFERENCES types(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
  ) ENGINE InnoDB  CHARACTER SET utf8;


CREATE TABLE cardsubtypes (
  basecard_id INT(11) NOT NULL,
  subtype_id INT(11) NOT NULL,
  position SMALLINT NOT NULL DEFAULT 0,
  PRIMARY KEY (basecard_id, subtype_id, position),
  FOREIGN KEY (basecard_id) 
        REFERENCES basecards(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
  FOREIGN KEY (subtype_id) 
        REFERENCES subtypes(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
  ) ENGINE InnoDB  CHARACTER SET utf8;



CREATE TABLE cardcolors (
  basecard_id INT(11) NOT NULL,
  color_id CHAR(1) NOT NULL,
  PRIMARY KEY (basecard_id, color_id),
  FOREIGN KEY (basecard_id) 
        REFERENCES basecards(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
  FOREIGN KEY (color_id) 
        REFERENCES colors(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
  ) ENGINE InnoDB  CHARACTER SET utf8;


INSERT INTO expansionsets (name) VALUES ('Alpha');

INSERT INTO basecards (name, rules_text, mana_cost, cmc, power, toughness, loyalty) VALUES ('Plains', '{w}', '', 0, NULL, NULL, NULL);
INSERT INTO basecards (name, rules_text, mana_cost, cmc, power, toughness, loyalty) VALUES ('Island', '{u}', '', 0, NULL, NULL, NULL);
INSERT INTO basecards (name, rules_text, mana_cost, cmc, power, toughness, loyalty) VALUES ('Swamp', '{b}', '', 0, NULL, NULL, NULL);
INSERT INTO basecards (name, rules_text, mana_cost, cmc, power, toughness, loyalty) VALUES ('Mountain', '{r}', '', 0, NULL, NULL, NULL);
INSERT INTO basecards (name, rules_text, mana_cost, cmc, power, toughness, loyalty) VALUES ('Forest', '{g}', '', 0, NULL, NULL, NULL);

INSERT INTO cards (expansionset_id, basecard_id, rarity, multiverseid, flavor_text) VALUES (1, 1, 'c', 292, NULL);
INSERT INTO cards (expansionset_id, basecard_id, rarity, multiverseid, flavor_text) VALUES (1, 2, 'c', 294, NULL);
INSERT INTO cards (expansionset_id, basecard_id, rarity, multiverseid, flavor_text) VALUES (1, 3, 'c', 278, NULL);
INSERT INTO cards (expansionset_id, basecard_id, rarity, multiverseid, flavor_text) VALUES (1, 4, 'c', 291, NULL);
INSERT INTO cards (expansionset_id, basecard_id, rarity, multiverseid, flavor_text) VALUES (1, 5, 'c', 289, NULL);

INSERT INTO cardtypes (basecard_id, type_id, position) VALUES (1, 2, 0);
INSERT INTO cardtypes (basecard_id, type_id, position) VALUES (1, 6, 1);
INSERT INTO cardsubtypes (basecard_id, subtype_id, position) VALUES (1, 192, 0);

INSERT INTO cardtypes (basecard_id, type_id, position) VALUES (2, 2, 0);
INSERT INTO cardtypes (basecard_id, type_id, position) VALUES (2, 6, 1);
INSERT INTO cardsubtypes (basecard_id, subtype_id, position) VALUES (2, 119, 0);

INSERT INTO cardtypes (basecard_id, type_id, position) VALUES (3, 2, 0);
INSERT INTO cardtypes (basecard_id, type_id, position) VALUES (3, 6, 1);
INSERT INTO cardsubtypes (basecard_id, subtype_id, position) VALUES (3, 245, 0);

INSERT INTO cardtypes (basecard_id, type_id, position) VALUES (4, 2, 0);
INSERT INTO cardtypes (basecard_id, type_id, position) VALUES (4, 6, 1);
INSERT INTO cardsubtypes (basecard_id, subtype_id, position) VALUES (4, 164, 0);

INSERT INTO cardtypes (basecard_id, type_id, position) VALUES (5, 2, 0);
INSERT INTO cardtypes (basecard_id, type_id, position) VALUES (5, 6, 1);
INSERT INTO cardsubtypes (basecard_id, subtype_id, position) VALUES (5, 82, 0);


INSERT INTO basecards (name, rules_text, mana_cost, cmc, power, toughness, loyalty) VALUES ('Lord of the Pit', 'Flying, trample
At the beginning of your upkeep, sacrifice a creature other than Lord of the Pit. If you can''t, Lord of the Pit deals 7 damage to you.', '{4}{b}{b}{b}', 7, 7, 7, NULL);
INSERT INTO cards (expansionset_id, basecard_id, rarity, multiverseid, flavor_text) VALUES (1, 6, 'r', 70, NULL);
INSERT INTO cardtypes (basecard_id, type_id, position) VALUES (6, 3, 0);
INSERT INTO cardsubtypes (basecard_id, subtype_id, position) VALUES (6, 51, 0);
INSERT INTO cardcolors (basecard_id, color_id) VALUES (6, 'B');


/*
INSERT INTO basecards (name, rules_text, mana_cost, cmc, power, toughness, loyalty) VALUES ('Draconian', 'Each other creature you control that''s a Dragonian or Dragon gets +1/+1.', '{1}{b}{r}', 3, 2, 2, NULL);
INSERT INTO cards (expansionset_id, basecard_id, rarity, multiverseid, flavor_text) VALUES (4, 7, 'u', 4000001, 'Guy likes mean dudes.');
INSERT INTO cardtypes (basecard_id, type_id, position) VALUES (7, 3, 0);
INSERT INTO subtypes (subtype) VALUES ('Draconian');
INSERT INTO cardsubtypes (basecard_id, subtype_id, position) VALUES (7, 286, 0);
INSERT INTO cardcolors (basecard_id, color_id) VALUES (7, 'B');
INSERT INTO cardcolors (basecard_id, color_id) VALUES (7, 'R');
*/

