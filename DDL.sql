-- TABLES

-- TODO
CREATE TABLE Animals(
    animalID INTEGER PRIMARY KEY
);

-- TODO
CREATE TABLE Feeders(
    employeeID INTEGER PRIMARY KEY
);

-- TODO
CREATE TABLE Trainers(
	employeeID INTEGER PRIMARY KEY
);

-- TODO
CREATE TABLE Keepers(
	employeeID INTEGER PRIMARY KEY
);

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
	day CHAR(10),
	time DATE,
	PRIMARY KEY (feederID, animalID, day, time),
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
	day CHAR(10),
	time DATE,
	amount INTEGER,
	PRIMARY KEY (supplyID, feederID, day, time),
	FOREIGN KEY (supplyID) REFERENCES FoodSupplies(supplyID),
	FOREIGN KEY (feederID, animalID, day, time)
		REFERENCES FeedingSchedules(feederID, animalID, day, time)
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
	employeeID INTEGER,
	PRIMARY KEY (eventID, employeeID),
	FOREIGN KEY (eventID) REFERENCES Events(eventID)
		ON DELETE CASCADE,
	FOREIGN KEY (employeeID) REFERENCES Trainers(employeeID)
		ON DELETE CASCADE
);


-- INSERT STAMENETS

-- Animals TODO
INSERT INTO Animals(animalID) VALUES(1);
INSERT INTO Animals(animalID) VALUES(2);
INSERT INTO Animals(animalID) VALUES(3);
INSERT INTO Animals(animalID) VALUES(4);
INSERT INTO Animals(animalID) VALUES(5);

-- Feeders TODO
INSERT INTO Feeders(employeeID) VALUES(1);
INSERT INTO Feeders(employeeID) VALUES(2);
INSERT INTO Feeders(employeeID) VALUES(3);
INSERT INTO Feeders(employeeID) VALUES(4);
INSERT INTO Feeders(employeeID) VALUES(5);

-- Trainers TODO
INSERT INTO Trainers(employeeID) VALUES(1);
INSERT INTO Trainers(employeeID) VALUES(2);
INSERT INTO Trainers(employeeID) VALUES(3);
INSERT INTO Trainers(employeeID) VALUES(4);
INSERT INTO Trainers(employeeID) VALUES(5);

-- Keepers TODO
INSERT INTO Keepers(employeeID) VALUES(1);
INSERT INTO Keepers(employeeID) VALUES(2);
INSERT INTO Keepers(employeeID) VALUES(3);
INSERT INTO Keepers(employeeID) VALUES(4);
INSERT INTO Keepers(employeeID) VALUES(5);

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
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,day,time) VALUES(1, 1, 2, 'Monday',  ((TO_DATE('7:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,day,time) VALUES(1, 1, 2, 'Tuesday', ((TO_DATE('7:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,day,time) VALUES(1, 1, 2, 'Tuesday', ((TO_DATE('12:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,day,time) VALUES(1, 1, 2, 'Tuesday', ((TO_DATE('18:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,day,time) VALUES(1, 1, 2, 'Wednesday', ((TO_DATE('7:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,day,time) VALUES(1, 1, 2, 'Thursday', ((TO_DATE('7:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,day,time) VALUES(1, 1, 2, 'Friday', ((TO_DATE('7:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,day,time) VALUES(1, 1, 2, 'Friday', ((TO_DATE('13:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,day,time) VALUES(1, 1, 2, 'Friday', ((TO_DATE('20:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,day,time) VALUES(1, 1, 2, 'Saturday', ((TO_DATE('7:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,keeperID,day,time) VALUES(1, 1, 2, 'Sunday', ((TO_DATE('7:30', 'HH24:MI'))));
-- Feeder 2 and AnimalID 2
INSERT INTO FeedingSchedules(feederID,animalID,day,time) VALUES(2, 1, 'Monday',  ((TO_DATE('7:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,day,time) VALUES(2, 1, 'Monday', ((TO_DATE('12:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,day,time) VALUES(2, 1, 'Monday', ((TO_DATE('18:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,day,time) VALUES(2, 1, 'Tuesday', ((TO_DATE('7:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,day,time) VALUES(2, 1, 'Thursday', ((TO_DATE('7:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,day,time) VALUES(2, 1, 'Wednesday', ((TO_DATE('7:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,day,time) VALUES(2, 1, 'Wednesday', ((TO_DATE('13:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,day,time) VALUES(2, 1, 'Wednesday', ((TO_DATE('20:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,day,time) VALUES(2, 1, 'Saturday', ((TO_DATE('7:30', 'HH24:MI'))));
INSERT INTO FeedingSchedules(feederID,animalID,day,time) VALUES(2, 1, 'Sunday', ((TO_DATE('7:30', 'HH24:MI'))));

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
INSERT INTO HostedBy(eventID, employeeID) VALUES (1,1);
INSERT INTO HostedBy(eventID, employeeID) VALUES (2,1);
INSERT INTO HostedBy(eventID, employeeID) VALUES (3,1);
INSERT INTO HostedBy(eventID, employeeID) VALUES (4,1);
INSERT INTO HostedBy(eventID, employeeID) VALUES (1,5);