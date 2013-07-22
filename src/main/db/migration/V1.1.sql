ALTER TABLE cards ADD COLUMN card_number INT AFTER flavor_text;
ALTER TABLE cards ADD CONSTRAINT UNIQUE KEY (expansionset_id, card_number);
