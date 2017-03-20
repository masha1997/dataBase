/*DROP TABLE roomPriceChronology CASCADE;
DROP DOMAIN Phone CASCADE;
DROP TYPE Passport CASCADE;
DROP DOMAIN Class_ CASCADE;
DROP TYPE Species CASCADE;
DROP TABLE price CASCADE;
DROP TABLE priceChronology CASCADE ;
DROP TABLE owner CASCADE;
DROP TABLE pet CASCADE;
DROP TABLE service CASCADE;
DROP TABLE room CASCADE;
DROP TABLE pet_room_service CASCADE;
*//*
CREATE DOMAIN Phone AS VARCHAR
CHECK (VALUE ~'\+380+[0-9]{7}');

CREATE TYPE Passport AS (seria char(2),number_ char(6));

CREATE DOMAIN Class_ AS VARCHAR
CHECK ( VALUE IN ('econom','usual','vip'));

CREATE TYPE Species AS ENUM('cat','dog','dog_hard','parrot','parrot_hard');
--справочники
CREATE TABLE roomPriceChronology(
	price_date DATE PRIMARY KEY NOT NULL,
	vip_price int DEFAULT 10,
	usual_price int DEFAULT 4,
	econom_price int DEFAULT 2);
	
INSERT INTO  roomPriceChronology VALUES 
				    ('2000-01-01', 15, 4, 2),
				    ('2010-01-01',12, 5, 3);

CREATE TABLE priceChronology(
	price_date DATE PRIMARY KEY NOT NULL,
	cat_price int DEFAULT 4,
	dog_price int DEFAULT 6,
	dog_hard_price int DEFAULT 8,
	parrot_price int DEFAULT 1,
	parrot_hard_price int DEFAULT 2);


INSERT INTO  priceChronology VALUES ('1963-08-01',4, 5, 9, 1, 3),
				    ('2000-01-01', 8, 9, 15, 1, 2);

CREATE TABLE owner
(
  id_owner Passport CHECK ((id_owner).seria SIMILAR TO '[A-Z]{2}' AND (id_owner).number_ SIMILAR TO '[0-9]{6}') NOT NULL ,
  first_name character varying(20) NOT NULL,
  second_name character varying(20) NOT NULL,
  contact Phone NOT NULL,
  email character varying(50),
  PRIMARY KEY (id_owner)
);

CREATE TABLE pet
(
  id_pet serial NOT NULL ,
  name character varying(50) NOT NULL,
  owner passport NOT NULL,
  species species NOT NULL,
  PRIMARY KEY(id_pet),
  FOREIGN KEY (owner) REFERENCES owner(id_owner)ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE room
(
  id_room serial NOT NULL,
  state boolean NOT NULL,
  class_ class_ NOT NULL,
  type species NOT NULL,
  PRIMARY KEY(id_room)
);

CREATE TABLE service
( id_service Passport CHECK((id_service).seria SIMILAR TO '[A-Z]{2}' AND (id_service).number_ SIMILAR TO '[0-9]{6}') NOT NULL ,
  first_name character varying(20) NOT NULL,
  second_name character varying(20) NOT NULL,
  contact Phone NOT NULL,
  specialization Species[5],
  email character varying(50),
  PRIMARY KEY(id_service)
);

CREATE TABLE pet_room_service
( arrivalDate DATE NOT NULL,
  departDate DATE NOT NULL,
  pet serial NOT NULL,
  room serial NOT NULL,
  service Passport NOT NULL,
  penalty int DEFAULT 0,
  FOREIGN KEY (pet) REFERENCES pet(id_pet) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (room) REFERENCES room(id_room)ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (service) REFERENCES service(id_service)ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (ArrivalDate, pet)
);



INSERT INTO owner VALUES(('KM', '908765'), 'Nikolay', 'Ivanov', '+380634507894'),
			(('FK', '789265'), 'Elena', 'Vasilieva', '+380503993598'),
			(('LK', '589027'), 'Evgeniy', 'Kuznetsov', '+380754509094'),
			(('GH', '890273'), 'Svetlana', 'Tereeva', '+380686548945'),
			(('KM', '890732'), 'Nikolay', 'Verbitskiy','+380707894560'),
			(('KM', '765902'), 'Anatoliy', 'Zadorogniy', '+380904507894'),
			(('FK', '893765'), 'Semen', 'Kartashov', '+380689807874');
INSERT INTO owner VALUES		
			(('KM', '780654'), 'Irina', 'Litvinova', '+3807696045', 'irishka3548@onu.edu'),
			(('KM', '560894'), 'Semen', 'Litvinov', '+380756789045', 'semen9999@gmail.com');

INSERT INTO pet (name, owner, species) VALUES
			('Sonia', ('KM', '908765'), 'cat'),
			('Sharik', ('KM', '908765'), 'dog'),

			('Iliya', ('FK', '789265'), 'parrot'),
			('Jora', ('FK', '789265'), 'dog_hard'),

			('Kostia', ('LK', '589027'), 'parrot_hard'),

			('Jora', ('GH', '890273'), 'dog_hard'),
			('Petia', ('GH', '890273'), 'cat'),
			('Nikolay', ('GH', '890273'), 'parrot'),
		
			('Rujuc', ('KM', '890732'), 'cat'),

			('Timosha', ('KM', '765902'), 'cat'),

			('Semen2', ('FK', '893765'), 'parrot');



INSERT INTO room (state, class_, type) 
		 VALUES (true, 'econom', 'cat'),
			(true, 'econom', 'cat'),
			(true, 'vip', 'cat'),
			(true, 'usual', 'dog'),
			(true, 'usual', 'parrot'),
			(true, 'vip', 'parrot_hard'),
			(true, 'econom', 'dog_hard');

INSERT INTO service 
		  VALUES(('KM', '345165'), 'Milan', 'Kravchuk', '+380689307894','{cat, dog, parrot}'),
			(('HF', '875903'), 'Irina', 'Kireeva', '+380503333598','{cat, dog, parrot, parrot_hard }'),
			(('LU', '552027'), 'Evgeniy', 'Garelin', '+380934459094','{cat, dog, parrot, parrot_hard}'),
			(('GH', '893873'), 'Alisa', 'Zubrova', '+380686783895', '{cat, dog, parrot, parrot_hard}'),
			(('KM', '894902'), 'German', 'Hodunai','+380507894060','{cat, dog, dog_hard, parrot, parrot_hard}'),
			(('KM', '765566'), 'Anatoliy', 'Doljenkov', '+380956707894','{cat, dog, parrot, parrot_hard}'),
			(('FK', '890345'), 'Kiril', 'Dolgoprudniy', '+380689807874','{cat, dog,  dog_hard}');
INSERT INTO service 
		  VALUES			
			(('KM', '768543'), 'Lina', 'Avdeeva', '+380786598043','{cat, dog, parrot}','lina.90@onu.edu'),
			(('FP', '456094'), 'Kiril', 'Malis', '+380508734569','{cat, dog, dog_hard, parrot}','kirilMMM@onu.edu'),
			(('FJ', '234094'), 'Filipp', 'Marchenko', '+380508784569','{cat, dog, dog_hard, parrot}','filiya111@mail.ru');

INSERT INTO pet_room_service
		  VALUES(to_date('1963-09-01', 'YYYY-MM-DD'), to_date('1967-09-01', 'YYYY-MM-DD'),1,2,('HF', '875903')),
			(to_date('2000-09-01', 'YYYY-MM-DD'), to_date('2001-09-01', 'YYYY-MM-DD'),3,5,('LU', '552027')),
			(to_date('2012-09-01', 'YYYY-MM-DD'), to_date('2013-09-01', 'YYYY-MM-DD'),3,5,('LU', '552027')),
			(to_date('2001-09-01', 'YYYY-MM-DD'), to_date('2002-09-01', 'YYYY-MM-DD'),1,1,('LU', '552027')),
			(to_date('2000-09-01', 'YYYY-MM-DD'), to_date('2001-09-01', 'YYYY-MM-DD'),2,4,('FK', '890345')),
			(to_date('2002-09-01', 'YYYY-MM-DD'), to_date('2003-09-01', 'YYYY-MM-DD'),4,7,('KM', '894902')),
			(to_date('2012-07-11', 'YYYY-MM-DD'), to_date('2013-10-22', 'YYYY-MM-DD'),1,1,('KM', '765566')),
			(to_date('2012-10-11', 'YYYY-MM-DD'), to_date('2013-10-22', 'YYYY-MM-DD'),7,1,('GH', '893873')),
			(to_date('2012-10-11', 'YYYY-MM-DD'), to_date('2013-10-22', 'YYYY-MM-DD'),11,5,('KM', '345165')),
			(to_date('1963-09-01', 'YYYY-MM-DD'), to_date('1967-09-01', 'YYYY-MM-DD'),3, 5, ('HF', '875903'));

*//*

-- 3 Лабораторная
--1 Получить список сотрудников и владельцев, e-mail которых содержит домен onu.edu.

SELECT first_name, second_name, email FROM owner
WHERE email LIKE '%onu.edu'
     UNION
SELECT first_name, second_name, email FROM service
WHERE email LIKE '%onu.edu';


--2 Получить перечень видов животных, ранжированных по количеству питомцев в отеле.

SELECT species,COUNT (species) as species_
FROM pet_room_service, pet
WHERE pet_room_service.pet = pet.id_pet 
GROUP BY species
ORDER BY species_ DESC; 


--3 Увеличить стоимость содержания собак на 15%. При необходимости внести изменения в структуру БД.
CREATE VIEW last_price AS
SELECT CAST ('2016-10-01' AS DATE) AS date_price, cat_price, CAST(dog_price*1.15 AS INT) AS dog_price, CAST(dog_hard_price*1.15 AS INT) AS dog_hard_price, parrot_price, parrot_hard_price FROM priceChronology
ORDER BY price_date DESC
LIMIT 1;

INSERT INTO  priceChronology (price_date, cat_price, dog_price, dog_hard_price, parrot_price, parrot_hard_price)
SELECT date_price,cat_price, dog_price, dog_hard_price, parrot_price, parrot_hard_price FROM last_price;

SELECT * FROM priceChronology;


--4 Получить список владельцев, ранжированных по убыванию количества питомцев, находящихся в отеле.
SELECT first_name,second_name, COUNT (pet) as pets_
FROM pet_room_service, pet, owner
WHERE pet_room_service.pet = pet.id_pet AND pet.owner = owner.id_owner
GROUP BY first_name, second_name
ORDER BY pets_; 


--5 Получить список питомцев, ранжированных по частоте пребывания в отеле.
SELECT id_pet, name, species, COUNT(pet) as pets_
FROM pet_room_service, pet
WHERE pet = id_pet
GROUP BY id_pet
ORDER BY pets_ DESC;

--6 Уволить конкретного сотрудника (на усмотрение студента).
--животные у сотрудника HF 875903
SELECT id_pet, name, species 
FROM pet_room_service, service, pet
WHERE id_service = service AND (service).seria = 'HF' AND (service).number_ = '875903' AND pet = id_pet ;

--найти сотрудника который может забрать
SELECT specialization, first_name, second_name, id_service
FROM service
WHERE specialization[1] = 'cat' AND specialization[4] = 'parrot';

--переопределить животных
UPDATE pet_room_service 
SET service = ('FJ','234094')
WHERE (service).seria = 'HF' AND (service).number_ = '875903';

--проверить весят ли еще животные на плохом сотруднике
SELECT id_pet, name, species 
FROM pet_room_service, service, pet
WHERE id_service = service AND (service).seria = 'HF' AND (service).number_ = '875903' AND pet = id_pet ;

--удалить сотрудника
DELETE FROM service 
WHERE (id_service).seria = 'HF' AND (id_service).number_ = '875903';

--проверить есть ли он в базе
SELECT * FROM service;



--7 Определить список помещений требуемого типа (размера), свободных в требуемый период. Тип помещениея и период на усмотрение студента.
CREATE VIEW busy_room AS
SELECT * FROM pet_room_service
WHERE '2012-07-11' BETWEEN arrivalDate AND departDate ;

SELECT type, id_room FROM room, busy_room
WHERE id_room <> room AND type = 'cat';

--8 Подсчитать стоимость на содержания конкретного питомца (на усмотрение студента).

CREATE VIEW room_price AS 
SELECT price_date, usual_price FROM roomPriceChronology
WHERE price_date <= '2012-10-11' 
ORDER BY price_date DESC 
LIMIT 1;

CREATE VIEW animal_price AS 
SELECT price_date, parrot_price FROM priceChronology
WHERE price_date <= '2012-10-11' 
ORDER BY price_date DESC 
LIMIT 1;

SELECT species, name, room, class_ , (departDate-arrivalDate)*(usual_price + parrot_price) FROM pet_room_service, pet, room, room_price, animal_price
WHERE arrivalDate ='2012-10-11' AND pet = 11 AND pet = id_pet AND room = id_room ;

--9 Определить список видов животных, которыми заняты все предназначенные для них помещения.
--все занятые комнаты
CREATE VIEW busy AS
SELECT  DISTINCT id_room, type
FROM pet_room_service,room
WHERE room=id_room
ORDER BY type;

CREATE VIEW busy1 AS
SELECT type, COUNT (type) AS type_
FROM busy
GROUP BY type
INTERSECT
SELECT type, COUNT (type) AS type
FROM room
GROUP BY type;

SELECT type
FROM busy1;

--10 Получить список комнат, которыми не воспользовались ни разу.
CREATE VIEW never_used AS
SELECT id_room, type
FROM room
EXCEPT
SELECT DISTINCT id_room, type
FROM pet_room_service,room
WHERE room=id_room
ORDER BY id_room;

SELECT * FROM never_used;

*/
--Лабораторная 4
--1.Для каждого клиента определить его рейтинг (место) в списках ранжирования по:
-- частоте использования отеля; – средней сумме расходов на питомца; – количеству видов питомцев.

--DROP FUNCTION getPetPrice(arrival_date DATE, pet species);

/*CREATE OR REPLACE FUNCTION getPetPrice(arrival_date DATE, pet species)
	RETURNS TABLE (price INT)
	AS $$
	DECLARE 
		animal_price VARCHAR;
	BEGIN
		IF pet = 'cat' THEN
			animal_price:='cat_price';
		ELSIF pet = 'dog' THEN
			animal_price:='dog_price';
		ELSIF pet = 'dog_hard' THEN
			animal_price:='dog_hard_price';
		ELSIF pet = 'parrot' THEN
			animal_price:='parrot_price';
		ELSIF pet = 'parrot_hard' THEN
			animal_price:='parrot_hard_price';
		END IF;
		RETURN QUERY EXECUTE format('SELECT %I FROM priceChronology
			WHERE price_date <= $1 
			ORDER BY price_date DESC 
			LIMIT 1', animal_price)
			USING arrival_date;
	END; 
	$$ LANGUAGE plpgSQL;

CREATE OR REPLACE FUNCTION getRoomPrice(arrival_date DATE, room_class class_)
	RETURNS TABLE (price INT)
	AS $$
	DECLARE 
		room_price VARCHAR;
	BEGIN
		IF room_class = 'econom' THEN
			room_price:='econom_price';
		ELSIF room_class = 'usual' THEN
			room_price:='usual_price';
		ELSIF room_class = 'vip' THEN
			room_price:='vip_price';
		END IF;
		RETURN QUERY EXECUTE format('SELECT %I FROM roomPriceChronology
			WHERE price_date <= $1 
			ORDER BY price_date DESC 
			LIMIT 1', room_price)
			USING arrival_date;
	END; 
	$$ LANGUAGE plpgSQL;


WITH avg_price AS 
(
	SELECT id_owner, first_name, second_name, AVG((departDate - arrivalDate) * price)::int AS "AVG"
	FROM pet_room_service, room, pet, owner, getRoomPrice(arrivalDate, class_)
	WHERE pet = id_pet AND room = id_room AND owner = id_owner
	GROUP BY id_owner, first_name, second_name
)
SELECT  id_owner, first_name, second_name, "AVG", "CountNumbersOfPet", "CountNumbersSpeiesOfPet", "CountNumbersOfPetRank", "CountNumbersSpeiesOfPetRank", DENSE_RANK() OVER (ORDER BY "AVG" DESC) "AvgRank" FROM avg_price 
avg_price1
JOIN
(
	WITH pet_amount AS
	(
		SELECT first_name, second_name, id_owner, COUNT(pet)as "CountNumbersOfPet"
		FROM pet_room_service, pet, owner
		WHERE pet = id_pet AND owner=id_owner
		GROUP BY first_name, second_name, id_owner
	)
	SELECT id_owner, "CountNumbersOfPet", DENSE_RANK() OVER (ORDER BY "CountNumbersOfPet" DESC) "CountNumbersOfPetRank" FROM pet_amount
 ) pet_amount1 USING (id_owner)
JOIN
(
	WITH species_amount AS
	(
		SELECT first_name, second_name, id_owner, COUNT (DISTINCT species) AS "CountNumbersSpeiesOfPet"
		FROM pet_room_service, pet, owner
		WHERE pet = id_pet AND owner=id_owner 
		GROUP BY first_name, second_name, id_owner
	)
	SELECT id_owner, "CountNumbersSpeiesOfPet", DENSE_RANK() OVER (ORDER BY "CountNumbersSpeiesOfPet" DESC) "CountNumbersSpeiesOfPetRank" FROM species_amount
) species_amount1 USING (id_owner)

		  
--2. Создать представление для отображения информации о доходе, приносимом каждым видом содержащихся питомцев у каждого из сотрудников.
CREATE OR REPLACE VIEW cashTakeBySpecies AS
SELECT id_service,species,COUNT(species)as "speciesAmount",SUM((departDate-arrivalDate)*(getRoomPrice.price+GetPetPrice.price))as "cashTake"
FROM pet_room_service, pet, service, room, getRoomPrice(arrivalDate, class_), getPetPrice(arrivalDate, species)
WHERE id_service = service AND id_pet = pet AND room = id_room
GROUP BY id_service,species,id_pet 
ORDER BY "cashTake" DESC;
SELECT * FROM cashTakeBySpecies;

--3. Получить список сотрудников, «принесших» максимальный доход отелю.
WITH cashTakeByService AS
(
	SELECT id_service, SUM ("cashTake") as sum
	FROM cashTakeBySpecies
	GROUP BY id_service 
)
SELECT id_service, sum from cashTakeByService
WHERE sum=(
SELECT MAX(sum) AS maxSum FROM cashTakeByService);

--л/р № 5 (триггеры и хранимые процедуры)
--1. Составить триггеры для блокирования процессов: – закрепления за животным сотрудника, не подходящего по профилю; 
*/
DROP TRIGGER IF EXISTS speciesCheck;
CREATE OR REPLACE FUNCTION speciesCheckF() RETURNS TRIGGER 
AS $$
DECLARE
	cur_animal_species pet.species%TYPE;
	countof int;	
BEGIN
	SELECT species
	INTO cur_animal_species 
	FROM pet
	WHERE NEW.pet=id_pet;
	SELECT COUNT(*) into countof FROM service
	WHERE cur_animal_species = any (specialization) and NEW.service=id_service;
	IF(countof = 0)
		THEN RAISE EXCEPTION
			'Данный сотрудник не может ухаживать за %', cur_animal_species;
	END IF;
	RETURN NEW;
END;
$$LANGUAGE plpgSQL;
CREATE  TRIGGER speciesCheck BEFORE INSERT OR UPDATE ON pet_room_service
 FOR EACH ROW EXECUTE PROCEDURE speciesCheckF();
--Пример работы 
INSERT INTO pet_room_service
	VALUES(to_date('1963-09-01', 'YYYY-MM-DD'), to_date('1967-09-01', 'YYYY-MM-DD'),4,7,('KM', '345165'));
INSERT INTO pet_room_service
	VALUES(to_date('2005-09-01', 'YYYY-MM-DD'), to_date('2006-09-01', 'YYYY-MM-DD'),1,1,('KM', '345165'));
	
--–1.2 «поселения» животного в неподходящее помещение.
CREATE OR REPLACE FUNCTION roomCheckF() RETURNS TRIGGER 
AS $$
DECLARE
	cur_animal_species species;
	cur_room_type species;
BEGIN
	SELECT species
	INTO cur_animal_species 
	FROM pet
	WHERE NEW.pet=id_pet;
	SELECT type
	INTO cur_room_type 
	FROM room
	WHERE NEW.room=id_room;
	
	IF(cur_room_type<>cur_animal_species)
		THEN RAISE EXCEPTION
			'Невозможно поселить % в комнату, предназначеную для %', cur_animal_species, cur_room_type;
	END IF;
	RETURN NEW;
END;
$$LANGUAGE plpgSQL;
CREATE  TRIGGER roomCheck BEFORE INSERT OR UPDATE ON pet_room_service
 FOR EACH ROW EXECUTE PROCEDURE roomCheckF();
 --Пример работы
 INSERT INTO pet_room_service
	VALUES(to_date('2002-09-01', 'YYYY-MM-DD'), to_date('2005-09-01', 'YYYY-MM-DD'),1,4,('FJ','234094'));
 INSERT INTO pet_room_service
	VALUES(to_date('2005-09-01', 'YYYY-MM-DD'), to_date('2006-09-01', 'YYYY-MM-DD'),1,3,('FJ','234094'));
--2. Составить хранимую процедуру для реализации факта поселения питомца с автоматическим подбором помещения (данные о питомце, владельце и сотруднике передавать как параметры).
CREATE OR REPLACE FUNCTION setPetRoom(arrival_date DATE, depart_date DATE, pet_id INT, service_id Passport)
	RETURNS INTEGER
	AS $$
	DECLARE 
		room  INTEGER   ;
	BEGIN
		SELECT id_room
		INTO room 
		FROM room, pet,pet_room_service
		WHERE id_pet=pet_id AND type=species AND (arrivalDate>depart_date OR departDate<arrival_date) 
		ORDER BY class_ DESC 
		LIMIT 1;

		IF (room is NULL)
			THEN RAISE EXCEPTION
			'Нет подходящей комнаты';
		ELSE
		INSERT INTO pet_room_service VALUES (arrival_date, depart_date, pet_id, room, service_id);
		END IF;
		RETURN 1;
	END; 
	$$ LANGUAGE plpgSQL;


	
--Пример работы
SELECT setPetRoom(to_date('1900-09-01', 'YYYY-MM-DD'), to_date('2222-09-01', 'YYYY-MM-DD'),1,('FJ','234094'));
SELECT setPetRoom(to_date('2010-09-01', 'YYYY-MM-DD'), to_date('2011-09-01', 'YYYY-MM-DD'),1,('FJ','234094'));
/*SELECT id_room
FROM room, pet, pet_room_service
WHERE id_pet='1' AND type=species AND (departDate<'2010-09-01' or arrivalDate>'2011-09-01')
ORDER BY departDate DESC
LIMIT 1;*/
--3.Составить хранимую процедуру для реализации факта увольнения сотрудника с автоматической передачей его «подопечных» наиболее подходящему 
--(по профилю и наименьшей загруженности). ФИО увольняемого передавать как параметры.

--функция равномерно распределяет все опр вид животных по сотрудникам, у которых есть данная специализация
--начиная от самых незагруженных по виду

CREATE OR REPLACE FUNCTION SpeciesTrans(fired Passport)
RETURNS INTEGER
	AS $$
	DECLARE 
	BEGIN     
    	WHILE (SELECT COUNT(*) FROM pet_room_service WHERE service = fired) > 0 LOOP
    	
            UPDATE pet_room_service SET service = subquery.service FROM 
            (
		    SELECT servicesFromSpecies.id_service as service, 
		    (
		    --считаем загруженность
			SELECT COUNT(*) FROM pet_room_service where service = servicesFromSpecies.id_service
		    ) as zagrujenost, servicesFromSpecies.idpet as pet, servicesFromSpecies.arrdate as ArrivalDate
		    FROM
		    (
			--выбираем специалистов, которыми можем его заменить
			SELECT id_service, list.pet as idpet, list.ArrivalDate as arrdate FROM service,
			(
			--выбираем животное увольняемого отрудника
			    SELECT pet, ArrivalDate FROM pet_room_service WHERE service = fired LIMIT 1
			) AS list
			WHERE 
			(
			--получаем вид этого животного
			    SELECT species FROM pet WHERE pet.id_pet = list.pet
			) = ANY (specialization)
		       
		    ) AS servicesFromSpecies ORDER BY zagrujenost ASC limit 1

            ) AS subquery WHERE pet_room_service.pet = subquery.pet AND pet_room_service.ArrivalDate = subquery.ArrivalDate;
	END LOOP;

	DELETE FROM service WHERE id_service = fired; 
	 
        RETURN 0;
	END;
$$ LANGUAGE plpgSQL;

SELECT SpeciesTrans(('KM', '765566'));




/*
CREATE OR REPLACE FUNCTION SpeciesTrans(fired Passport, sp species, amount INTEGER)
RETURNS INTEGER
	AS $$
	DECLARE
		
		
		max_row_number INTEGER;
		speciestype Passport;
	BEGIN 
		--таблица соответсвия работников количеству опр вида животных, ранжированная по загруженности
		CREATE OR REPLACE VIEW speciesService AS
			SELECT service, COUNT(CASE WHEN pet.species= 'cat' and pet.id_pet=pet_room_service.pet then 1 end) AS sp
			FROM pet_room_service, pet
			WHERE service in 
			(
				SELECT DISTINCT service FROM pet_room_service, service, pet
				WHERE service = id_service AND pet = id_pet AND ( 'cat' = ANY (specialization))
			) 
			GROUP BY service
			ORDER BY sp;
		
		SELECT COUNT(service)
		INTO max_row_number
		FROM speciesService;

		DECLARE serviceSp_cur CURSOR
		FOR SELECT * FROM speciesService;
		--IF NOT(EXISTS(speciesService))
		--	THEN RAISE EXCEPTION
		--	'Невозможно заменить работника на текущий момент';
		--END IF;
	
		

		OPEN serviceSp_cur ;
		
		while amount > 0 loop
		
			FOR i IN 1..max_row_number LOOP
					FETCH  serviceSp_cur.id_service INTO speciesType;
					UPDATE pet_room_service 
					SET id_service = serviceType.id_service
					
					amount := amount - 1;
			END LOOP;
		end loop;
		CLOSE serviceSp_cur ;
	RETURN amount;
	END;
	$$ LANGUAGE plpgSQL;

CREATE OR REPLACE FUNCTION Fire (fired Passport)
	RETURNS INTEGER
	AS $$
	DECLARE 
		max_animal_species INTEGER;
		species_amount INTEGER;
		sp species;
		a_flag INTEGER;
	BEGIN
		CREATE OR REPLACE VIEW animalOfFFired AS
		WITH animalAmountFired AS
		(	SELECT service, species, COUNT(pet) AS pet_amount
			FROM pet_room_service, pet
			WHERE service=fired AND pet = id_pet
			GROUP BY service, species
			ORDER BY pet_amount
		)
		SELECT ROW_NUMBER () OVER (ORDER BY pet_amount) AS num,*
		FROM animalAmountFired;

		SELECT MAX(num)
		INTO max_animal_species
		FROM animalOfFFired;
		
		FOR i IN 1..max_animal_species LOOP
			SELECT pet_amount, species
			INTO species_amount, sp 
			FROM animalAmountFired
			WHERE num = i;
			SELECT SpeciesTrans(fired, sp species, species_amount);
		END LOOP;
		DELETE FROM service WHERE id_service = fired;

		
	END;
	$$ LANGUAGE plpgSQL;		
	*/