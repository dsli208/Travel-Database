CREATE TABLE Trip(
       tripId int NOT NULL,
       round_trip boolean,
       departure DATE,
       return DATE,
       region varchar(),
       PRIMARY KEY(tripId),
       FOREIGN KEY fromLocId REFERENCES Location(locId),
       FOREIGN KEY toLocId REFERENCES Location(locId),
       CHECK(tripId > 0 AND return >= departure));

CREATE TABLE Location(
       visitorAmt int,
       locId int NOT NULL,
       region varchar(),
       PRIMARY KEY(locId),
       CHECK(locId > 0));
	  
CREATE TABLE Passenger(
       pasId int NOT NULL,
       age int NOT NULL,
       name varchar() NOT NULL,
       PRIMARY KEY(pasId),
       CHECK(COUNT(*) > 0 AND pasId > 0));

CREATE TABLE Accommodation(
       bookingSource varchar(),
       accId int NOT NULL,
       rate float,
       PRIMARY KEY(accId),
       CHECK(accId > 0 AND rate > 0));

CREATE TABLE Attraction(
       attId int,
       price int,
       thingsToDo varchar(),
       PRIMARY KEY(attId));

CREATE TABLE Review(
       rating int NOT NULL,
       pasId int FOREIGN KEY REFERENCES Passenger,
       Id INTEGER NOT NULL,
       PRIMARY KEY(Id),
       CHECK(rating > 0 AND pasId > 0),
       FOREIGN KEY pasId REFERENCES passenger(pasId));

CREATE TABLE Payment(
       amount INTEGER NOT NULL,
       pasId INTEGER FOREIGN KEY REFERENCES Passenger,
       Id INTEGER NOT NULL,
       PRIMARY KEY (Id),
       FOREIGN KEY pasId REFERENCES location(pasId),
       CHECK(amount > 0 AND pasId > 0));

