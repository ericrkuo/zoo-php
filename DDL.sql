-- TABLES

-- TODO
CREATE TABLE Animals(
    animalID INTEGER PRIMARY KEY
);

CREATE TABLE Employees(
		address VARCHAR(50) NOT NULL,
		firstName VARCHAR (30),
		lastName VARCHAR(30),
		employeeID INTEGER PRIMARY KEY,
		email VARCHAR(30) UNIQUE,
		phoneNumber VARCHAR(20),
		sin INTEGER UNIQUE NOT NULL,
		birthDate DATE);

--Feeders
CREATE TABLE Feeders(
	employeeID INTEGER PRIMARY KEY,
	FOREIGN KEY (employeeID) REFERENCES Employees ON DELETE CASCADE);


-- Trainers
CREATE TABLE Trainers(
	employeeID INTEGER PRIMARY KEY, 
	FOREIGN KEY (employeeID) REFERENCES Employees ON DELETE CASCADE);


-- Keepers
CREATE TABLE Keepers(
	employeeID INTEGER PRIMARY KEY, 
	FOREIGN KEY (employeeID) REFERENCES Employees ON DELETE CASCADE);
	

-- TODO
CREATE TABLE Enclosures(
	enclosureID INTEGER PRIMARY KEY
);

CREATE TABLE FoodSupplies(
	supplyID INTEGER PRIMARY KEY,
	name CHAR(50),
	expiryDate DATE,
	quantity INTEGER,
	unit CHAR(50)
);

CREATE TABLE FeedingSchedules(
	feederID INTEGER,
	animalID INTEGER,
	keeperID INTEGER,
	dateTime DATE,
	PRIMARY KEY (feederID, animalID, dateTime),
	FOREIGN KEY (feederID) REFERENCES Feeders(employeeID)
		ON DELETE CASCADE,
	FOREIGN KEY (animalID) REFERENCES Animals(animalID)
		ON DELETE CASCADE,
	FOREIGN KEY (keeperID) REFERENCES Keepers(employeeID)
		ON DELETE CASCADE
);

CREATE TABLE MadeUpOf(
	supplyID INTEGER,
	feederID INTEGER,
	animalID INTEGER,
	dateTime DATE,
	amount INTEGER,
	PRIMARY KEY (supplyID, feederID, dateTime),
	FOREIGN KEY (supplyID) REFERENCES FoodSupplies(supplyID),
	FOREIGN KEY (feederID, animalID, dateTime)
		REFERENCES FeedingSchedules(feederID, animalID, dateTime)
		ON DELETE CASCADE
);

CREATE TABLE Feed (
	feederID INTEGER,
	animalID INTEGER,
	FOREIGN KEY (feederID) REFERENCES Feeders(employeeID)
		ON DELETE CASCADE,
	FOREIGN KEY (animalID) REFERENCES Animals(animalID)
		ON DELETE CASCADE
);

CREATE TABLE Visitors(
	visitorID INTEGER PRIMARY KEY,
	firstName CHAR(100),
	lastName CHAR(100),
	birthDate DATE,
	address CHAR(100),
	phoneNumber CHAR(100),
	email CHAR(100)
);

CREATE TABLE VisitorRecords(
	recordID INTEGER PRIMARY KEY,
	visitorID INTEGER,
	visitDate DATE,
	FOREIGN KEY (visitorID) REFERENCES Visitors(visitorID)
		ON DELETE SET NULL
);

CREATE TABLE Events(
	eventID INTEGER PRIMARY KEY,
	enclosureID INTEGER NOT NULL,
	capacity INTEGER,
	description CHAR(1000),
	name CHAR(100),
	startTime DATE,
	endTime DATE,
	FOREIGN KEY (enclosureID) REFERENCES Enclosures(enclosureID)
		ON DELETE CASCADE
);

CREATE TABLE Reserve(
	eventID INTEGER,
	visitorID INTEGER,
	PRIMARY KEY (eventID, visitorID),
	FOREIGN KEY (eventID) REFERENCES Events(eventID)
		ON DELETE CASCADE,
	FOREIGN KEY (visitorID) REFERENCES Visitors(visitorID)
		ON DELETE CASCADE
);

CREATE TABLE FeaturedIn(
	eventID INTEGER,
	animalID INTEGER,
	PRIMARY KEY (eventID, animalID),
	FOREIGN KEY (eventID) REFERENCES Events(eventID)
		ON DELETE CASCADE,
	FOREIGN KEY (animalID) REFERENCES Animals(animalID)
		ON DELETE CASCADE
);

CREATE TABLE HostedBy(
	eventID INTEGER,
	trainerID INTEGER,
	PRIMARY KEY (eventID, trainerID),
	FOREIGN KEY (eventID) REFERENCES Events(eventID)
		ON DELETE CASCADE,
	FOREIGN KEY (trainerID) REFERENCES Trainers(employeeID)
		ON DELETE CASCADE
);

CREATE TABLE ResponsibleFor(
	keeperID INTEGER, 
	animalID INTEGER, 
	PRIMARY KEY (keeperID, animalID), 
	FOREIGN KEY (keeperID) REFERENCES Keepers ON DELETE CASCADE,
	FOREIGN KEY (animalID) REFERENCES Animals ON DELETE CASCADE);


-- INSERT STAMENETS

-- Animals TODO
INSERT INTO Animals(animalID) VALUES(1);
INSERT INTO Animals(animalID) VALUES(2);
INSERT INTO Animals(animalID) VALUES(3);
INSERT INTO Animals(animalID) VALUES(4);
INSERT INTO Animals(animalID) VALUES(5);

--Employees
INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('18853 41st Ave, Vancouver B.C', 'Benjamin', 'Kowalewicz', 1234567890, 'benk33@gmail.com', '778-996-3324', 333908767, '16-DEC-1975');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('14456 Acorn Rd., Langley B.C', 'Ian', 'Dsa', 3412909772, 'iandsa@hotmail.com', '604-333-1212', 333444555, '31-OCT-1975'); 

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('5555 Fern St., Burnaby B.C', 'Aaron', 'Solowoniuk', 0011234576, 'aaronsolowoniuk@gmail.com', '778-090-2323', 767676799, '21-NOV-1974');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('4661 HollyBerry Rd., Richmond, B.C', 'Jonathan', 'Gallant', 8876543421, 'jonnygee222@gmail.com', '778-999-5533',  876456333, '23-JUL-1976'); 

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('4546 Alexis St., Richmond, B.C', 'Jordan', 'Hastings', 2008097345, 'jhastings23@gmail.com', '778-665-8778', 199298090, '15-MAR-1982');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('18853 55A Ave., Surrey B.C', 'Jessica', 'Bator', 3332224440, 'jkbator333@gmail.com', '778-994-2633', 197690900, '24-MAR-2001'); 

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('18894 50th Ave,. Surrey, B.C', 'Sara', 'Marshall', 4040556677, 'saramarshall@student.ubc.ca', '778-558-8212', 197788769, '26-DEC-2001');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('8494 Pecan St., Vancouver B.C', 'Zahra', 'Raza', 3202212130, 'zahraza@gmail.com', '780-881-4131', 197842425, '31-JUL-2001');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('18852 52nd Ave., Surrey, B.C', 'Alex', 'Hawk', 7007987247, 'alexhawk@student.ubc.ca', '778-847-1469', 197962350, '23-OCT-2001');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('18859 55A ave., Surrey, B.C', 'Kelly', 'Ye', 2001908700, 'agoddexx@hotmail.com', '778-909-8787', 198083235, '23-JAN-2001');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('6545 60th Ave., Surrey, B.C', 'Faye', 'Marwick', 2002764532, 'faye.ay@gmail.com', '778-666-2241', 198165455, '12-FEB-2001');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('7992 Tribia Lane., Coquitlam, B.C', 'John', 'Frusciante', 2003098657, 'jfguitar@gmail.com', '604-789-9494', 199102020, '5-MAR-1970');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('6969 Purple St., Vancouver, B.C', 'Flea', NULL, 2004873450, 'fleab@gmail.com', '604-574-4577', 199188887, '16-OCT-1962');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('7676 Venice St., Langley, B.C', 'Chad', 'Smith', 2005676790, 'thechadsmith@gmail.com', '604-989-4576', 199140404, '25-OCT-1961');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('19984  California Rd., Vancouver, B.C', 'Anthony', 'Kiedis', 2006999654, 'akiedis6969@gmail.com', '604-737-4203', 199133226, '01-NOV-1962');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('7999 Tribia Lane., Coquitlam, B.C', 'Josh', 'Klinghoffer', 2007654992, 'jkling55@gmail.com', '778-002-3242',199109090, '03-OCT-1979');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('12001 Sad St., Burnaby, B.C', 'Thom', 'Yorke', 2009097566, 'tyorkeradio@outlook.com', '604-604-0000', 199300120, '07-OCT-1968');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('7878 Skater St., Surrey, B.C', 'Avril', 'Lavigne', 2010987770, 'avrilavigne@hotmail.com', '778-778-7777', 199412312, '27-SEP-1984');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('5564 Fever Rd., Surrey, B.C', 'Jason', 'Butler', 2011908734, 'jasonaalonbutler42@gmail.com', '778-020-3411', 199509134, '17-JUL-1985');

INSERT INTO Employees(address, firstName, lastName, employeeID, email, phoneNumber, sin, birthDate)
VALUES('10098 English Rd., Langley, B.C', 'Damon', 'Albarn', 2012098761, 'damonboy@outlook.com', '984-009-2727', 199612300, '23-MAR-1968');

-- Feeders
INSERT INTO Feeders(employeeID) VALUES(1234567890);
INSERT INTO Feeders(employeeID) VALUES(3412909772);
INSERT INTO Feeders(employeeID) VALUES(0011234576);
INSERT INTO Feeders(employeeID) VALUES(8876543421);
INSERT INTO Feeders(employeeID) VALUES(2008097345);

-- Trainers TODO
INSERT INTO Trainers(employeeID) VALUES(1);
INSERT INTO Trainers(employeeID) VALUES(2);
INSERT INTO Trainers(employeeID) VALUES(3);
INSERT INTO Trainers(employeeID) VALUES(4);
INSERT INTO Trainers(employeeID) VALUES(5);

-- Keepers
INSERT INTO Keepers(employeeId) VALUES(3332224440);
INSERT INTO Keepers(employeeId) VALUES(4040556677);
INSERT INTO Keepers(employeeId) VALUES(3202212130);
INSERT INTO Keepers(employeeId) VALUES(7007987247);
INSERT INTO Keepers(employeeId) VALUES(2001908700);

-- Enclosures TODO
INSERT INTO Enclosures(enclosureID) VALUES(1);
INSERT INTO Enclosures(enclosureID) VALUES(2);
INSERT INTO Enclosures(enclosureID) VALUES(3);
INSERT INTO Enclosures(enclosureID) VALUES(4);
INSERT INTO Enclosures(enclosureID) VALUES(5);

-- FoodSupplies
INSERT INTO FoodSupplies(supplyID,name,expiryDate,quantity,unit) VALUES(1, 'Peanuts',  (TO_DATE('2025/01/01', 'yyyy/mm/dd')), 100, 'grams');
INSERT INTO FoodSupplies(supplyID,name,expiryDate,quantity,unit) VALUES(2, 'Beef',     (TO_DATE('2022/05/03', 'yyyy/mm/dd')), 1000, 'pounds');
INSERT INTO FoodSupplies(supplyID,name,expiryDate,quantity,unit) VALUES(3, 'Milk',     (TO_DATE('2021/12/31', 'yyyy/mm/dd')), 50, 'litres');
INSERT INTO FoodSupplies(supplyID,name,expiryDate,quantity,unit) VALUES(4, 'Eggs',     (TO_DATE('2021/11/20', 'yyyy/mm/dd')), 200, 'eggs');
INSERT INTO FoodSupplies(supplyID,name,expiryDate,quantity,unit) VALUES(5, 'Sardines', (TO_DATE('2022/02/17', 'yyyy/mm/dd')), 1000, 'grams');

-- FeedingSchedules
-- Feeder 1 and AnimalID 1
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(1, 1, 2, ((TO_DATE('2021/12/31 7:30',  'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(1, 1, 2, ((TO_DATE('2021/10/25 7:30',  'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(1, 1, 2, ((TO_DATE('2021/10/25 12:30', 'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(1, 1, 2, ((TO_DATE('2021/10/25 18:30', 'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(1, 1, 2, ((TO_DATE('2021/11/26 7:30',  'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(1, 1, 2, ((TO_DATE('2021/12/06 7:30',  'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(1, 1, 2, ((TO_DATE('2021/12/07 7:30',  'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(1, 1, 2, ((TO_DATE('2021/12/11 13:30', 'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(1, 1, 2, ((TO_DATE('2021/12/11 20:30', 'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(1, 1, 2, ((TO_DATE('2021/12/12 7:30',  'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(1, 1, 2, ((TO_DATE('2021/12/21 7:30',  'yyyy/mm/dd HH24:MI'))));
-- Feeder 2 and AnimalID 2
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(2, 2, 3, ((TO_DATE('2021/12/31 7:30',  'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(2, 2, 3, ((TO_DATE('2021/10/25 7:30',  'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(2, 2, 3, ((TO_DATE('2021/10/25 12:30', 'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(2, 2, 3, ((TO_DATE('2021/10/25 18:30', 'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(2, 2, 3, ((TO_DATE('2021/11/26 7:30',  'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(2, 2, 3, ((TO_DATE('2021/12/06 7:30',  'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(2, 2, 3, ((TO_DATE('2021/12/07 7:30',  'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(2, 2, 3, ((TO_DATE('2021/12/11 13:30', 'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(2, 2, 3, ((TO_DATE('2021/12/11 20:30', 'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(2, 2, 3, ((TO_DATE('2021/12/12 7:30',  'yyyy/mm/dd HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,dateTime) VALUES(2, 2, 3, ((TO_DATE('2021/12/21 7:30',  'yyyy/mm/dd HH24:MI'))));

-- MadeUpOf
INSERT INTO MadeUpOf(supplyID,feederID,animalID,day,time,amount) VALUES(1, 1, 1, 'Sunday', ((TO_DATE('7:30', 'HH24:MI'))), 10);
INSERT INTO MadeUpOf(supplyID,feederID,animalID,day,time,amount) VALUES(2, 1, 1, 'Sunday', ((TO_DATE('7:30', 'HH24:MI'))), 15);
INSERT INTO MadeUpOf(supplyID,feederID,animalID,day,time,amount) VALUES(3, 1, 1, 'Sunday', ((TO_DATE('7:30', 'HH24:MI'))), 2);
INSERT INTO MadeUpOf(supplyID,feederID,animalID,day,time,amount) VALUES(4, 1, 1, 'Sunday', ((TO_DATE('7:30', 'HH24:MI'))), 2);
INSERT INTO MadeUpOf(supplyID,feederID,animalID,day,time,amount) VALUES(5, 1, 1, 'Sunday', ((TO_DATE('7:30', 'HH24:MI'))), 15);

-- Feed
INSERT INTO Feed(feederID,animalID) VALUES(1,1);
INSERT INTO Feed(feederID,animalID) VALUES(2,1);
INSERT INTO Feed(feederID,animalID) VALUES(3,1);
INSERT INTO Feed(feederID,animalID) VALUES(4,2);
INSERT INTO Feed(feederID,animalID) VALUES(5,3);
INSERT INTO Feed(feederID,animalID) VALUES(5,4);
INSERT INTO Feed(feederID,animalID) VALUES(5,5);

-- Visitors
-- Credits to https://www.mockaroo.com/
INSERT INTO Visitors (visitorID, firstName, lastName, birthDate, address, phoneNumber, email) VALUES (1, 'Roldan', 'Duncanson',   (TO_DATE('2019/01/21', 'yyyy/mm/dd')), '0 Southridge Road', '556-225-6688', 'rduncanson0@etsy.com');
INSERT INTO Visitors (visitorID, firstName, lastName, birthDate, address, phoneNumber, email) VALUES (2, 'Lucia', 'Pemberton',    (TO_DATE('2019/09/08', 'yyyy/mm/dd')), '6395 Grasskamp Street', '613-960-9945', 'lpemberton1@fastcompany.com');
INSERT INTO Visitors (visitorID, firstName, lastName, birthDate, address, phoneNumber, email) VALUES (3, 'Erwin', 'Stobbie',      (TO_DATE('2020/11/03', 'yyyy/mm/dd')), '89093 Talmadge Park', '821-450-0208', 'estobbie2@state.tx.us');
INSERT INTO Visitors (visitorID, firstName, lastName, birthDate, address, phoneNumber, email) VALUES (4, 'Rebekkah', 'Sharrocks', (TO_DATE('2019/08/14', 'yyyy/mm/dd')), '0 Transport Parkway', '440-498-9144', 'rsharrocks3@psu.edu');
INSERT INTO Visitors (visitorID, firstName, lastName, birthDate, address, phoneNumber, email) VALUES (5, 'Elsie', 'Dannohl',      (TO_DATE('2020/01/24', 'yyyy/mm/dd')), '6140 Anderson Avenue', '788-183-8308', 'edannohl4@discuz.net');
INSERT INTO Visitors (visitorID, firstName, lastName, birthDate, address, phoneNumber, email) VALUES (6, 'Chaunce', 'Nicholas',   (TO_DATE('2019/12/28', 'yyyy/mm/dd')), '70 Maywood Parkway', '699-172-3209', 'cnicholas5@whitehouse.gov');
INSERT INTO Visitors (visitorID, firstName, lastName, birthDate, address, phoneNumber, email) VALUES (7, 'Zonda', 'Ruddiforth',   (TO_DATE('2018/05/21', 'yyyy/mm/dd')), '24094 Canary Pass', '724-737-3986', 'zruddiforth6@gizmodo.com');
INSERT INTO Visitors (visitorID, firstName, lastName, birthDate, address, phoneNumber, email) VALUES (8, 'Edmon', 'Osbidston',    (TO_DATE('2021/01/09', 'yyyy/mm/dd')), '83 Duke Alley', '792-532-8820', 'eosbidston7@ihg.com');
INSERT INTO Visitors (visitorID, firstName, lastName, birthDate, address, phoneNumber, email) VALUES (9, 'Cozmo', 'Snowling',     (TO_DATE('2020/01/02', 'yyyy/mm/dd')), '05 Summit Way', '337-796-3645', 'csnowling8@freewebs.com');
INSERT INTO Visitors (visitorID, firstName, lastName, birthDate, address, phoneNumber, email) VALUES (10, 'Elisha', 'Goor',       (TO_DATE('2018/01/15', 'yyyy/mm/dd')), '7909 Manitowish Court', '298-325-3587', 'egoor9@goodreads.com');

-- VisitorRecords
INSERT INTO VisitorRecords (recordID, visitorID, visitDate) VALUES (1, 1,   (TO_DATE('2018/03/25', 'yyyy/mm/dd')));
INSERT INTO VisitorRecords (recordID, visitorID, visitDate) VALUES (2, 2,   (TO_DATE('2013/06/07', 'yyyy/mm/dd')));
INSERT INTO VisitorRecords (recordID, visitorID, visitDate) VALUES (3, 3,   (TO_DATE('2020/05/18', 'yyyy/mm/dd')));
INSERT INTO VisitorRecords (recordID, visitorID, visitDate) VALUES (4, 4,   (TO_DATE('2013/08/03', 'yyyy/mm/dd')));
INSERT INTO VisitorRecords (recordID, visitorID, visitDate) VALUES (5, 5,   (TO_DATE('2010/03/23', 'yyyy/mm/dd')));
INSERT INTO VisitorRecords (recordID, visitorID, visitDate) VALUES (6, 6,   (TO_DATE('2011/08/26', 'yyyy/mm/dd')));
INSERT INTO VisitorRecords (recordID, visitorID, visitDate) VALUES (7, 7,   (TO_DATE('2002/01/04', 'yyyy/mm/dd')));
INSERT INTO VisitorRecords (recordID, visitorID, visitDate) VALUES (8, 8,   (TO_DATE('2017/11/03', 'yyyy/mm/dd')));
INSERT INTO VisitorRecords (recordID, visitorID, visitDate) VALUES (9, 9,   (TO_DATE('2012/10/09', 'yyyy/mm/dd')));
INSERT INTO VisitorRecords (recordID, visitorID, visitDate) VALUES (10, 10, (TO_DATE('2010/09/08', 'yyyy/mm/dd')));

-- Events
INSERT INTO Events (eventID, enclosureID, capacity, description, name, startTime, endTime) VALUES (1, 1, 42, 'Pasngr in hv veh injured in clsn w pedl cyc nontraf, sequela', 'McLaughlin, Schiller and Kuphal', (TO_DATE ('2014-05-05 16:00', 'YYYY-MM-DD HH24:MI')), (TO_DATE ('2014-05-05 18:00', 'YYYY-MM-DD HH24:MI')));
INSERT INTO Events (eventID, enclosureID, capacity, description, name, startTime, endTime) VALUES (2, 2, 27, 'External constriction of right middle finger', 'Luettgen LLC', 									(TO_DATE ('2014-05-05 16:00', 'YYYY-MM-DD HH24:MI')), (TO_DATE ('2014-05-05 18:00', 'YYYY-MM-DD HH24:MI')));
INSERT INTO Events (eventID, enclosureID, capacity, description, name, startTime, endTime) VALUES (3, 3, 76, 'Puncture wound without foreign body of lower back and pelvis', 'Grant, Swift and Block', 			(TO_DATE ('2014-05-05 16:00', 'YYYY-MM-DD HH24:MI')), (TO_DATE ('2014-05-05 18:00', 'YYYY-MM-DD HH24:MI')));
INSERT INTO Events (eventID, enclosureID, capacity, description, name, startTime, endTime) VALUES (4, 4, 26, 'Insrt gastr/duodnl sound cause abn react/compl, w/o misadvnt', 'Beer-Sauer', 						(TO_DATE ('2014-05-05 16:00', 'YYYY-MM-DD HH24:MI')), (TO_DATE ('2014-05-05 18:00', 'YYYY-MM-DD HH24:MI')));
INSERT INTO Events (eventID, enclosureID, capacity, description, name, startTime, endTime) VALUES (5, 5, 54, 'Other peripheral vertigo, left ear', 'Berge, Denesik and Bayer', 									(TO_DATE ('2014-05-05 16:00', 'YYYY-MM-DD HH24:MI')), (TO_DATE ('2014-05-05 18:00', 'YYYY-MM-DD HH24:MI')));
INSERT INTO Events (eventID, enclosureID, capacity, description, name, startTime, endTime) VALUES (6, 1, 63, 'Athscl bypass of cor art of txplt heart w ang pctrs w spasm', 'Lesch-Hayes', 						(TO_DATE ('2014-05-05 16:00', 'YYYY-MM-DD HH24:MI')), (TO_DATE ('2014-05-05 18:00', 'YYYY-MM-DD HH24:MI')));
INSERT INTO Events (eventID, enclosureID, capacity, description, name, startTime, endTime) VALUES (7, 2, 94, 'Dislocation of tarsometatarsal joint of right foot', 'Hessel LLC', 								(TO_DATE ('2014-05-05 16:00', 'YYYY-MM-DD HH24:MI')), (TO_DATE ('2014-05-05 18:00', 'YYYY-MM-DD HH24:MI')));
INSERT INTO Events (eventID, enclosureID, capacity, description, name, startTime, endTime) VALUES (8, 3, 28, 'Type I occipital condyle fracture, right side, init', 'Smitham-Thompson', 						(TO_DATE ('2014-05-05 16:00', 'YYYY-MM-DD HH24:MI')), (TO_DATE ('2014-05-05 18:00', 'YYYY-MM-DD HH24:MI')));
INSERT INTO Events (eventID, enclosureID, capacity, description, name, startTime, endTime) VALUES (9, 4, 52, 'Subluxation of distal interphaln joint of left thumb, init', 'Hammes-Legros', 					(TO_DATE ('2014-05-05 16:00', 'YYYY-MM-DD HH24:MI')), (TO_DATE ('2014-05-05 18:00', 'YYYY-MM-DD HH24:MI')));
INSERT INTO Events (eventID, enclosureID, capacity, description, name, startTime, endTime) VALUES (10,5, 53, 'Poisoning by histamine H2-receptor blockers, assault', 'Waters-Mante', 							(TO_DATE ('2014-05-05 16:00', 'YYYY-MM-DD HH24:MI')), (TO_DATE ('2014-05-05 18:00', 'YYYY-MM-DD HH24:MI')));

-- Reserve
INSERT INTO Reserve (eventID, visitorID) VALUES (1,1);
INSERT INTO Reserve (eventID, visitorID) VALUES (2,1);
INSERT INTO Reserve (eventID, visitorID) VALUES (3,1);
INSERT INTO Reserve (eventID, visitorID) VALUES (4,1);
INSERT INTO Reserve (eventID, visitorID) VALUES (1,5);

-- HostedBy
INSERT INTO HostedBy(eventID, trainerID) VALUES (1,1);
INSERT INTO HostedBy(eventID, trainerID) VALUES (2,1);
INSERT INTO HostedBy(eventID, trainerID) VALUES (3,1);
INSERT INTO HostedBy(eventID, trainerID) VALUES (4,1);
INSERT INTO HostedBy(eventID, trainerID) VALUES (1,5);

--ResponsibleFor
INSERT INTO ResponsibleFor(keeperID, animalID) VALUES(3332224440, TODO);
INSERT INTO ResponsibleFor(keeperID, animalID) VALUES(4040556677, TODO);
INSERT INTO ResponsibleFor(keeperID, animalID) VALUES(3202212130, TODO);
INSERT INTO ResponsibleFor(keeperID, animalID) VALUES(7007987247, TODO);
INSERT INTO ResponsibleFor(keeperID, animalID) VALUES(2001908700, TODO);
