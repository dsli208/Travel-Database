CREATE DATABASE travel_agency
go


/* ENTITIES */


CREATE TABLE users (
       userID VARCHAR(30),	--user-determined
       firstName VARCHAR(20),
       lastName VARCHAR(20),
       age INTEGER DEFAULT -1,	--since 0 is a valid age, although I don't know what baby would make a user account
       email VARCHAR(35),
       phone VARCHAR(10),	--remove formatting
       PRIMARY KEY (userID),
       UNIQUE (email)
       );

CREATE TABLE bookings (
       bookingID VARCHAR(30),	--automatically generated (same for all subsequent IDs)
       numTravelers INTEGER DEFAULT 1,
       PRIMARY KEY (bookingID)
       );

CREATE TABLE locations (
       locationID VARCHAR(30),
       city VARCHAR(30),
       region VARCHAR(2),		--use standard region abbrevs.
       country VARCHAR(2) DEFAULT 'US',	--use standard country abbrevs.
       PRIMARY KEY (locationID),
       UNIQUE (city, region, country)
       );

CREATE TABLE accommodations (
       accommodationID VARCHAR(30),
       dailyCost INTEGER,
       address VARCHAR(30),	--street address only (an accommodation is 'locatedIn' a location with city/state/country attrs.)
       PRIMARY KEY (accommodationID)
       );

CREATE TABLE airbrb (
       ID VARCHAR(30),
       FOREIGN KEY (ID) REFERENCES accommodations (accommodationID)
       );

CREATE TABLE apartment (
       ID VARCHAR(30),
       numRooms INT,
       kitchen BIT,	--0 if no kitchen, 1 if kitchen, NULL if unknown
       FOREIGN KEY (ID) REFERENCES accommodations (accommodationID)
       );

CREATE TABLE hotel (
       ID VARCHAR(30),
       numBeds INT,
       company VARCHAR(30),
       FOREIGN KEY (ID) REFERENCES accommodations (accommodationID),
       );

CREATE TABLE hostel (
       ID VARCHAR(30),
       FOREIGN KEY (ID) REFERENCES accommodations (accommodationID)
       );

CREATE TABLE transportation (
       transportID VARCHAR(30),
       ticketCost INTEGER,
       PRIMARY KEY (transportID)
       );

CREATE TABLE bus (
       ID VARCHAR(30),
       busLine VARCHAR(30),
       FOREIGN KEY (ID) REFERENCES transportation (transportID)
       );

CREATE TABLE cruise (
       ID VARCHAR(30),
       cruiseLine VARCHAR(30),
       FOREIGN KEY (ID) REFERENCES transportation (transportID)
       );

CREATE TABLE train (
       ID VARCHAR(30),
       railroad VARCHAR(30),
       FOREIGN KEY (ID) REFERENCES transportation (transportID)
       );

CREATE TABLE carRental (
       ID VARCHAR(30),
       rentalCompany VARCHAR(30),
       licensePlate VARCHAR(10),
       carSize ENUM('compact', 'mid', 'full', 'luxury'),	--user provides a preferred car size (we won't provide an option of make and model); we match their size preference with available cars from the rental company's database
       FOREIGN KEY (ID) REFERENCES transportation (transportID),
       UNIQUE (licensePlate)
       );

CREATE TABLE flight (
       ID VARCHAR(30),
       airline VARCHAR(30),
       travelClass ENUM('economy', 'business', 'first'),
       FOREIGN KEY (ID) REFERENCES transportation (transportID)
       );

CREATE TABLE payments (
       paymentID VARCHAR(30),
       amount INTEGER,
       paymentType ENUM('debit', 'credit', 'cash', 'check'),
       PRIMARY KEY (paymentID)
       );

CREATE TABLE reviews (
       reviewID VARCHAR(30),
       numStars INTEGER,
       text VARCHAR(1000),
       PRIMARY KEY (reviewID),
       CHECK (numStars >= 1 AND numStars <= 5)
       );


/* RELATIONS */


CREATE TABLE makesReservation (
       userID VARCHAR(30),
       bookingID VARCHAR(30),
       PRIMARY KEY (userID, bookingID),
       FOREIGN KEY (userID) REFERENCES users (userID),
       FOREIGN KEY (bookingID) REFERENCES bookings (bookingID)
       );

CREATE TABLE travels (
       bookingID VARCHAR(30),
       transportID VARCHAR(30),
       sourceID VARCHAR(30),
       destinationID VARCHAR(30),
       departure DATE,
       arrival DATE,
       PRIMARY KEY (bookingID, transportID, sourceID, destinationID),
       FOREIGN KEY (bookingID) REFERENCES bookings (bookingID),
       FOREIGN KEY (transportID) REFERENCES transportation (transportID),
       FOREIGN KEY (sourceID) REFERENCES locations (locationID),
       FOREIGN KEY (destinationID) REFERENCES locations (locationID)
       );

CREATE TABLE writes (
       userID VARCHAR(30),
       reviewID VARCHAR(30),
       PRIMARY KEY (userID, reviewID),
       FOREIGN KEY (userID) REFERENCES users (userID),
       FOREIGN KEY (reviewID) REFERENCES reviews (reviewID)
       );

CREATE TABLE pays (
       userID VARCHAR(30),
       paymentID VARCHAR(30),
       PRIMARY KEY (userID, paymentID),
       FOREIGN KEY (userID) REFERENCES users (userID),
       FOREIGN KEY (payentID) REFERENCES payments (paymentID)
       );

CREATE TABLE staysAt (
       bookingID VARCHAR(30),
       accommodationID VARCHAR(30),
       PRIMARY KEY (bookingID, accommodationID),
       FOREIGN KEY (bookingID) REFERENCES bookings (bookingID),
       FOREIGN KEY (accommodationID) REFERENCES accommodations (accommodationID)
       );

CREATE TABLE locatedIn (
       accommodationID VARCHAR(30),
       locationID VARCHAR(30),
       PRIMARY KEY (accommodationID, locationID),
       FOREIGN KEY (accommodationID) REFERENCES accommodationss (accommodationID),
       FOREIGN KEY (locationID) REFERENCES locations (locationID)
       );
