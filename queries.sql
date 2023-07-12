/* Part 1 */

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered IS true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered IS true;
SELECT * FROM animals WHERE NOT name='Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Part 2 */

/* Query 1 */
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* Query 2 */
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species is null;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

/* Query 3 */
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* Query 4 */
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;
SAVEPOINT young;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO SAVEPOINT young;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

/* Question 1 */
SELECT COUNT(*) as total_animlas FROM animals;
/* Question 2 */
SELECT * FROM animals WHERE escape_attempts = 0;
/* Question 3 */
SELECT ROUND(AVG(weight_kg), 2) as average_weight_kg FROM animals;
/* Question 4 */
SELECT neutered, ROUND(AVG(escape_attempts), 2) as average_escape_attempts FROM animals GROUP BY neutered ORDER BY average_escape_attempts DESC;
/* Question 5 */
SELECT species, ROUND(MIN(weight_kg), 2) AS min_weight_kg, ROUND(MAX(weight_kg), 2) AS max_weight_kg FROM animals GROUP BY species;
/* Question 6 */
SELECT species, ROUND(AVG(escape_attempts), 2) AS mavg_escape_attempts FROM animals WHERE date_of_birth > '1990-01-01' and date_of_birth < '2000-01-01' GROUP BY species;