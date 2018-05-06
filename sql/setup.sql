CREATE DATABASE travel_agency
go


/* ENTITIES */

CREATE TABLE user (
       username VARCHAR(40),
       email VARCHAR(35) NOT NULL,
       password VARCHAR(20) NOT NULL,
       PRIMARY KEY (email)
       );

CREATE TABLE location (
       id INT NOT NULL AUTO_INCREMENT,
       city VARCHAR(30) NOT NULL,
       region VARCHAR(2),
       country VARCHAR(2) DEFAULT 'US',
       image VARCHAR(200) DEFAULT 'tmp.jpg',
       PRIMARY KEY (id),
       UNIQUE (city, region, country)
       );

CREATE TABLE booking (
       id INT NOT NULL AUTO_INCREMENT,
       startDate DATE NOT NULL,
       PRIMARY KEY (id)
       );       

# transportation to location: many to one
# transportation to booking: one to one
CREATE TABLE transportation (
       id INT NOT NULL,
       sourceLocation INT NOT NULL,
       destinationLocation INT NOT NULL,
       startDate DATE NOT NULL,
       departureTime TIME NOT NULL,
       fareEconomy DECIMAL(6,2) NOT NULL,
       fareBusiness DECIMAL(6,2) NOT NULL,
       fareFirst DECIMAL(6,2) NOT NULL,
       numSeatsRemainingEconomy INT NOT NULL,
       numSeatsRemainingBusiness INT NOT NULL,
       numSeatsRemainingFirst INT NOT NULL,
       FOREIGN KEY (id) REFERENCES booking(id),
       FOREIGN KEY (sourceLocation) REFERENCES location(id),
       FOREIGN KEY (destinationLocation) REFERENCES location(id),
       CHECK (fare > 0)
       );

# flight to transportation: one to one
CREATE TABLE flight (
       id INT NOT NULL,
       airline VARCHAR(30) NOT NULL,
       FOREIGN KEY (id) REFERENCES transportation(id)
       );

# train to transportation: one to one
CREATE TABLE train (
       id INT NOT NULL,
       railroad VARCHAR(30),
       FOREIGN KEY (id) REFERENCES transportation(id)
       );

# flight to location: many to one
# flight to booking: one to one
CREATE TABLE hotel (
       id INT NOT NULL,
       startDate DATE NOT NULL,
       dailyCost DECIMAL(6,2) NOT NULL,
       address VARCHAR(30),
       location INT NOT NULL,
       FOREIGN KEY (id) REFERENCES booking(id),
       FOREIGN KEY (location) REFERENCES location(id),
       CHECK (dailyCost > 0)
       );

CREATE TABLE payment (
       id INT NOT NULL AUTO_INCREMENT,
       amount DECIMAL(6,2) NOT NULL,
       paymentType ENUM('debit', 'credit'),
       cardNo VARCHAR(16) NOT NULL,
       PRIMARY KEY (id),
       CHECK (amount > 0)
       );

# attractions to location: one to one
CREATE TABLE attractions (
       id INT NOT NULL AUTO_INCREMENT,
       location INT NOT NULL,
       attractionName VARCHAR(30) NOT NULL,
       attractionDescription VARCHAR(1000),
       image VARCHAR(200) DEFAULT 'tmp.jpg',
       PRIMARY KEY (id),
       FOREIGN KEY (location) REFERENCES location(id)
       );

/*
CREATE TABLE reviews (
       id INT AUTO_INCREMENT,
       numStars INT NOT NULL,
       text VARCHAR(1000),
       author INT NOT NULL,
       PRIMARY KEY (id),
       FOREIGN KEY (author) REFERENCES users(id),
       CHECK (numStars >= 1 AND numStars <= 5)
       );
*/




/* RELATIONSHIPS */

# purchase to user: many to one
# purchase to booking: one to one
# purchase to payment: one to one

 --for transactionDate: or DATETIME --p.s. can omit if we don't display it in purchase history
CREATE TABLE purchase (
       userID VARCHAR(35),
       bookingID INT,
       paymentID INT,
       PRIMARY KEY (userID, bookingID, paymentID),
       FOREIGN KEY (userID) REFERENCES user(email),
       FOREIGN KEY (bookingID) REFERENCES booking(id),
       FOREIGN KEY (paymentID) REFERENCES payment(id)
       );



/* SAMPLE QUERY THINGS */

INSERT INTO location VALUES (1, 'nyc', 'ny', 'us', 't.jpg');
INSERT INTO location VALUES (2, 'sf', 'ca', 'us', 't.jpg');
INSERT INTO booking VALUES (1, '2018-05-27');
INSERT INTO transportation VALUES (1, 1, 2, '2018-05-27', '21:00:00', 330.45, 440.23, 605.88, 40, 20, 10);
INSERT INTO flight VALUES (1, 'delta');

SELECT id FROM location WHERE city = 'city1' AND state = '..'; --assign the result, which is an INT, to a variable to this as src
SELECT id FROM location WHERE city = 'city2' AND state = '..'; --assign as dest
--if class = economy: (in the front-end dropdown)
SELECT id, fareEconomy, departureTime FROM transportation WHERE sourceLocation = src[INT] AND destinationLocation = dest[INT] AND startDate = 'yyyy-mm-dd' AND numSeatsRemainingEconomy > 0; --assign the result for id, which is another INT, to a variable flightID (or whatever) // display fareEconomy and departureTime on "cards" on website
SELECT airline FROM flight WHERE id=flightID[INT] --also display the airlines on the "cards"
