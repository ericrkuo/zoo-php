-- TABLES

-- TODO
CREATE TABLE Animals(
    animalID INTEGER PRIMARY KEY
);

-- TODO normalize
CREATE TABLE Breeds(
	breedID INTEGER PRIMARY KEY,
	breed CHAR(100) UNIQUE,
	species CHAR(100),
	animalGroup CHAR(100),
	facts CHAR(1000),
	status CHAR(50)
);

CREATE TABLE Employees(
	employeeID INTEGER PRIMARY KEY,
	address CHAR(100) NOT NULL,
	firstName CHAR(100),
	lastName CHAR(100),
	email CHAR(100) UNIQUE,
	phoneNumber CHAR(100),
	sin INTEGER UNIQUE NOT NULL,
	birthDate DATE);

CREATE TABLE Feeders(
	employeeID INTEGER PRIMARY KEY,
	FOREIGN KEY (employeeID) REFERENCES Employees(employeeID) ON DELETE CASCADE);

CREATE TABLE Trainers(
	employeeID INTEGER PRIMARY KEY, 
	FOREIGN KEY (employeeID) REFERENCES Employees(employeeID) ON DELETE CASCADE);

CREATE TABLE Keepers(
	employeeID INTEGER PRIMARY KEY, 
	FOREIGN KEY (employeeID) REFERENCES Employees(employeeID) ON DELETE CASCADE);

CREATE TABLE Veterinarians(
	employeeID INTEGER PRIMARY KEY, 
	FOREIGN KEY (employeeID) REFERENCES Employees(employeeID) ON DELETE CASCADE);	

-- TODO Duy and Jessica
CREATE TABLE Enclosures(
	enclosureID INTEGER PRIMARY KEY
);

CREATE TABLE FoodSupplies(
	supplyID INTEGER PRIMARY KEY,
	name CHAR(100),
	expiryDate DATE,
	quantity INTEGER,
	unit CHAR(50)
);

CREATE TABLE FeedingSchedules(
	feederID INTEGER,
	animalID INTEGER,
	keeperID INTEGER NOT NULL,
	dateTime DATE,
	PRIMARY KEY (feederID, animalID, dateTime),
	FOREIGN KEY (feederID) REFERENCES Feeders(employeeID)
		ON DELETE CASCADE,
	FOREIGN KEY (animalID) REFERENCES Animals(animalID)
		ON DELETE CASCADE,
	FOREIGN KEY (keeperID) REFERENCES Keepers(employeeID)
);

CREATE TABLE MadeUpOf(
	supplyID INTEGER,
	feederID INTEGER,
	animalID INTEGER,
	dateTime DATE,
	amount INTEGER,
	PRIMARY KEY (supplyID, feederID, animalID, dateTime),
	FOREIGN KEY (supplyID) REFERENCES FoodSupplies(supplyID),
	-- TODO fix this FK, waiting on Crystal's email
	FOREIGN KEY (feederID, animalID, dateTime)
		REFERENCES FeedingSchedules(feederID, animalID, dateTime)
		ON DELETE CASCADE
);

CREATE TABLE Feed (
	feederID INTEGER,
	animalID INTEGER,
	PRIMARY KEY (feederID, animalID),
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
	FOREIGN KEY (keeperID) REFERENCES Keepers(employeeID) ON DELETE CASCADE,
	FOREIGN KEY (animalID) REFERENCES Animals(animalID) ON DELETE CASCADE);

CREATE TABLE TrainedBy(
	trainerID INTEGER, 
	animalID INTEGER, 
	PRIMARY KEY (trainerID, animalID), 
	FOREIGN KEY (trainerID) REFERENCES Trainers(employeeID) ON DELETE CASCADE, 
	FOREIGN KEY (animalID) REFERENCES Animals(animalID) ON DELETE CASCADE);

CREATE TABLE MedicalRecords(
	notes CHAR(1000), 
	purpose CHAR(1000), 
	dateTime DATE, 
	animalID INTEGER, 
	vetID INTEGER NOT NULL, 
	PRIMARY KEY (dateTime, animalID), 
	FOREIGN KEY (animalID) REFERENCES Animals(animalID), 
	FOREIGN KEY (vetID) REFERENCES Veterinarians(employeeID));

-- INSERT STAMENETS

-- Animals TODO
INSERT INTO Animals(animalID) VALUES(1); 
INSERT INTO Animals(animalID) VALUES(2); 
INSERT INTO Animals(animalID) VALUES(3); 
INSERT INTO Animals(animalID) VALUES(4); 
INSERT INTO Animals(animalID) VALUES(5); 

-- Breed
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (1  , 'Grizzly bear'                , 'Ursus arctos'               , 'Vombatus ursinus'            , 'Peritoneal abscess'       , 'Canellas');     
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (2  , 'Jackal, indian'              , 'Canis aureus'               , 'Aquila chrysaetos'           , 'Dislocation sternum-open' , 'Benois');       
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (3  , 'American alligator'          , 'Alligator mississippiensis' , 'Choloepus hoffmani'          , 'Hit by train-employee'    , 'Windley');      
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (4  , 'Toucan, white-throated'      , 'Ramphastos tucanus'         , 'Cereopsis novaehollandiae'   , 'Anal sphincter tear-del'  , 'Leynagh');      
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (5  , 'Monkey, red howler'          , 'Alouatta seniculus'         , 'Colobus guerza'              , 'Pulmon circulat dis NOS'  , 'Ancketill');    
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (6  , 'Cougar'                      , 'Felis concolor'             , 'Papio cynocephalus'          , 'Vertigo'                  , 'Warhurst');     
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (7  , 'Racer, blue'                 , 'Coluber constrictor foxii'  , 'Neotis denhami'              , 'Blood inf dt cen ven cth' , 'Dowson');       
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (8  , 'Pacific gull'                , 'Gabianus pacificus'         , 'Morelia spilotes variegata'  , 'Neonat jaund in oth dis'  , 'Jaggard');      
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (9  , 'Wallaby, whip-tailed'        , 'Macropus parryi'            , 'Caiman crocodilus'           , 'Postabortion gu infect'   , 'Amort');        
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (10 , 'Lilac-breasted roller'       , 'Coracias caudata'           , 'Alcelaphus buselaphus cokii' , 'Causalgia lower limb'     , 'Densham');      
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (11 , 'Dove, rock'                  , 'Columba livia'              , 'Cyrtodactylus louisiadensis' , 'Pulmon TB NOS-micro dx'   , 'Killingworth'); 
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (12 , 'Cat, ringtail'               , 'Bassariscus astutus'        , 'Butorides striatus'          , 'War injury:bullet NEC'    , 'Sayse');        
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (13 , 'Gerbil (unidentified)'       , 'Gerbillus sp.'              , 'Pteropus rufus'              , 'Fam hx genet dis carrier' , 'de Savery');    
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (14 , 'Tailless tenrec'             , 'Tenrec ecaudatus'           , 'Petaurus norfolcensis'       , 'Food/vomit pneumonitis'   , 'Kenner');       
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (15 , 'Wallaby, bennett''s'         , 'Macropus rufogriseus'       , 'Laniarius ferrugineus'       , 'Complic labor NOS-deliv'  , 'Barber');       
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (16 , 'Pie, rufous tree'            , 'Dendrocitta vagabunda'      , 'Madoqua kirkii'              , 'Inj mult thoracic vessel' , 'Twitty');       
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (17 , 'Greater kudu'                , 'Tragelaphus strepsiceros'   , 'Oryx gazella'                , 'Comb deg cord in oth dis' , 'Stott');        
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (18 , 'Greater roadrunner'          , 'Geococcyx californianus'    , 'Phoenicopterus ruber'        , 'Joint symptom NEC-oth jt' , 'Gullivent');    
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (19 , 'Possum, golden brush-tailed' , 'Trichosurus vulpecula'      , 'Vanellus sp.'                , 'Mal neo ureteric orifice' , 'Duncanson');    
INSERT INTO Breeds (breedID , breed , species , animalGroup , facts , status) VALUES (20 , 'Indian leopard'              , 'Panthera pardus'            , 'Vulpes vulpes'               , 'Integument tiss symp NEC' , 'Reppaport');    

-- Employees
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(1  , '18853 41st Ave, Vancouver B.C'         , 'Benjamin' , 'Kowalewicz'  , 'benk33@gmail.com'             , '778-996-3324' , 333908767  , ((TO_DATE('1979-02-01'  , 'yyyy/mm/dd'))));
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(2  , '14456 Acorn Rd., Langley B.C'          , 'Ian'      , 'Dsa'         , 'iandsa@hotmail.com'           , '604-333-1212' , 333444555  , ((TO_DATE('1965-03-11'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(3  , '5555 Fern St., Burnaby B.C'            , 'Aaron'    , 'Solowoniuk'  , 'aaronsolowoniuk@gmail.com'    , '778-090-2323' , 767676799  , ((TO_DATE('2000-08-14'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(4  , '4661 HollyBerry Rd., Richmond, B.C'    , 'Jonathan' , 'Gallant'     , 'jonnygee222@gmail.com'        , '778-999-5533' , 876456333  , ((TO_DATE('1935-07-19'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(5  , '4546 Alexis St., Richmond, B.C'        , 'Jordan'   , 'Hastings'    , 'jhastings23@gmail.com'        , '778-665-8778' , 199298090  , ((TO_DATE('1992-11-13'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(6  , '18853 55A Ave., Surrey B.C'            , 'Jessica'  , 'Bator'       , 'jkbator333@gmail.com'         , '778-994-2633' , 197690900  , ((TO_DATE('1960-05-19'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(7  , '18894 50th Ave,. Surrey, B.C'          , 'Sara'     , 'Marshall'    , 'saramarshall@student.ubc.ca'  , '778-558-8212' , 197788769  , ((TO_DATE('1996-02-03'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(8  , '8494 Pecan St., Vancouver B.C'         , 'Zahra'    , 'Raza'        , 'zahraza@gmail.com'            , '780-881-4131' , 197842425  , ((TO_DATE('1993-09-30'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(9  , '18852 52nd Ave., Surrey, B.C'          , 'Alex'     , 'Hawk'        , 'alexhawk@student.ubc.ca'      , '778-847-1469' , 197962350  , ((TO_DATE('1993-04-13'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(10 , '18859 55A ave., Surrey, B.C'           , 'Kelly'    , 'Ye'          , 'agoddexx@hotmail.com'         , '778-909-8787' , 198083235  , ((TO_DATE('1983-03-16'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(11 , '6545 60th Ave., Surrey, B.C'           , 'Faye'     , 'Marwick'     , 'faye.ay@gmail.com'            , '778-666-2241' , 198165455  , ((TO_DATE('1972-04-22'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(12 , '7992 Tribia Lane., Coquitlam, B.C'     , 'John'     , 'Frusciante'  , 'jfguitar@gmail.com'           , '604-789-9494' , 199102020  , ((TO_DATE('1968-05-18'  , 'yyyy/mm/dd'))));   
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(13 , '6969 Purple St., Vancouver, B.C'       , 'Flea'     , NULL          , 'fleab@gmail.com'              , '604-574-4577' , 199188887  , ((TO_DATE('1960-04-13'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(14 , '7676 Venice St., Langley, B.C'         , 'Chad'     , 'Smith'       , 'thechadsmith@gmail.com'       , '604-989-4576' , 199140404  , ((TO_DATE('1952-01-15'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(15 , '19984  California Rd., Vancouver, B.C' , 'Anthony'  , 'Kiedis'      , 'akiedis6969@gmail.com'        , '604-737-4203' , 199133226  , ((TO_DATE('1993-01-06'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(16 , '7999 Tribia Lane., Coquitlam, B.C'     , 'Josh'     , 'Klinghoffer' , 'jkling55@gmail.com'           , '778-002-3242' , 199109090  , ((TO_DATE('1999-08-20'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(17 , '12001 Sad St., Burnaby, B.C'           , 'Thom'     , 'Yorke'       , 'tyorkeradio@outlook.com'      , '604-604-0000' , 199300120  , ((TO_DATE('1989-09-01'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(18 , '7878 Skater St., Surrey, B.C'          , 'Avril'    , 'Lavigne'     , 'avrilavigne@hotmail.com'      , '778-778-7777' , 199412312  , ((TO_DATE('1945-03-08'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(19 , '5564 Fever Rd., Surrey, B.C'           , 'Jason'    , 'Butler'      , 'jasonaalonbutler42@gmail.com' , '778-020-3411' , 199509134  , ((TO_DATE('1941-07-15'  , 'yyyy/mm/dd'))));  
INSERT INTO Employees(employeeID, address , firstName , lastName , email , phoneNumber , sin , birthDate) VALUES(20 , '10098 English Rd., Langley, B.C'       , 'Damon'    , 'Albarn'      , 'damonboy@outlook.com'         , '984-009-2727' , 199612300  , ((TO_DATE('1986-10-11'  , 'yyyy/mm/dd'))));  

-- Feeders
INSERT INTO Feeders(employeeID) VALUES(1); 
INSERT INTO Feeders(employeeID) VALUES(2); 
INSERT INTO Feeders(employeeID) VALUES(3); 
INSERT INTO Feeders(employeeID) VALUES(4); 
INSERT INTO Feeders(employeeID) VALUES(5); 

-- Trainers
INSERT INTO Trainers(employeeID) VALUES(6); 
INSERT INTO Trainers(employeeID) VALUES(7); 
INSERT INTO Trainers(employeeID) VALUES(8); 
INSERT INTO Trainers(employeeID) VALUES(9); 
INSERT INTO Trainers(employeeID) VALUES(10); 

-- Keepers
INSERT INTO Keepers(employeeId) VALUES(11); 
INSERT INTO Keepers(employeeId) VALUES(12); 
INSERT INTO Keepers(employeeId) VALUES(13); 
INSERT INTO Keepers(employeeId) VALUES(14); 
INSERT INTO Keepers(employeeId) VALUES(15);

INSERT INTO Veterinarians(employeeId) VALUES(16); 
INSERT INTO Veterinarians(employeeId) VALUES(17); 
INSERT INTO Veterinarians(employeeId) VALUES(18); 
INSERT INTO Veterinarians(employeeId) VALUES(19); 
INSERT INTO Veterinarians(employeeId) VALUES(20); 

-- Enclosures TODO
INSERT INTO Enclosures(enclosureID) VALUES(1); 
INSERT INTO Enclosures(enclosureID) VALUES(2); 
INSERT INTO Enclosures(enclosureID) VALUES(3); 
INSERT INTO Enclosures(enclosureID) VALUES(4); 
INSERT INTO Enclosures(enclosureID) VALUES(5); 

-- FoodSupplies
INSERT INTO FoodSupplies(supplyID ,name ,expiryDate ,quantity ,unit) VALUES(1 , 'Peanuts'  , (TO_DATE('2025/01/01' , 'yyyy/mm/dd')) , 100  , 'grams');  
INSERT INTO FoodSupplies(supplyID ,name ,expiryDate ,quantity ,unit) VALUES(2 , 'Beef'     , (TO_DATE('2022/05/03' , 'yyyy/mm/dd')) , 1000 , 'pounds'); 
INSERT INTO FoodSupplies(supplyID ,name ,expiryDate ,quantity ,unit) VALUES(3 , 'Milk'     , (TO_DATE('2021/12/31' , 'yyyy/mm/dd')) , 50   , 'litres'); 
INSERT INTO FoodSupplies(supplyID ,name ,expiryDate ,quantity ,unit) VALUES(4 , 'Eggs'     , (TO_DATE('2021/11/20' , 'yyyy/mm/dd')) , 200  , 'eggs');   
INSERT INTO FoodSupplies(supplyID ,name ,expiryDate ,quantity ,unit) VALUES(5 , 'Sardines' , (TO_DATE('2022/02/17' , 'yyyy/mm/dd')) , 1000 , 'grams');  

-- FeedingSchedules
-- Feeder 1, Animal 1, Keeper 12
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(1 , 1 , 12 , ((TO_DATE('2021/12/31 7:30'  , 'yyyy/mm/dd HH24:MI')))); 
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(1 , 1 , 12 , ((TO_DATE('2021/10/25 7:30'  , 'yyyy/mm/dd HH24:MI')))); 
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(1 , 1 , 12 , ((TO_DATE('2021/10/25 12:30' , 'yyyy/mm/dd HH24:MI'))));  
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(1 , 1 , 12 , ((TO_DATE('2021/10/25 18:30' , 'yyyy/mm/dd HH24:MI'))));  
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(1 , 1 , 12 , ((TO_DATE('2021/11/26 7:30'  , 'yyyy/mm/dd HH24:MI')))); 
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(1 , 1 , 12 , ((TO_DATE('2021/12/06 7:30'  , 'yyyy/mm/dd HH24:MI')))); 
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(1 , 1 , 12 , ((TO_DATE('2021/12/07 7:30'  , 'yyyy/mm/dd HH24:MI')))); 
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(1 , 1 , 12 , ((TO_DATE('2021/12/11 13:30' , 'yyyy/mm/dd HH24:MI'))));  
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(1 , 1 , 12 , ((TO_DATE('2021/12/11 20:30' , 'yyyy/mm/dd HH24:MI'))));  
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(1 , 1 , 12 , ((TO_DATE('2021/12/12 7:30'  , 'yyyy/mm/dd HH24:MI')))); 
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(1 , 1 , 12 , ((TO_DATE('2021/12/21 7:30'  , 'yyyy/mm/dd HH24:MI')))); 
-- Feeder 2, Animal 2, Keeper 13
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(2 , 2 , 13 , ((TO_DATE('2021/12/31 7:30'  , 'yyyy/mm/dd HH24:MI')))); 
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(2 , 2 , 13 , ((TO_DATE('2021/10/25 7:30'  , 'yyyy/mm/dd HH24:MI')))); 
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(2 , 2 , 13 , ((TO_DATE('2021/10/25 12:30' , 'yyyy/mm/dd HH24:MI'))));  
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(2 , 2 , 13 , ((TO_DATE('2021/10/25 18:30' , 'yyyy/mm/dd HH24:MI'))));  
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(2 , 2 , 13 , ((TO_DATE('2021/11/26 7:30'  , 'yyyy/mm/dd HH24:MI')))); 
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(2 , 2 , 13 , ((TO_DATE('2021/12/06 7:30'  , 'yyyy/mm/dd HH24:MI')))); 
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(2 , 2 , 13 , ((TO_DATE('2021/12/07 7:30'  , 'yyyy/mm/dd HH24:MI')))); 
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(2 , 2 , 13 , ((TO_DATE('2021/12/11 13:30' , 'yyyy/mm/dd HH24:MI'))));  
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(2 , 2 , 13 , ((TO_DATE('2021/12/11 20:30' , 'yyyy/mm/dd HH24:MI'))));  
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(2 , 2 , 13 , ((TO_DATE('2021/12/12 7:30'  , 'yyyy/mm/dd HH24:MI')))); 
INSERT INTO FeedingSchedules(feederID ,animalID ,keeperID ,dateTime) VALUES(2 , 2 , 13 , ((TO_DATE('2021/12/21 7:30'  , 'yyyy/mm/dd HH24:MI')))); 

-- MadeUpOf
INSERT INTO MadeUpOf(supplyID ,feederID ,animalID ,dateTime ,amount) VALUES(1 , 1 , 1 , ((TO_DATE('2021/12/31 7:30'  , 'yyyy/mm/dd HH24:MI'))) , 10); 
INSERT INTO MadeUpOf(supplyID ,feederID ,animalID ,dateTime ,amount) VALUES(2 , 1 , 1 , ((TO_DATE('2021/10/25 7:30'  , 'yyyy/mm/dd HH24:MI'))) , 15); 
INSERT INTO MadeUpOf(supplyID ,feederID ,animalID ,dateTime ,amount) VALUES(3 , 1 , 1 , ((TO_DATE('2021/10/25 12:30' , 'yyyy/mm/dd HH24:MI'))) , 2);  
INSERT INTO MadeUpOf(supplyID ,feederID ,animalID ,dateTime ,amount) VALUES(4 , 1 , 1 , ((TO_DATE('2021/10/25 18:30' , 'yyyy/mm/dd HH24:MI'))) , 2);  
INSERT INTO MadeUpOf(supplyID ,feederID ,animalID ,dateTime ,amount) VALUES(5 , 1 , 1 , ((TO_DATE('2021/11/26 7:30'  , 'yyyy/mm/dd HH24:MI'))) , 15); 

-- Feed
INSERT INTO Feed(feederID ,animalID) VALUES(1 ,1); 
INSERT INTO Feed(feederID ,animalID) VALUES(2 ,1); 
INSERT INTO Feed(feederID ,animalID) VALUES(3 ,1); 
INSERT INTO Feed(feederID ,animalID) VALUES(4 ,2); 
INSERT INTO Feed(feederID ,animalID) VALUES(5 ,3); 
INSERT INTO Feed(feederID ,animalID) VALUES(5 ,4); 
INSERT INTO Feed(feederID ,animalID) VALUES(5 ,5); 

-- Visitors
-- Credits to https://www.mockaroo.com/
INSERT INTO Visitors (visitorID , firstName , lastName , birthDate , address , phoneNumber , email) VALUES (1  , 'Roldan'   , 'Duncanson'  , (TO_DATE('2019/01/21' , 'yyyy/mm/dd')) , '0 Southridge Road'     , '556-225-6688' , 'rduncanson0@etsy.com');        
INSERT INTO Visitors (visitorID , firstName , lastName , birthDate , address , phoneNumber , email) VALUES (2  , 'Lucia'    , 'Pemberton'  , (TO_DATE('2019/09/08' , 'yyyy/mm/dd')) , '6395 Grasskamp Street' , '613-960-9945' , 'lpemberton1@fastcompany.com'); 
INSERT INTO Visitors (visitorID , firstName , lastName , birthDate , address , phoneNumber , email) VALUES (3  , 'Erwin'    , 'Stobbie'    , (TO_DATE('2020/11/03' , 'yyyy/mm/dd')) , '89093 Talmadge Park'   , '821-450-0208' , 'estobbie2@state.tx.us');       
INSERT INTO Visitors (visitorID , firstName , lastName , birthDate , address , phoneNumber , email) VALUES (4  , 'Rebekkah' , 'Sharrocks'  , (TO_DATE('2019/08/14' , 'yyyy/mm/dd')) , '0 Transport Parkway'   , '440-498-9144' , 'rsharrocks3@psu.edu');         
INSERT INTO Visitors (visitorID , firstName , lastName , birthDate , address , phoneNumber , email) VALUES (5  , 'Elsie'    , 'Dannohl'    , (TO_DATE('2020/01/24' , 'yyyy/mm/dd')) , '6140 Anderson Avenue'  , '788-183-8308' , 'edannohl4@discuz.net');        
INSERT INTO Visitors (visitorID , firstName , lastName , birthDate , address , phoneNumber , email) VALUES (6  , 'Chaunce'  , 'Nicholas'   , (TO_DATE('2019/12/28' , 'yyyy/mm/dd')) , '70 Maywood Parkway'    , '699-172-3209' , 'cnicholas5@whitehouse.gov');   
INSERT INTO Visitors (visitorID , firstName , lastName , birthDate , address , phoneNumber , email) VALUES (7  , 'Zonda'    , 'Ruddiforth' , (TO_DATE('2018/05/21' , 'yyyy/mm/dd')) , '24094 Canary Pass'     , '724-737-3986' , 'zruddiforth6@gizmodo.com');    
INSERT INTO Visitors (visitorID , firstName , lastName , birthDate , address , phoneNumber , email) VALUES (8  , 'Edmon'    , 'Osbidston'  , (TO_DATE('2021/01/09' , 'yyyy/mm/dd')) , '83 Duke Alley'         , '792-532-8820' , 'eosbidston7@ihg.com');         
INSERT INTO Visitors (visitorID , firstName , lastName , birthDate , address , phoneNumber , email) VALUES (9  , 'Cozmo'    , 'Snowling'   , (TO_DATE('2020/01/02' , 'yyyy/mm/dd')) , '05 Summit Way'         , '337-796-3645' , 'csnowling8@freewebs.com');     
INSERT INTO Visitors (visitorID , firstName , lastName , birthDate , address , phoneNumber , email) VALUES (10 , 'Elisha'   , 'Goor'       , (TO_DATE('2018/01/15' , 'yyyy/mm/dd')) , '7909 Manitowish Court' , '298-325-3587' , 'egoor9@goodreads.com');        

-- VisitorRecords
INSERT INTO VisitorRecords (recordID , visitorID , visitDate) VALUES (1  , 1  , (TO_DATE('2018/03/25' , 'yyyy/mm/dd'))); 
INSERT INTO VisitorRecords (recordID , visitorID , visitDate) VALUES (2  , 2  , (TO_DATE('2013/06/07' , 'yyyy/mm/dd'))); 
INSERT INTO VisitorRecords (recordID , visitorID , visitDate) VALUES (3  , 3  , (TO_DATE('2020/05/18' , 'yyyy/mm/dd'))); 
INSERT INTO VisitorRecords (recordID , visitorID , visitDate) VALUES (4  , 4  , (TO_DATE('2013/08/03' , 'yyyy/mm/dd'))); 
INSERT INTO VisitorRecords (recordID , visitorID , visitDate) VALUES (5  , 5  , (TO_DATE('2010/03/23' , 'yyyy/mm/dd'))); 
INSERT INTO VisitorRecords (recordID , visitorID , visitDate) VALUES (6  , 6  , (TO_DATE('2011/08/26' , 'yyyy/mm/dd'))); 
INSERT INTO VisitorRecords (recordID , visitorID , visitDate) VALUES (7  , 7  , (TO_DATE('2002/01/04' , 'yyyy/mm/dd'))); 
INSERT INTO VisitorRecords (recordID , visitorID , visitDate) VALUES (8  , 8  , (TO_DATE('2017/11/03' , 'yyyy/mm/dd'))); 
INSERT INTO VisitorRecords (recordID , visitorID , visitDate) VALUES (9  , 9  , (TO_DATE('2012/10/09' , 'yyyy/mm/dd'))); 
INSERT INTO VisitorRecords (recordID , visitorID , visitDate) VALUES (10 , 10 , (TO_DATE('2010/09/08' , 'yyyy/mm/dd'))); 

-- Events
INSERT INTO Events (eventID , enclosureID , capacity , description , name , startTime , endTime) VALUES (1  , 1 , 42 , 'Pasngr in hv veh injured in clsn w pedl cyc nontraf, sequela' , 'McLaughlin, Schiller and Kuphal' , (TO_DATE ('2014-05-05 16:00' , 'YYYY-MM-DD HH24:MI')) , (TO_DATE ('2014-05-05 18:00' , 'YYYY-MM-DD HH24:MI'))); 
INSERT INTO Events (eventID , enclosureID , capacity , description , name , startTime , endTime) VALUES (2  , 2 , 27 , 'External constriction of right middle finger'                 , 'Luettgen LLC'                    , (TO_DATE ('2014-05-05 16:00' , 'YYYY-MM-DD HH24:MI')) , (TO_DATE ('2014-05-05 18:00' , 'YYYY-MM-DD HH24:MI'))); 
INSERT INTO Events (eventID , enclosureID , capacity , description , name , startTime , endTime) VALUES (3  , 3 , 76 , 'Puncture wound without foreign body of lower back and pelvis' , 'Grant, Swift and Block'          , (TO_DATE ('2014-05-05 16:00' , 'YYYY-MM-DD HH24:MI')) , (TO_DATE ('2014-05-05 18:00' , 'YYYY-MM-DD HH24:MI'))); 
INSERT INTO Events (eventID , enclosureID , capacity , description , name , startTime , endTime) VALUES (4  , 4 , 26 , 'Insrt gastr/duodnl sound cause abn react/compl, w/o misadvnt' , 'Beer-Sauer'                      , (TO_DATE ('2014-05-05 16:00' , 'YYYY-MM-DD HH24:MI')) , (TO_DATE ('2014-05-05 18:00' , 'YYYY-MM-DD HH24:MI'))); 
INSERT INTO Events (eventID , enclosureID , capacity , description , name , startTime , endTime) VALUES (5  , 5 , 54 , 'Other peripheral vertigo, left ear'                           , 'Berge, Denesik and Bayer'        , (TO_DATE ('2014-05-05 16:00' , 'YYYY-MM-DD HH24:MI')) , (TO_DATE ('2014-05-05 18:00' , 'YYYY-MM-DD HH24:MI'))); 
INSERT INTO Events (eventID , enclosureID , capacity , description , name , startTime , endTime) VALUES (6  , 1 , 63 , 'Athscl bypass of cor art of txplt heart w ang pctrs w spasm'  , 'Lesch-Hayes'                     , (TO_DATE ('2014-05-05 16:00' , 'YYYY-MM-DD HH24:MI')) , (TO_DATE ('2014-05-05 18:00' , 'YYYY-MM-DD HH24:MI'))); 
INSERT INTO Events (eventID , enclosureID , capacity , description , name , startTime , endTime) VALUES (7  , 2 , 94 , 'Dislocation of tarsometatarsal joint of right foot'           , 'Hessel LLC'                      , (TO_DATE ('2014-05-05 16:00' , 'YYYY-MM-DD HH24:MI')) , (TO_DATE ('2014-05-05 18:00' , 'YYYY-MM-DD HH24:MI'))); 
INSERT INTO Events (eventID , enclosureID , capacity , description , name , startTime , endTime) VALUES (8  , 3 , 28 , 'Type I occipital condyle fracture, right side, init'          , 'Smitham-Thompson'                , (TO_DATE ('2014-05-05 16:00' , 'YYYY-MM-DD HH24:MI')) , (TO_DATE ('2014-05-05 18:00' , 'YYYY-MM-DD HH24:MI'))); 
INSERT INTO Events (eventID , enclosureID , capacity , description , name , startTime , endTime) VALUES (9  , 4 , 52 , 'Subluxation of distal interphaln joint of left thumb, init'   , 'Hammes-Legros'                   , (TO_DATE ('2014-05-05 16:00' , 'YYYY-MM-DD HH24:MI')) , (TO_DATE ('2014-05-05 18:00' , 'YYYY-MM-DD HH24:MI'))); 
INSERT INTO Events (eventID , enclosureID , capacity , description , name , startTime , endTime) VALUES (10 ,5  , 53 , 'Poisoning by histamine H2-receptor blockers, assault'         , 'Waters-Mante'                    , (TO_DATE ('2014-05-05 16:00' , 'YYYY-MM-DD HH24:MI')) , (TO_DATE ('2014-05-05 18:00' , 'YYYY-MM-DD HH24:MI'))); 

-- Reserve
INSERT INTO Reserve (eventID , visitorID) VALUES (1 ,1); 
INSERT INTO Reserve (eventID , visitorID) VALUES (2 ,1); 
INSERT INTO Reserve (eventID , visitorID) VALUES (3 ,1); 
INSERT INTO Reserve (eventID , visitorID) VALUES (4 ,1); 
INSERT INTO Reserve (eventID , visitorID) VALUES (1 ,5); 

-- HostedBy
INSERT INTO HostedBy(eventID , trainerID) VALUES (1 ,6);
INSERT INTO HostedBy(eventID , trainerID) VALUES (2 ,7);
INSERT INTO HostedBy(eventID , trainerID) VALUES (3 ,8);
INSERT INTO HostedBy(eventID , trainerID) VALUES (4 ,9);
INSERT INTO HostedBy(eventID , trainerID) VALUES (1 ,10);

--ResponsibleFor
INSERT INTO ResponsibleFor(keeperID , animalID) VALUES(11 , 1); 
INSERT INTO ResponsibleFor(keeperID , animalID) VALUES(12 , 1); 
INSERT INTO ResponsibleFor(keeperID , animalID) VALUES(12 , 2);
INSERT INTO ResponsibleFor(keeperID , animalID) VALUES(12 , 3);
INSERT INTO ResponsibleFor(keeperID , animalID) VALUES(12 , 4);
INSERT INTO ResponsibleFor(keeperID , animalID) VALUES(12 , 5);
INSERT INTO ResponsibleFor(keeperID , animalID) VALUES(13 , 3); 
INSERT INTO ResponsibleFor(keeperID , animalID) VALUES(14 , 4); 
INSERT INTO ResponsibleFor(keeperID , animalID) VALUES(15 , 5); 
INSERT INTO ResponsibleFor(keeperID , animalID) VALUES(11 , 5);

--TrainedBy
INSERT INTO TrainedBy(trainerID, animalID) VALUES(6, 1);
INSERT INTO TrainedBy(trainerID, animalID) VALUES(7, 3);
INSERT INTO TrainedBy(trainerID, animalID) VALUES(8, 4);
INSERT INTO TrainedBy(trainerID, animalID) VALUES(9, 2);
INSERT INTO TrainedBy(trainerID, animalID) VALUES(10, 5);
INSERT INTO TrainedBy(trainerID, animalID) VALUES(7, 1);
INSERT INTO TrainedBy(trainerID, animalID) VALUES(7, 4);
INSERT INTO TrainedBy(trainerID, animalID) VALUES(9, 4);
INSERT INTO TrainedBy(trainerID, animalID) VALUES(10, 2);
INSERT INTO TrainedBy(trainerID, animalID) VALUES(6, 5);

--MedicalRecords
INSERT INTO MedicalRecords(notes, purpose, dateTime, animalID, vetID) 
VALUES(NULL, 'give painkillers for left leg', '21-OCT-2021', 1, 16) ;

INSERT INTO MedicalRecords(notes, purpose, dateTime, animalID, vetID)
VALUES('make sure to check up again next Thursday to see if walking is still off', 'bandage right paw due to a cut', '17-OCT-2021', 2, 17);

INSERT INTO MedicalRecords(notes, purpose, dateTime, animalID, vetID)
VALUES('Keep animal in vet quarters for another week until 13-OCT-2021', 'Clean up bite mark on upper back', '06-OCT-2021', 2, 18);

INSERT INTO MedicalRecords(notes, purpose, dateTime, animalID, vetID)
VALUES(NULL, 'cleaned up build up behind left ear', '11-OCT-2021', 4, 19);

INSERT INTO MedicalRecords(notes, purpose, dateTime, animalID, vetID)
VALUES('Make sure dose is taken twice daily: once in the morning before feeding and once after 7pm', 'Medicine prescribed for virus', '13-OCT-2021', 3, 20);

INSERT INTO MedicalRecords(notes, purpose, dateTime, animalID, vetID)
VALUES('Keep in private enclosure until walking and eating as normal again', 'bandaged a bone fracture on upper right leg', '17-OCT-2021', 3, 18);
