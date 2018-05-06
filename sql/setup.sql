CREATE DATABASE travel_agency
go


/* ENTITIES */

CREATE TABLE users (
       id INT AUTO_INCREMENT, --is NOT NULL necessary? todo: add just in case
       username VARCHAR(40),
       email VARCHAR(35) NOT NULL,
       password VARCHAR(20) NOT NULL,
       PRIMARY KEY (id),
       UNIQUE (email)
       );

--todo: why do I even have this table (below)
CREATE TABLE bookings (
       id INT AUTO_INCREMENT,
       startDate DATE NOT NULL,
       endDate DATE,			--null for one-way transportation
       PRIMARY KEY (id)
       );

CREATE TABLE transportation (
       id INT AUTO_INCREMENT,
       fare DOUBLE NOT NULL,
       sourceLocation INT NOT NULL,
       destinationLocation INT NOT NULL,
       --departureTime DATETIME NOT NULL, --ONLY FOR CHAINED..?? figure out later
       --arrivalTime DATETIME NOT NULL,
       PRIMARY KEY (id),
       FOREIGN KEY (sourceLocation) references locations(id),
       FOREIGN KEY (destinationLocation) references locations(id),
       CHECK (departureTime < arrivalTime),	--TODO not sure if this is correct
       CHECK (fare > 0)
       );

/* NOTE: if we have 3 travel classes, does that mean each flight has 3 entries in the table? one for each class? is there a better way to do this? */
CREATE TABLE flights (		--subentity of transportation
       id INT NOT NULL,		--not sure the NOT NULL is necessary here; will figure out later, but shouldn't hurt regardless
       airline VARCHAR(30) NOT NULL,
       --flightClass ENUM('economy', 'business', 'first'),
       numSeatsRemainingEconomy INT NOT NULL,
       numSeatsRemainingBusiness INT NOT NULL,
       numSeatsRemainingFirst INT NOT NULL,
       FOREIGN KEY (id) REFERENCES transportation(id)
       );

CREATE TABLE trains (		--subentity of transportation
       id INT NOT NULL,		--same as above^
       railroad VARCHAR(30),
       --trainClass ENUM('coach', 'business', 'first'),	--see above^
       numSeatsRemainingCoach INT NOT NULL,
       numSeatsRemainingBusiness INT NOT NULL,
       numSeatsRemainingFirst INT NOT NULL,
      FOREIGN KEY (id) REFERENCES transportation(id)
       );

CREATE TABLE hotels (
       id INT AUTO_INCREMENT,
       dailyCost DOUBLE NOT NULL,
       address VARCHAR(30),	--street address only
       location INT NOT NULL,
       PRIMARY KEY (id),
       FOREIGN KEY (location) REFERENCES locations(id),
       CHECK (dailyCost > 0)
       --todo: remove assumption of infinite capacity / # of rooms..?
       );

CREATE TABLE locations (
       id INT AUTO_INCREMENT,
       city VARCHAR(30) NOT NULL,
       region VARCHAR(2),		--use standard region abbrevs.
       country VARCHAR(2) DEFAULT 'US',	--use standard country abbrevs.
       PRIMARY KEY (id),
       UNIQUE (city, region, country)
       );

CREATE TABLE attractions (
       id INT AUTO_INCREMENT,
       location INT NOT NULL, --might not be necessary given the 'featuresAttraction' relationship, but if we scrap that table this will suffice for queries (it's more of an efficiency thing than a necessity to have the separate table)
       attractionName VARCHAR(30) NOT NULL,
       image1 VARCHAR(30) DEFAULT 'tmp.jpg',	--we'll need a folder of images
       image2 VARCHAR(30) DEFAULT 'tmp.jpg',
       image3 VARCHAR(30) DEFAULT 'tmp.jpg',
       PRIMARY KEY (id),
       FOREIGN KEY (location) REFERENCES locations(id)
       );
       
CREATE TABLE payments (
       id INT AUTO_INCREMENT,
       amount DOUBLE NOT NULL,	--TODO: somehow make sure this is sum of travel+hotel costs + "service fee" for using our travel site (incentive: save money by booking a package of things)
       paymentType ENUM('debit', 'credit', 'cash', 'check'),
       --todo: add transactionDate here? instead of as an attribute of the 'books' relationship?
       PRIMARY KEY (id),
       CHECK (amount > 0)
       );

CREATE TABLE reviews (
       id INT AUTO_INCREMENT,
       numStars INT NOT NULL,
       text VARCHAR(1000),
       author INT NOT NULL,
       PRIMARY KEY (id),
       FOREIGN KEY (author) REFERENCES users(id),
       CHECK (numStars >= 1 AND numStars <= 5)
       );



/* RELATIONSHIPS */

/* don't need writesReview, just put an author field in reviews */

CREATE TABLE books (
       userID INT,
       bookingID INT,
       transactionDate DATETIME NOT NULL, --todo: move this to payment??
       PRIMARY KEY (userID, bookingID),
       FOREIGN KEY (userID) REFERENCES users(id),
       FOREIGN KEY (bookingID) REFERENCES bookings(id)
       );

CREATE TABLE requiresPayment (	--todo: lol rename this probably..
       bookingID INT,
       paymentID INT,
       PRIMARY KEY (bookingID, paymentID),
       FOREIGN KEY (bookingID) REFERENCES bookings(id),
       FOREIGN KEY (paymentID) REFERENCES payments(id)
       );

/* don't need headedTo/headedFrom/locatedIn, just put location fields in transportation and hotels */

CREATE TABLE featuresAttractions (
       locationID INT,
       attractionID INT,
       PRIMARY KEY (locationID, attractionID),
       FOREIGN KEY (locationID) REFERENCES locations(id),
       FOREIGN KEY (attractionID) REFERENCES attractions(id)
       );
