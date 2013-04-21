CREATE TABLE cards (
  id int(11) NOT NULL auto_increment PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  rules_text VARCHAR(1000),
  created_at DATETIME,
  updated_at DATETIME
  ) ENGINE InnoDB  CHARACTER SET utf8;
