/* Part 1 */

CREATE TABLE animals (
	id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(150),
	date_of_birth DATE,
	escape_attempts INTEGER,
	neutered BOOLEAN,
	weight_kg DECIMAL
);

/* Part 2 */

ALTER TABLE animals ADD COLUMN species VARCHAR (50);

/* Part 3 */

CREATE TABLE owners (
	id SERIAL PRIMARY KEY NOT NULL,
	full_name VARCHAR(150),
	age INTEGER
);

CREATE TABLE species (
	id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(150)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals  ADD COLUMN species_id INTEGER;
ALTER TABLE animals  ADD COLUMN owner_id INTEGER;
ALTER TABLE animals ADD CONSTRAINT fr_animals_species FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE SET NULL;
ALTER TABLE animals ADD CONSTRAINT fr_animals_owners FOREIGN KEY (owner_id) REFERENCES owners (id) ON DELETE SET NULL;

/* Part 4 */

CREATE TABLE vets (
	id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(150),
	age INTEGER,
  date_of_graduation DATE
);

CREATE TABLE specializations  (
  vets_id INT NOT NULL,
  species_id INT NOT NULL,
  PRIMARY KEY (vets_id, species_id),
  FOREIGN KEY (vets_id) REFERENCES vets(id) ON UPDATE CASCADE,
  FOREIGN KEY (species_id) REFERENCES species(id) ON UPDATE CASCADE
);

CREATE TABLE visits  (
  vets_id INT NOT NULL,
  animals_id INT NOT NULL,
  date_of_visit DATE NOT NULL,
  PRIMARY KEY (vets_id, animals_id, date_of_visit),
  FOREIGN KEY (vets_id) REFERENCES vets(id) ON UPDATE CASCADE,
  FOREIGN KEY (animals_id) REFERENCES animals(id) ON UPDATE CASCADE
);