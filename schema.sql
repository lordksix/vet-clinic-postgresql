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
C:\Users\Wlad\Documents\GitHub\vet-clinic-postgresql\schema.sql
