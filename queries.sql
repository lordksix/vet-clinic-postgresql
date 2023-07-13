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

/* Part 3 */

/* Question 1 */
SELECT name, full_name FROM animals JOIN owners on owners.id = animals.owner_id WHERE full_name = 'Melody Pond';
/* Question 2 */
SELECT animals.name, species.name FROM animals JOIN species on species.id = animals.species_id WHERE species.name = 'Pokemon';
/* Question 3 */
SELECT name, full_name FROM animals FULL JOIN owners on owners.id = animals.owner_id;
/* Question 4 */
SELECT species.name, COUNT(*) as total FROM animals JOIN species on species.id = animals.species_id GROUP BY species.name;
/* Question 5 */
SELECT animals.name, full_name, species.name FROM animals JOIN owners on owners.id = animals.owner_id JOIN species on species.id= animals.species_id WHERE full_name = 'Jennifer Orwell' and species.name = 'Digimon';
/* Question 6 */
SELECT name, full_name, escape_attempts FROM animals JOIN owners on owners.id = animals.owner_id WHERE full_name = 'Dean Winchester' and escape_attempts = 0;
/* Question 7 */
SELECT full_name, COUNT(*) as total  FROM animals JOIN owners on owners.id= animals.owner_id GROUP BY full_name ORDER BY total DESC LIMIT 1;

/* Part 4 */

/* Question 1 */
SELECT vets.name, date_of_visit, animals.name FROM visits JOIN animals on animals.id = visits.animals_id JOIN vets on vets.id = visits.vets_id WHERE vets.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;
/* Question 2 */
SELECT vets.name, species.name, COUNT(species.name) as total_animals FROM visits JOIN animals on animals.id = visits.animals_id JOIN species on species.id = animals.species_id  JOIN vets on vets.id = visits.vets_id WHERE vets.name = 'Stephanie Mendez' GROUP BY species.name, vets.name;
/* Question 3 */
SELECT vets.name, species.name as specialization FROM specializations FULL JOIN vets on vets.id = specializations.vets_id FULL JOIN species ON species.id = specializations.species_id;
/* Question 4 */
SELECT vets.name, date_of_visit, animals.name FROM visits JOIN animals on animals.id = visits.animals_id JOIN vets on vets.id = visits.vets_id WHERE vets.name = 'Stephanie Mendez' AND (date_of_visit > '2020-04-01' and date_of_visit < '2020-09-01') ORDER BY date_of_visit;
/* Question 5 */
SELECT animals.name, COUNT(date_of_visit) as total_visits FROM visits JOIN animals on animals.id = visits.animals_id GROUP BY animals.name ORDER BY total_visits DESC LIMIT 1;
/* Question 6 */
SELECT vets.name, date_of_visit, animals.name FROM visits JOIN animals on animals.id = visits.animals_id JOIN vets on vets.id = visits.vets_id WHERE vets.name = 'Maisy Smith' ORDER BY date_of_visit LIMIT 1;
/* Question 7 */
SELECT animals.name, date_of_birth, escape_attempts, neutered, weight_kg, date_of_visit, vets.name as vets_name, vets.age as vets_age, date_of_graduation FROM visits JOIN animals on animals.id = visits.animals_id JOIN vets on vets.id = visits.vets_id ORDER BY date_of_visit DESC LIMIT 1;
/* Question 8 */
SELECT vets.name, COUNT(date_of_visit) as total_visits FROM vets FULL JOIN specializations on vets.id = specializations.vets_id JOIN visits on vets.id = visits.vets_id FULL JOIN species on species.id = specializations.species_id WHERE species.name is NULL GROUP BY vets.name;
/* Question 9 */
/* ORIGINAL CORRECT */
/* SELECT vets.name, species.name, COUNT(species.name) as total_visits_type_animal FROM vets FULL JOIN specializations on vets.id = specializations.vets_id JOIN visits on vets.id = visits.vets_id JOIN animals on animals.id = visits.animals_id JOIN species on species.id = animals.species_id WHERE vets.name = 'Maisy Smith' GROUP BY vets.name, species.name ORDER BY total_visits_type_animal DESC LIMIT 1; */
/* ANOTHER WAY AS SUGGESTED BY CR */
SELECT vets.name, species.name AS species, COUNT(vets.id) AS num_visits FROM visits JOIN animals ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id JOIN species on species.id = animals.species_id WHERE vets.name = 'Maisy Smith' GROUP BY species.name, vets.name ORDER BY num_visits DESC LIMIT 1;