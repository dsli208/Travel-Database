CREATE DATABASE travel_agency
go


CREATE TABLE user (
       username VARCHAR(40),
       email VARCHAR(35) NOT NULL,
       password VARCHAR(20) NOT NULL,
       PRIMARY KEY (email)
       );

CREATE TABLE review (
       numStars INT NOT NULL,
       detailedReview VARCHAR(1000),
       submissionDate DATETIME, --optional: timestamp
       author VARCHAR(35) NOT NULL, --optional: display author name (but don't actually associate with user table using a foreign key)
       PRIMARY KEY (id),
       CHECK (numStars >= 1 AND numStars <= 5) --I guess this could be removed too if we only ever insert a value in range [1,5]
       );

CREATE TABLE location (
       city VARCHAR(30) NOT NULL,
       region VARCHAR(2),
       image VARCHAR(200)
       );

CREATE TABLE flight (
       companyName VARCHAR(30) NOT NULL,
       sourceLocation VARCHAR(30) NOT NULL,
       destinationLocation VARCHAR(30) NOT NULL,
       departureDate DATE NOT NULL,
       departureTime TIME NOT NULL,
       fareEconomy DECIMAL(6,2) NOT NULL,
       fareBusiness DECIMAL(6,2) NOT NULL,
       fareFirst DECIMAL(6,2) NOT NULL,
       numSeatsRemainingEconomy INT NOT NULL,
       numSeatsRemainingBusiness INT NOT NULL,
       numSeatsRemainingFirst INT NOT NULL
       );

CREATE TABLE train (
       companyName VARCHAR(30) NOT NULL,
       sourceLocation VARCHAR(30) NOT NULL,
       destinationLocation VARCHAR(30) NOT NULL,
       departureDate DATE NOT NULL,
       departureTime TIME NOT NULL,
       fareEconomy DECIMAL(6,2) NOT NULL,
       fareBusiness DECIMAL(6,2) NOT NULL,
       fareFirst DECIMAL(6,2) NOT NULL,
       numSeatsRemainingEconomy INT NOT NULL,
       numSeatsRemainingBusiness INT NOT NULL,
       numSeatsRemainingFirst INT NOT NULL
       );

CREATE TABLE hotel (
       dailyCost DECIMAL(6,2) NOT NULL,
       address VARCHAR(30),
       city VARCHAR(30)
       companyName VARCHAR(30),
       );

CREATE TABLE payment (
       amount DECIMAL(6,2) NOT NULL,
       paymentType ENUM('debit', 'credit'),
       cardNo VARCHAR(16) NOT NULL
       );

CREATE TABLE attraction (
       city VARCHAR(30) NOT NULL,
       attractionName VARCHAR(30) NOT NULL,
       attractionDescription VARCHAR(1000),
       image VARCHAR(200)
       );

CREATE TABLE history (
       userEmail VARCHAR(35),
       bookingType ENUM('flight', 'train', 'hotel'),
       bookingStartDate DATE,
       paymentAmount DECIMAL(6,2),
       paymentCardNo VARCHAR(16)
       );
