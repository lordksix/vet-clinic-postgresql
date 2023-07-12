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