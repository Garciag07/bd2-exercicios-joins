-- Active: 1775089473983@@127.0.0.1@3306@mysql
 SELECT 
    Cliente.Cliente_id, Cliente.Nome, Telefone.Numero



    USE ComicCenter;

SELECT 
    Cliente.Cliente_id, Cliente.Nome, Telefone.Numero
FROM
    Cliente
        INNER JOIN
    Telefone ON Cliente.Cliente_id = Telefone.Cliente_id;



USE ComicCenter;

SELECT 
    C.Cliente_id, C.Nome, T.Numero
FROM
    Cliente AS C
        INNER JOIN
    Telefone AS T ON C.Cliente_id = T.Cliente_id;



USE ComicCenter;

SELECT 
    C.Cliente_id, C.Nome, T.Numero, E.Cliente_email
FROM
    Cliente AS C
        INNER JOIN
    Telefone AS T ON C.Cliente_id = T.Cliente_id
        INNER JOIN
    Email AS E ON E.Cliente_id = C.Cliente_id;




--Exercícios--

DROP SCHEMA IF EXISTS final_space_db ;

CREATE SCHEMA IF NOT EXISTS final_space_db ;
USE final_space_db ;

CREATE TABLE IF NOT EXISTS final_space_db.Location (
    Location_id INT NOT NULL AUTO_INCREMENT,
    Location_Name VARCHAR(45) NOT NULL,
    Location_Type VARCHAR(45) NOT NULL,
    PRIMARY KEY (Location_id)
);

CREATE TABLE IF NOT EXISTS final_space_db.Specie (
    Specie_id INT NOT NULL AUTO_INCREMENT,
    Specie_Name VARCHAR(45) NOT NULL,
    PRIMARY KEY (Specie_id)
);

CREATE TABLE IF NOT EXISTS final_space_db.Character (
    Character_id INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(45) NOT NULL,
    Origin INT NULL,
    Specie INT NULL,
    PRIMARY KEY (Character_id),
    FOREIGN KEY (Origin)
        REFERENCES final_space_db.Location (Location_id),
    FOREIGN KEY (Specie)
        REFERENCES final_space_db.Specie (Specie_id)
);

INSERT INTO final_space_db.Location( 
  Location_id,
  Location_Name,
  Location_Type
  )
    VALUES
      (1, 'Earth', 'Planet'),
      (2, 'Final Space', 'Dimension'),
      (3, 'Tera Con Prime', 'Destroyed planet'),
      (4, 'Inner Space', 'Dimension'),
      (5, 'Yarno', 'Planet'),
      (6, 'Dark Zone', 'Black hole'),
      (7, 'Deathcropolis', 'Gladiatorial Colosseum'),
      (8, 'Lazarus Trap', 'Trap'),
      (9, 'The Order of the Twelve', 'Temple'),
      (10, 'Serepentis', 'Planet'),
      (11, 'Ventrexia', 'Planet'),
      (12, 'Invictus Prison', 'Dimension'),
      (13, 'Tryvuulian', 'Planet'),
      (14, 'Hatched', 'Planet');
    
INSERT INTO final_space_db.Specie(Specie_id, Specie_Name)
  VALUES
    (1, 'Human'),
    (2, 'Ventrexian'),
    (3, 'Robot'),
    (4, 'Serepentian'),
    (5, 'Tryvuulian'),
    (6, 'Artificial Intelligence'),
    (7, 'Titan'),
    (8, 'Cosmic Entity'),
    (9, 'Energy being'),
    (10, 'Alien'),
    (11, 'Hooblot'),
    (12, 'Cyborg'),
    (13, 'Fire Snake'),
    (14, 'Tiger Tiger');
    
INSERT INTO final_space_db.Character(
  Character_id,
  Name,
  Origin,
  Specie
)
  VALUES
    (1, 'Gary Goodspeed', 1, 1),
    (2, 'Mooncake', NULL, NULL),
    (3, 'Quinn Ergon', 1, 1),
    (4, 'Little Cato', 11, 2),
    (5, 'Avocato', 11, 2),
    (6, 'KVN', 1, 3),
    (7, 'Ash Graven', 10, 4),
    (8, 'Fox', 13, 5),
    (9, 'H.U.E', NULL, 6),
    (10, 'Tribore Menendez',14, NULL),
    (11, 'Clarence', NULL, NULL),
    (12, 'Biskit', NULL, 14),
    (13, 'Quatronostro Menendez', 14, NULL),
    (14, 'Lord Commander', NULL, NULL),
    (15, 'Sheryl Goodspeed', 1, 1),
    (16, 'Bolo', 2, 7),
    (17, 'Invictus', 2, 7),
    (18, 'John Goodspeed', 1, 1),
    (19, 'A.V.A', NULL, 6),
    (20, 'Evra', 2, 9),
    (21, 'Queen of Ventrexia', 11, 2),
    (22, 'King of Ventrexia', 11, 2),
    (23, 'Mega-KVN', 1, 3),
    (24, 'Melanie Dewinter',3, 11),
    (25, 'Harp Graven', 10, 4),
    (26, 'Shannon Thunder', 1, 1),
    (27, 'David Dewinter', 3, 11),
    (28, 'Meowlapeño', 3, 2),
    (29, 'Fraskenhaur', NULL, 10),
    (30, 'Oreskis"',2, 7 );



--Exercício 1--
USE final_space_db;
-- Executar query aqui
SELECT C.Name AS personagem, S.Specie_Name AS especie
FROM `Character` AS C
JOIN Specie AS S ON C.Specie = S.Specie_id;

--Exercício 2--
SELECT
  C.Name AS personagem,
  L.Location_Name AS origem
FROM
  `Character` AS C
LEFT JOIN
  Location AS L
ON
  C.Origin = L.Location_id;

--Exercício 3--
SELECT
  C.Name AS personagem,
  S.Specie_Name AS especie,
  L.Location_Name AS origem
FROM
  `Character` AS C
LEFT JOIN
  Specie AS S
ON
  C.Specie = S.Specie_id
LEFT JOIN
  Location AS L
ON
  C.Origin = L.Location_id;

--Exercício 4--
SELECT
  S.Specie_Name AS Especie,
  COUNT(C.Character_id) AS Quantidade
FROM
  Specie AS S
LEFT JOIN
  `Character` AS C
ON
  S.Specie_id = C.Specie
GROUP BY
  S.Specie_id, S.Specie_Name
ORDER BY
  Quantidade ASC;


SELECT
  L.Location_Name AS 'Local de Origem',
  COUNT(C.Character_id) AS Quantidade
FROM
  Location AS L
LEFT JOIN
  `Character` AS C
ON
  L.Location_id = C.Origin
GROUP BY
  L.`Location_id`
ORDER BY
  Quantidade DESC
  LIMIT 5;

--Exercício 5--
USE final_space_db;

SELECT 
    C.Name AS 'Character',
    COALESCE(S.Specie_Name, 'Unknown') AS 'Specie'
FROM 
    `Character` AS C
LEFT JOIN 
    `Specie` AS S ON C.Specie = S.Specie_id;

--Exercício 6--
USE final_space_db;

SELECT 
    COALESCE(C.Name, 'Unknown') AS 'Character',
    L.Location_Name AS 'Local'
FROM 
    `Character` AS C
RIGHT JOIN 
    Location AS L ON C.Origin = L.Location_id
ORDER BY 
    L.Location_Name;




DROP SCHEMA IF EXISTS ComicCenter ;

CREATE SCHEMA IF NOT EXISTS ComicCenter ;
USE ComicCenter ;

CREATE TABLE IF NOT EXISTS ComicCenter.Cliente (
  Cliente_id INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (Cliente_id)
);

CREATE TABLE IF NOT EXISTS ComicCenter.Telefone (
  Cliente_id INT NOT NULL,
  Numero VARCHAR(45) NOT NULL,
  PRIMARY KEY (Numero),
  FOREIGN KEY (Cliente_id) REFERENCES ComicCenter.Cliente (Cliente_id)
);

CREATE TABLE IF NOT EXISTS ComicCenter.Email (
  Cliente_id INT NOT NULL,
  Cliente_email VARCHAR(45) NOT NULL,
  PRIMARY KEY (Cliente_email),
  FOREIGN KEY (Cliente_id) REFERENCES ComicCenter.Cliente (Cliente_id)
);

CREATE TABLE IF NOT EXISTS ComicCenter.Revista (
  Revista_id INT NOT NULL,
  Titulo VARCHAR(45) NOT NULL,
  Editora VARCHAR(45) NOT NULL,
  PRIMARY KEY (Revista_id)
);

INSERT INTO ComicCenter.Revista (Revista_id, Titulo, Editora) 
  VALUES (1, 'Vingadores', 'Marvel'),
         (2, 'Liga da Justiça', 'DC Comics'),
         (3, 'Batman', 'DC Comics'),
         (4, 'X-Men', 'Marvel'),
         (5, 'Homem Aranha', 'Marvel'),
         (6, 'Mulher Maravilha', 'DC Comics');


USE ComicCenter;

SELECT 
    R1.Titulo, R1.Editora, R2.Titulo, R2.Editora
FROM
    Revista AS R1,
    Revista AS R2
WHERE
    R1.Editora = R2.Editora 
    AND R1.Revista_id < R2.Revista_id;

USE ComicCenter;

SELECT 
    R1.Titulo, R1.Editora, R2.Titulo, R2.Editora
FROM
    Revista AS R1,
    Revista AS R2
WHERE
    R1.Editora = R2.Editora
        AND R1.Titulo <> R2.Titulo;


--Exercício 1.2--
USE final_space_db;

SELECT 
    C1.Name AS Personagem1,
    C2.Name AS Personagem2,
    L.Location_Name AS Local_Origem
FROM 
    `Character` AS C1
JOIN 
    `Character` AS C2 ON C1.Origin = C2.Origin AND C1.Character_id < C2.Character_id
JOIN 
    Location AS L ON C1.Origin = L.Location_id
ORDER BY 
    L.Location_Name, C1.Name;

--Exercício 2.2--
USE final_space_db;

SELECT 
    C1.Name AS Personagem1,
    C2.Name AS Personagem2,
    L.Location_Name AS Local_Origem
FROM 
    `Character` AS C1
JOIN 
    `Character` AS C2 ON C1.Origin = C2.Origin 
                      AND C1.Character_id < C2.Character_id  -- Evita duplicatas e auto-comparação
JOIN 
    Location AS L ON C1.Origin = L.Location_id
ORDER BY 
    L.Location_Name, C1.Name;

--Exercício 3.2--
