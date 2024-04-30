CREATE DATABASE minipokedex;

USE minipokedex;

CREATE TABLE pokemon (
                         `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                         `name` VARCHAR(14) NOT NULL,
                         `type` VARCHAR(14) NOT NULL,
                         PRIMARY KEY (`id`)
);

USE minipokedex;

INSERT INTO pokemon (`name`, `type`) VALUES
                                         ('bulbasaur', 'planta'),
                                         ('charmander', 'fuego'),
                                         ('squirtle', 'agua');
