SET DEFINE OFF

DROP TABLE Cancel CASCADE CONSTRAINTS;
DROP TABLE Reserve CASCADE CONSTRAINTS;
DROP TABLE Seats CASCADE CONSTRAINTS;
DROP TABLE Airplain CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;
CREATE TABLE Customer (
        cno NUMBER PRIMARY KEY,
        name VARCHAR2(50),
        passwd VARCHAR2(50),
        email VARCHAR2(100),
        passportNumber VARCHAR2(20)
    );
CREATE TABLE Airplain (
        airline VARCHAR2(50),
        flightNo VARCHAR2(20),
        departureDateTime TIMESTAMP,
        departureAirport VARCHAR2(50),
        arrivalDateTime TIMESTAMP,
        arrivalAirport VARCHAR2(50),
        PRIMARY KEY (flightNo, departureDateTime)
    );
CREATE TABLE Seats (
        flightNo VARCHAR2(20),
        departureDateTime TIMESTAMP,
        seatClass VARCHAR2(20),
        price NUMBER,
        no_of_seats NUMBER,
        PRIMARY KEY (flightNo, departureDateTime, seatClass),
        FOREIGN KEY (flightNo, departureDateTime) REFERENCES Airplain(flightNo, departureDateTime)
    );
CREATE TABLE Reserve (
        flightNo VARCHAR2(20),
        departureDateTime TIMESTAMP,
        seatClass VARCHAR2(20),
        payment NUMBER,
        reserveDateTime TIMESTAMP,
        cno NUMBER,
        PRIMARY KEY (flightNo, departureDateTime, seatClass, cno),
        FOREIGN KEY (flightNo, departureDateTime, seatClass) REFERENCES Seats(flightNo, departureDateTime, seatClass),
        FOREIGN KEY (cno) REFERENCES Customer(cno)
    );
CREATE TABLE Cancel (
        flightNo VARCHAR2(20),
        departureDateTime TIMESTAMP,
        seatClass VARCHAR2(20),
        refund NUMBER,
        cancelDateTime TIMESTAMP,
        cno NUMBER,
        PRIMARY KEY (flightNo, departureDateTime, seatClass, cno),
        FOREIGN KEY (flightNo, departureDateTime, seatClass) REFERENCES Seats(flightNo, departureDateTime, seatClass),
        FOREIGN KEY (cno) REFERENCES Customer(cno)
    );
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1000, 'Kim Minseo', 'pw2824', 'kim.minseo@example.com', 'M46913810');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1001, 'Lee Jisoo', 'pw5012', 'lee.jisoo@example.com', 'M28728463');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1002, 'Park Jihoon', 'pw2679', 'park.jihoon@example.com', 'K83197857');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1003, 'Choi Yuna', 'pw2424', 'choi.yuna@example.com', 'K66629388');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1004, 'Jung Hoseok', 'pw1520', 'jung.hoseok@example.com', 'M22575562');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1005, 'Yoo Jaesuk', 'pw4582', 'yoo.jaesuk@example.com', 'M77827638');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1006, 'Song Hyejin', 'pw1434', 'song.hyejin@example.com', 'K36687537');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1007, 'Han Donghoon', 'pw9928', 'han.donghoon@example.com', 'P39587039');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1008, 'Jang Wonyoung', 'pw8359', 'jang.wonyoung@example.com', 'K47338124');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1009, 'Kang Daniel', 'pw1106', 'kang.daniel@example.com', 'M66722344');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1010, 'Im Nayoung', 'pw6574', 'im.nayoung@example.com', 'P30868105');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1011, 'Seo Jisoo', 'pw4527', 'seo.jisoo@example.com', 'P23718431');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1012, 'Oh Sehun', 'pw2519', 'oh.sehun@example.com', 'P22981052');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1013, 'Kim Jisoo', 'pw6881', 'kim.jisoo@example.com', 'P91030736');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1014, 'Lee Minho', 'pw5333', 'lee.minho@example.com', 'M71662963');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1015, 'Park Chaeyoung', 'pw9785', 'park.chaeyoung@example.com', 'M60806024');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1016, 'Kim Taehyung', 'pw2291', 'kim.taehyung@example.com', 'K49349722');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1017, 'Jeon Jungkook', 'pw6925', 'jeon.jungkook@example.com', 'K35808537');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1018, 'Bae Suzy', 'pw2139', 'bae.suzy@example.com', 'M98753260');
INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1019, 'Yoon Bomi', 'pw4733', 'yoon.bomi@example.com', 'P20709497');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Asiana Airlines', 'AS100', TO_TIMESTAMP('2025-07-01 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'CDG', TO_TIMESTAMP('2025-07-01 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'JFK');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Delta', 'DE101', TO_TIMESTAMP('2025-07-02 08-00-00','YYYY-MM-DD HH24-MI-SS'), 'SYD', TO_TIMESTAMP('2025-07-02 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'LAX');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Delta', 'DE102', TO_TIMESTAMP('2025-07-03 17-00-00','YYYY-MM-DD HH24-MI-SS'), 'LAX', TO_TIMESTAMP('2025-07-04 08-00-00','YYYY-MM-DD HH24-MI-SS'), 'CDG');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Asiana Airlines', 'AS103', TO_TIMESTAMP('2025-07-04 14-00-00','YYYY-MM-DD HH24-MI-SS'), 'HND', TO_TIMESTAMP('2025-07-04 22-00-00','YYYY-MM-DD HH24-MI-SS'), 'JFK');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('United', 'UN104', TO_TIMESTAMP('2025-07-05 10-00-00','YYYY-MM-DD HH24-MI-SS'), 'JFK', TO_TIMESTAMP('2025-07-06 01-00-00','YYYY-MM-DD HH24-MI-SS'), 'SYD');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Delta', 'DE105', TO_TIMESTAMP('2025-07-06 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'JFK', TO_TIMESTAMP('2025-07-06 23-00-00','YYYY-MM-DD HH24-MI-SS'), 'FRA');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Korean Air', 'KO106', TO_TIMESTAMP('2025-07-07 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'FRA', TO_TIMESTAMP('2025-07-08 04-00-00','YYYY-MM-DD HH24-MI-SS'), 'HND');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Korean Air', 'KO107', TO_TIMESTAMP('2025-07-08 09-00-00','YYYY-MM-DD HH24-MI-SS'), 'SYD', TO_TIMESTAMP('2025-07-08 23-00-00','YYYY-MM-DD HH24-MI-SS'), 'LAX');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('United', 'UN108', TO_TIMESTAMP('2025-07-09 12-00-00','YYYY-MM-DD HH24-MI-SS'), 'SIN', TO_TIMESTAMP('2025-07-10 03-00-00','YYYY-MM-DD HH24-MI-SS'), 'LAX');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Delta', 'DE109', TO_TIMESTAMP('2025-07-10 08-00-00','YYYY-MM-DD HH24-MI-SS'), 'CDG', TO_TIMESTAMP('2025-07-10 16-00-00','YYYY-MM-DD HH24-MI-SS'), 'SYD');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Lufthansa', 'LU110', TO_TIMESTAMP('2025-07-11 12-00-00','YYYY-MM-DD HH24-MI-SS'), 'FRA', TO_TIMESTAMP('2025-07-12 02-00-00','YYYY-MM-DD HH24-MI-SS'), 'HND');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Asiana Airlines', 'AS111', TO_TIMESTAMP('2025-07-12 08-00-00','YYYY-MM-DD HH24-MI-SS'), 'SIN', TO_TIMESTAMP('2025-07-12 21-00-00','YYYY-MM-DD HH24-MI-SS'), 'ICN');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Korean Air', 'KO112', TO_TIMESTAMP('2025-07-13 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'HND', TO_TIMESTAMP('2025-07-13 14-00-00','YYYY-MM-DD HH24-MI-SS'), 'FRA');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('United', 'UN113', TO_TIMESTAMP('2025-07-14 15-00-00','YYYY-MM-DD HH24-MI-SS'), 'FRA', TO_TIMESTAMP('2025-07-14 21-00-00','YYYY-MM-DD HH24-MI-SS'), 'JFK');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Lufthansa', 'LU114', TO_TIMESTAMP('2025-07-15 13-00-00','YYYY-MM-DD HH24-MI-SS'), 'CDG', TO_TIMESTAMP('2025-07-16 02-00-00','YYYY-MM-DD HH24-MI-SS'), 'SIN');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Korean Air', 'KO115', TO_TIMESTAMP('2025-07-16 16-00-00','YYYY-MM-DD HH24-MI-SS'), 'CDG', TO_TIMESTAMP('2025-07-16 22-00-00','YYYY-MM-DD HH24-MI-SS'), 'FRA');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Delta', 'DE116', TO_TIMESTAMP('2025-07-17 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'FRA', TO_TIMESTAMP('2025-07-17 16-00-00','YYYY-MM-DD HH24-MI-SS'), 'LAX');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('United', 'UN117', TO_TIMESTAMP('2025-07-18 06-00-00','YYYY-MM-DD HH24-MI-SS'), 'HND', TO_TIMESTAMP('2025-07-18 15-00-00','YYYY-MM-DD HH24-MI-SS'), 'CDG');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Korean Air', 'KO118', TO_TIMESTAMP('2025-07-19 16-00-00','YYYY-MM-DD HH24-MI-SS'), 'JFK', TO_TIMESTAMP('2025-07-20 01-00-00','YYYY-MM-DD HH24-MI-SS'), 'LAX');
INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Delta', 'DE119', TO_TIMESTAMP('2025-07-20 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'ICN', TO_TIMESTAMP('2025-07-21 01-00-00','YYYY-MM-DD HH24-MI-SS'), 'CDG');
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('AS100', TO_TIMESTAMP('2025-07-01 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 969207, 102);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('AS100', TO_TIMESTAMP('2025-07-01 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 1789807, 71);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('DE101', TO_TIMESTAMP('2025-07-02 08-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 2879667, 30);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('DE102', TO_TIMESTAMP('2025-07-03 17-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 2538391, 27);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('AS103', TO_TIMESTAMP('2025-07-04 14-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 2806043, 52);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('AS103', TO_TIMESTAMP('2025-07-04 14-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1611728, 145);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('AS103', TO_TIMESTAMP('2025-07-04 14-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 2274769, 64);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN104', TO_TIMESTAMP('2025-07-05 10-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 2173494, 105);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN104', TO_TIMESTAMP('2025-07-05 10-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 2337524, 142);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN104', TO_TIMESTAMP('2025-07-05 10-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 2393670, 40);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('DE105', TO_TIMESTAMP('2025-07-06 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 768544, 96);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO106', TO_TIMESTAMP('2025-07-07 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 2823315, 68);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO107', TO_TIMESTAMP('2025-07-08 09-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 746934, 68);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO107', TO_TIMESTAMP('2025-07-08 09-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 782697, 18);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO107', TO_TIMESTAMP('2025-07-08 09-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 1885917, 28);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN108', TO_TIMESTAMP('2025-07-09 12-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 1398574, 148);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN108', TO_TIMESTAMP('2025-07-09 12-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 1054956, 131);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN108', TO_TIMESTAMP('2025-07-09 12-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1519204, 131);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('DE109', TO_TIMESTAMP('2025-07-10 08-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 906557, 120);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('DE109', TO_TIMESTAMP('2025-07-10 08-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1986031, 118);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('LU110', TO_TIMESTAMP('2025-07-11 12-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 912794, 25);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('LU110', TO_TIMESTAMP('2025-07-11 12-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 2188716, 96);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('AS111', TO_TIMESTAMP('2025-07-12 08-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 1303587, 58);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO112', TO_TIMESTAMP('2025-07-13 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 1269604, 81);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO112', TO_TIMESTAMP('2025-07-13 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 2440402, 73);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO112', TO_TIMESTAMP('2025-07-13 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 816187, 123);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN113', TO_TIMESTAMP('2025-07-14 15-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 891172, 70);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN113', TO_TIMESTAMP('2025-07-14 15-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1197559, 114);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN113', TO_TIMESTAMP('2025-07-14 15-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 2536926, 133);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('LU114', TO_TIMESTAMP('2025-07-15 13-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 745934, 52);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO115', TO_TIMESTAMP('2025-07-16 16-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 1612342, 126);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO115', TO_TIMESTAMP('2025-07-16 16-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 1696421, 118);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('DE116', TO_TIMESTAMP('2025-07-17 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1296489, 85);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('DE116', TO_TIMESTAMP('2025-07-17 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 1413103, 24);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('DE116', TO_TIMESTAMP('2025-07-17 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 2929258, 148);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN117', TO_TIMESTAMP('2025-07-18 06-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1815353, 24);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO118', TO_TIMESTAMP('2025-07-19 16-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 2499795, 138);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('DE119', TO_TIMESTAMP('2025-07-20 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 1279406, 27);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('DE119', TO_TIMESTAMP('2025-07-20 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 2995758, 27);
INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('DE119', TO_TIMESTAMP('2025-07-20 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 1486516, 113);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('AS103', TO_TIMESTAMP('2025-07-04 14-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 1016351, TO_TIMESTAMP('2025-06-11 14-00-00','YYYY-MM-DD HH24-MI-SS'), 1000);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('DE119', TO_TIMESTAMP('2025-07-20 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 1798937, TO_TIMESTAMP('2025-07-13 18-00-00','YYYY-MM-DD HH24-MI-SS'), 1001);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('UN113', TO_TIMESTAMP('2025-07-14 15-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 1724049, TO_TIMESTAMP('2025-06-21 15-00-00','YYYY-MM-DD HH24-MI-SS'), 1002);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('DE116', TO_TIMESTAMP('2025-07-17 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 2460221, TO_TIMESTAMP('2025-07-04 07-00-00','YYYY-MM-DD HH24-MI-SS'), 1003);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('KO106', TO_TIMESTAMP('2025-07-07 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1000560, TO_TIMESTAMP('2025-06-24 18-00-00','YYYY-MM-DD HH24-MI-SS'), 1004);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('KO112', TO_TIMESTAMP('2025-07-13 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 1908636, TO_TIMESTAMP('2025-06-18 07-00-00','YYYY-MM-DD HH24-MI-SS'), 1005);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('DE109', TO_TIMESTAMP('2025-07-10 08-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1163071, TO_TIMESTAMP('2025-07-03 08-00-00','YYYY-MM-DD HH24-MI-SS'), 1006);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('AS100', TO_TIMESTAMP('2025-07-01 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 1802665, TO_TIMESTAMP('2025-06-08 07-00-00','YYYY-MM-DD HH24-MI-SS'), 1007);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('AS103', TO_TIMESTAMP('2025-07-04 14-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 1627501, TO_TIMESTAMP('2025-06-23 14-00-00','YYYY-MM-DD HH24-MI-SS'), 1008);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('DE116', TO_TIMESTAMP('2025-07-17 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 777781, TO_TIMESTAMP('2025-07-01 07-00-00','YYYY-MM-DD HH24-MI-SS'), 1009);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('DE102', TO_TIMESTAMP('2025-07-03 17-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1274954, TO_TIMESTAMP('2025-06-19 17-00-00','YYYY-MM-DD HH24-MI-SS'), 1010);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('DE105', TO_TIMESTAMP('2025-07-06 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 2248489, TO_TIMESTAMP('2025-06-14 18-00-00','YYYY-MM-DD HH24-MI-SS'), 1011);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('DE109', TO_TIMESTAMP('2025-07-10 08-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 1900610, TO_TIMESTAMP('2025-06-18 08-00-00','YYYY-MM-DD HH24-MI-SS'), 1012);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('DE109', TO_TIMESTAMP('2025-07-10 08-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 2469078, TO_TIMESTAMP('2025-07-01 08-00-00','YYYY-MM-DD HH24-MI-SS'), 1013);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('UN108', TO_TIMESTAMP('2025-07-09 12-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 2365862, TO_TIMESTAMP('2025-07-01 12-00-00','YYYY-MM-DD HH24-MI-SS'), 1014);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('UN117', TO_TIMESTAMP('2025-07-18 06-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1071155, TO_TIMESTAMP('2025-07-04 06-00-00','YYYY-MM-DD HH24-MI-SS'), 1015);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('DE119', TO_TIMESTAMP('2025-07-20 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 2004941, TO_TIMESTAMP('2025-07-05 18-00-00','YYYY-MM-DD HH24-MI-SS'), 1016);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('KO106', TO_TIMESTAMP('2025-07-07 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1559919, TO_TIMESTAMP('2025-06-17 18-00-00','YYYY-MM-DD HH24-MI-SS'), 1017);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('UN108', TO_TIMESTAMP('2025-07-09 12-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 693563, TO_TIMESTAMP('2025-06-14 12-00-00','YYYY-MM-DD HH24-MI-SS'), 1018);
INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('UN113', TO_TIMESTAMP('2025-07-14 15-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 592456, TO_TIMESTAMP('2025-07-09 15-00-00','YYYY-MM-DD HH24-MI-SS'), 1019);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('LU110', TO_TIMESTAMP('2025-07-11 12-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 1636123, TO_TIMESTAMP('2025-07-06 12-00-00','YYYY-MM-DD HH24-MI-SS'), 1000);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('DE105', TO_TIMESTAMP('2025-07-06 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 1456957, TO_TIMESTAMP('2025-06-29 18-00-00','YYYY-MM-DD HH24-MI-SS'), 1001);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('UN117', TO_TIMESTAMP('2025-07-18 06-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 534616, TO_TIMESTAMP('2025-07-16 06-00-00','YYYY-MM-DD HH24-MI-SS'), 1002);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('UN104', TO_TIMESTAMP('2025-07-05 10-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 375556, TO_TIMESTAMP('2025-06-29 10-00-00','YYYY-MM-DD HH24-MI-SS'), 1003);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('KO118', TO_TIMESTAMP('2025-07-19 16-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1201328, TO_TIMESTAMP('2025-07-16 16-00-00','YYYY-MM-DD HH24-MI-SS'), 1004);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('DE101', TO_TIMESTAMP('2025-07-02 08-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 1064729, TO_TIMESTAMP('2025-07-01 08-00-00','YYYY-MM-DD HH24-MI-SS'), 1005);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('AS111', TO_TIMESTAMP('2025-07-12 08-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 1730397, TO_TIMESTAMP('2025-07-08 08-00-00','YYYY-MM-DD HH24-MI-SS'), 1006);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('AS103', TO_TIMESTAMP('2025-07-04 14-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1936022, TO_TIMESTAMP('2025-06-25 14-00-00','YYYY-MM-DD HH24-MI-SS'), 1007);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('UN113', TO_TIMESTAMP('2025-07-14 15-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 1871768, TO_TIMESTAMP('2025-07-11 15-00-00','YYYY-MM-DD HH24-MI-SS'), 1008);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('KO107', TO_TIMESTAMP('2025-07-08 09-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 1977484, TO_TIMESTAMP('2025-07-05 09-00-00','YYYY-MM-DD HH24-MI-SS'), 1009);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('UN113', TO_TIMESTAMP('2025-07-14 15-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 676146, TO_TIMESTAMP('2025-07-08 15-00-00','YYYY-MM-DD HH24-MI-SS'), 1010);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('UN113', TO_TIMESTAMP('2025-07-14 15-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 1841527, TO_TIMESTAMP('2025-07-10 15-00-00','YYYY-MM-DD HH24-MI-SS'), 1011);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('UN108', TO_TIMESTAMP('2025-07-09 12-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 1951244, TO_TIMESTAMP('2025-07-07 12-00-00','YYYY-MM-DD HH24-MI-SS'), 1012);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('KO112', TO_TIMESTAMP('2025-07-13 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 1287108, TO_TIMESTAMP('2025-07-09 07-00-00','YYYY-MM-DD HH24-MI-SS'), 1013);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('KO106', TO_TIMESTAMP('2025-07-07 18-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1033286, TO_TIMESTAMP('2025-07-02 18-00-00','YYYY-MM-DD HH24-MI-SS'), 1014);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('KO107', TO_TIMESTAMP('2025-07-08 09-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 349627, TO_TIMESTAMP('2025-07-04 09-00-00','YYYY-MM-DD HH24-MI-SS'), 1015);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('KO112', TO_TIMESTAMP('2025-07-13 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'Economy', 884272, TO_TIMESTAMP('2025-07-11 07-00-00','YYYY-MM-DD HH24-MI-SS'), 1016);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('UN108', TO_TIMESTAMP('2025-07-09 12-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 1645284, TO_TIMESTAMP('2025-06-30 12-00-00','YYYY-MM-DD HH24-MI-SS'), 1017);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('KO112', TO_TIMESTAMP('2025-07-13 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'First', 1424525, TO_TIMESTAMP('2025-07-07 07-00-00','YYYY-MM-DD HH24-MI-SS'), 1018);
INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('AS100', TO_TIMESTAMP('2025-07-01 07-00-00','YYYY-MM-DD HH24-MI-SS'), 'Business', 847807, TO_TIMESTAMP('2025-06-28 07-00-00','YYYY-MM-DD HH24-MI-SS'), 1019);