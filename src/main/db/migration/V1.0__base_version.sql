CREATE TABLE basecards (
  id INT(11) NOT NULL auto_increment PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  rules_text VARCHAR(1000),
  mana_cost VARCHAR(60),
  power SMALLINT,
  toughness SMALLINT,
  loyalty SMALLINT,
  created_at DATETIME,
  updated_at DATETIME
  ) ENGINE InnoDB  CHARACTER SET utf8;

CREATE TABLE cards (
  expansionset_id INT,
  basecard_id INT,
  rarity INT,
  multiverseid INT,
  flavor_text VARCHAR(1000),
  PRIMARY KEY (expansionset_id, basecard_id)
  ) ENGINE InnoDB  CHARACTER SET utf8;

CREATE TABLE types (
  id INT(11) NOT NULL auto_increment PRIMARY KEY,
  type VARCHAR(128) NOT NULL
  ) ENGINE InnoDB  CHARACTER SET utf8;

CREATE TABLE subtypes (
  id INT(11) NOT NULL auto_increment PRIMARY KEY,
  subtype VARCHAR(128) NOT NULL
  ) ENGINE InnoDB  CHARACTER SET utf8;

CREATE TABLE cardtypes (
  basecard_id INT(11) NOT NULL,
  type_id INT(11) NOT NULL
  PRIMARY KEY (basecard_id, type_id)
  ) ENGINE InnoDB  CHARACTER SET utf8;

CREATE TABLE cardsubtypes (
  basecard_id INT(11) NOT NULL,
  subtype_id INT(11) NOT NULL,
  PRIMARY KEY (basecard_id, subtype_id)
  ) ENGINE InnoDB  CHARACTER SET utf8;

CREATE TABLE expansionsets (
  id INT(11) NOT NULL auto_increment PRIMARY KEY,
  name VARCHAR(128) NOT NULL
  ) ENGINE InnoDB  CHARACTER SET utf8;

CREATE TABLE colors (
  id CHAR(1) NOT NULL PRIMARY KEY,
  color VARCHAR(12) NOT NULL,
  ) ENGINE InnoDB  CHARACTER SET utf8;

INSERT INTO colors (color, id) VALUES ('White','W');
INSERT INTO colors (color, id) VALUES ('Blue','U');
INSERT INTO colors (color, id) VALUES ('Black','B');
INSERT INTO colors (color, id) VALUES ('Red','R');
INSERT INTO colors (color, id) VALUES ('Green','G');
INSERT INTO colors (color, id) VALUES ('Colorless','c');

CREATE TABLE cardcolors (
  basecard_id INT(11) NOT NULL,
  color_id CHAR(1) NOT NULL,
  PRIMARY KEY (basecard_id, color_id)
  ) ENGINE InnoDB  CHARACTER SET utf8;
