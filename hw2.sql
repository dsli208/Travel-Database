CREATE TABLE trip(tripId INTEGER, round_trip BOOLEAN, departure DATE, return DATE, locId INTEGER, region VARCHAR(), PRIMARY KEY(tripId), CHECK(tripId > 0 AND return >= departure));
CREATE TABLE location(visitorAmt INTEGER, locId INTEGER, region VARCHAR(), PRIMARY KEY(locId), CHECK(locId > 0));
//CREATE TABLE group(groupId INTEGER);
CREATE TABLE passenger(pasId INTEGER, age INTEGER, name VARCHAR(), PRIMARY KEY(pasId), CHECK(COUNT(*) > 0));
CREATE TABLE accommodation(bookingSource VARCHAR(), accId INTEGER, rate FLOAT, PRIMARY KEY(accId), CHECK(accId > 0 AND rate > 0));
CREATE TABLE attraction(attId INTEGER, price INTEGER, thingsToDo VARCHAR(), PRIMARY KEY(attId));
CREATE TABLE review(rating INTEGER, Id INTEGER, PRIMARY KEY(Id), CHECK(rating > 0));
CREATE TABLE payment(amount INTEGER, Id INTEGER, PRIMARY KEY (Id), CHECK(amount > 0));
