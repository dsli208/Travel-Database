CREATE TABLE trip(round_trip BOOLEAN, departure DATE, return DATE, locId INTEGER, region VARCHAR());
CREATE TABLE location(visitorAmt INTEGER, locId INTEGER, region VARCHAR());
CREATE TABLE group(groupId INTEGER);
CREATE TABLE passenger(pasId INTEGER, age INTEGER, name VARCHAR());
CREATE TABLE accommodation(bookingSource VARCHAR(), accId INTEGER, rate FLOAT);
CREATE TABLE attraction(price INTEGER, thingsToDo VARCHAR());
CREATE TABLE review();
CREATE TABLE payment();
