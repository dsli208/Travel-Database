CREATE DATABASE travel_agency
go


/* ENTITIES */

CREATE TABLE user (
       id INT NOT NULL AUTO_INCREMENT,
       username VARCHAR(40),
       email VARCHAR(35) NOT NULL,
       password VARCHAR(20) NOT NULL,
       PRIMARY KEY (id),
       UNIQUE (email)
       );

CREATE TABLE location (
       id INT NOT NULL AUTO_INCREMENT,
       city VARCHAR(30) NOT NULL,
       region VARCHAR(2),
       country VARCHAR(2) DEFAULT 'US',
       PRIMARY KEY (id),
       UNIQUE (city, region, country)
       );

CREATE TABLE booking (
       id INT NOT NULL AUTO_INCREMENT,
       startDate DATE NOT NULL,
       PRIMARY KEY (id)
       );       

--departureTime DATETIME NOT NULL,
--arrivalTime DATETIME NOT NULL,
CREATE TABLE transportation (
       id INT NOT NULL,
       sourceLocation INT NOT NULL,
       destinationLocation INT NOT NULL,
       fareEconomy DECIMAL(6,2) NOT NULL,
       fareBusiness DECIMAL(6,2) NOT NULL,
       fareFirst DECIMAL(6,2) NOT NULL,
       numSeatsRemainingEconomy INT NOT NULL,
       numSeatsRemainingBusiness INT NOT NULL,
       numSeatsRemainingFirst INT NOT NULL,
       FOREIGN KEY (id) REFERENCES booking(id),
       FOREIGN KEY (sourceLocation) REFERENCES location(id),
       FOREIGN KEY (destinationLocation) REFERENCES location(id),
       CHECK (departureTime < arrivalTime),
       CHECK (fare > 0)
       );

CREATE TABLE flight (
       id INT NOT NULL,
       airline VARCHAR(30) NOT NULL,
       FOREIGN KEY (id) REFERENCES transportation(id)
       );

CREATE TABLE train (
       id INT NOT NULL,
       railroad VARCHAR(30),
       FOREIGN KEY (id) REFERENCES transportation(id)
       );

--note: assumes hotel has infinite capacity
CREATE TABLE hotel (
       id INT NOT NULL,
       dailyCost DECIMAL(6,2) NOT NULL,
       address VARCHAR(30),
       location INT NOT NULL,
       FOREIGN KEY (id) REFERENCES booking(id),
       FOREIGN KEY (location) REFERENCES location(id),
       CHECK (dailyCost > 0)
       );

CREATE TABLE payment (
       id INT AUTO_INCREMENT,
       amount DECIMAL(6,2) NOT NULL,
       paymentType ENUM('debit', 'credit'),
       cardNo VARCHAR(16) NOT NULL,
       PRIMARY KEY (id),
       CHECK (amount > 0)
       );

CREATE TABLE attraction (
       id INT AUTO_INCREMENT,
       location INT NOT NULL,
       attractionName VARCHAR(30) NOT NULL,
       image1 VARCHAR(30) DEFAULT 'tmp.jpg',
       image2 VARCHAR(30) DEFAULT 'tmp.jpg',
       image3 VARCHAR(30) DEFAULT 'tmp.jpg',
       PRIMARY KEY (id),
       FOREIGN KEY (location) REFERENCES locations(id)
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

 --for transactionDate: or DATETIME --p.s. can omit if we don't display it in purchase history
CREATE TABLE purchase (
       userID INT,
       bookingID INT,
       paymentID INT,
       transactionDate DATE NOT NULL,
       PRIMARY KEY (userID, bookingID, paymentID),
       FOREIGN KEY (userID) REFERENCES user(id),
       FOREIGN KEY (bookingID) REFERENCES booking(id),
       FOREIGN KEY (paymentID) REFERENCES payment(id)
       );

/* don't need headedTo/headedFrom/locatedIn, just put location fields in transportation and hotels */

CREATE TABLE featuresAttractions (
       locationID INT,
       attractionID INT,
       PRIMARY KEY (locationID, attractionID),
       FOREIGN KEY (locationID) REFERENCES locations(id),
       FOREIGN KEY (attractionID) REFERENCES attractions(id)
       );


INSERT INTO location VALUES (1, 'nyc', 'ny', 'us');
INSERT INTO location VALUES (2, 'sf', 'ca', 'us');
INSERT INTO booking VALUES (1, '2018-05-27');
INSERT INTO transportation VALUES (1, 1, 2, 330.45, 440.23, 605.88, 40, 20, 10);
INSERT INTO flight VALUES (1, 'delta');

SELECT 
