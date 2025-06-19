DROP TABLE Cancel CASCADE CONSTRAINTS;

DROP TABLE Reserve CASCADE CONSTRAINTS;

DROP TABLE Seats CASCADE CONSTRAINTS;

DROP TABLE Airplain CASCADE CONSTRAINTS;

DROP TABLE Customer CASCADE CONSTRAINTS;

CREATE TABLE Customer (
        cno             NUMBER PRIMARY KEY,
        name            VARCHAR2(50),
        passwd          VARCHAR2(50),
        email           VARCHAR2(100),
        passportNumber  VARCHAR2(20)
    );

CREATE TABLE Airplain (
        airline             VARCHAR2(50),
        flightNo            VARCHAR2(20),
        departureDateTime   TIMESTAMP,
        departureAirport    VARCHAR2(50),
        arrivalDateTime     TIMESTAMP,
        arrivalAirport      VARCHAR2(50),
        PRIMARY KEY (flightNo, departureDateTime)
    );

CREATE TABLE Seats (
        flightNo            VARCHAR2(20),
        departureDateTime   TIMESTAMP,
        seatClass           VARCHAR2(20),
        price               NUMBER,
        no_of_seats         NUMBER,
        PRIMARY KEY (flightNo, departureDateTime, seatClass),
        FOREIGN KEY (flightNo, departureDateTime)
            REFERENCES Airplain(flightNo, departureDateTime)
    );

CREATE TABLE Reserve (
        flightNo            VARCHAR2(20),
        departureDateTime   TIMESTAMP,
        seatClass           VARCHAR2(20),
        payment             NUMBER,
        reserveDateTime     TIMESTAMP,
        cno                 NUMBER,
        PRIMARY KEY (flightNo, departureDateTime, seatClass, cno),
        FOREIGN KEY (flightNo, departureDateTime, seatClass)
            REFERENCES Seats(flightNo, departureDateTime, seatClass),
        FOREIGN KEY (cno)
            REFERENCES Customer(cno)
    );

CREATE TABLE Cancel (
        flightNo            VARCHAR2(20),
        departureDateTime   TIMESTAMP,
        seatClass           VARCHAR2(20),
        refund              NUMBER,
        cancelDateTime      TIMESTAMP,
        cno                 NUMBER,
        PRIMARY KEY (flightNo, departureDateTime, seatClass, cno),
        FOREIGN KEY (flightNo, departureDateTime, seatClass)
            REFERENCES Seats(flightNo, departureDateTime, seatClass),
        FOREIGN KEY (cno)
            REFERENCES Customer(cno)
    );

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1000, 'Kim Minseo', 'pw8029', 'kim.minseo@example.com', 'M16742841');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1001, 'Lee Jisoo', 'pw6487', 'lee.jisoo@example.com', 'P85344254');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1002, 'Park Jihoon', 'pw3006', 'park.jihoon@example.com', 'P80284076');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1003, 'Choi Yuna', 'pw9164', 'choi.yuna@example.com', 'K81272092');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1004, 'Jung Hoseok', 'pw4808', 'jung.hoseok@example.com', 'K75104453');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1005, 'Yoo Jaesuk', 'pw4567', 'yoo.jaesuk@example.com', 'K77289461');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1006, 'Song Hyejin', 'pw2338', 'song.hyejin@example.com', 'P88685786');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1007, 'Han Donghoon', 'pw4286', 'han.donghoon@example.com', 'P35136527');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1008, 'Jang Wonyoung', 'pw1730', 'jang.wonyoung@example.com', 'K76682233');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1009, 'Kang Daniel', 'pw1227', 'kang.daniel@example.com', 'M10307975');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1010, 'Im Nayoung', 'pw3113', 'im.nayoung@example.com', 'P22011618');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1011, 'Seo Jisoo', 'pw2954', 'seo.jisoo@example.com', 'P65095139');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1012, 'Oh Sehun', 'pw8892', 'oh.sehun@example.com', 'P19607129');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1013, 'Kim Jisoo', 'pw3961', 'kim.jisoo@example.com', 'M59987822');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1014, 'Lee Minho', 'pw5950', 'lee.minho@example.com', 'M97846202');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1015, 'Park Chaeyoung', 'pw1047', 'park.chaeyoung@example.com', 'K71944570');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1016, 'Kim Taehyung', 'pw9440', 'kim.taehyung@example.com', 'K95933026');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1017, 'Jeon Jungkook', 'pw9065', 'jeon.jungkook@example.com', 'K64319636');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1018, 'Bae Suzy', 'pw3063', 'bae.suzy@example.com', 'M11380564');

INSERT INTO Customer (cno, name, passwd, email, passportNumber) VALUES (1019, 'Yoon Bomi', 'pw2524', 'yoon.bomi@example.com', 'M47340404');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Korean Air', 'KO100', TO_TIMESTAMP('2025-07-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'SIN', TO_TIMESTAMP('2025-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'LAX');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('United', 'UN101', TO_TIMESTAMP('2025-07-02 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'SYD', TO_TIMESTAMP('2025-07-02 23:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'ICN');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Asiana Airlines', 'AS102', TO_TIMESTAMP('2025-07-03 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'LAX', TO_TIMESTAMP('2025-07-04 05:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'FRA');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Asiana Airlines', 'AS103', TO_TIMESTAMP('2025-07-04 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CDG', TO_TIMESTAMP('2025-07-04 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'LAX');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Lufthansa', 'LU104', TO_TIMESTAMP('2025-07-05 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'SIN', TO_TIMESTAMP('2025-07-05 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'SYD');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Korean Air', 'KO105', TO_TIMESTAMP('2025-07-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'JFK', TO_TIMESTAMP('2025-07-06 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'FRA');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Lufthansa', 'LU106', TO_TIMESTAMP('2025-07-07 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'HND', TO_TIMESTAMP('2025-07-07 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'LAX');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('United', 'UN107', TO_TIMESTAMP('2025-07-08 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'JFK', TO_TIMESTAMP('2025-07-08 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'HND');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('United', 'UN108', TO_TIMESTAMP('2025-07-09 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CDG', TO_TIMESTAMP('2025-07-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'HND');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Korean Air', 'KO109', TO_TIMESTAMP('2025-07-10 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'SYD', TO_TIMESTAMP('2025-07-10 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CDG');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Delta', 'DE110', TO_TIMESTAMP('2025-07-11 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'SYD', TO_TIMESTAMP('2025-07-11 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'HND');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Korean Air', 'KO111', TO_TIMESTAMP('2025-07-12 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'SIN', TO_TIMESTAMP('2025-07-12 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'FRA');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Korean Air', 'KO112', TO_TIMESTAMP('2025-07-13 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'SYD', TO_TIMESTAMP('2025-07-13 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CDG');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Delta', 'DE113', TO_TIMESTAMP('2025-07-14 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'SYD', TO_TIMESTAMP('2025-07-14 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'JFK');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Asiana Airlines', 'AS114', TO_TIMESTAMP('2025-07-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'SYD', TO_TIMESTAMP('2025-07-16 02:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CDG');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Asiana Airlines', 'AS115', TO_TIMESTAMP('2025-07-16 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'HND', TO_TIMESTAMP('2025-07-16 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CDG');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Lufthansa', 'LU116', TO_TIMESTAMP('2025-07-17 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'FRA', TO_TIMESTAMP('2025-07-18 03:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'LAX');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Lufthansa', 'LU117', TO_TIMESTAMP('2025-07-18 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CDG', TO_TIMESTAMP('2025-07-19 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'HND');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Asiana Airlines', 'AS118', TO_TIMESTAMP('2025-07-19 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CDG', TO_TIMESTAMP('2025-07-19 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'JFK');

INSERT INTO Airplain (airline, flightNo, departureDateTime, departureAirport, arrivalDateTime, arrivalAirport) VALUES ('Asiana Airlines', 'AS119', TO_TIMESTAMP('2025-07-20 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CDG', TO_TIMESTAMP('2025-07-20 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'FRA');

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO100', TO_TIMESTAMP('2025-07-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 1546832, 111);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN101', TO_TIMESTAMP('2025-07-02 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 2637073, 23);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN101', TO_TIMESTAMP('2025-07-02 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 1709646, 41);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('AS102', TO_TIMESTAMP('2025-07-03 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 2824758, 26);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('AS102', TO_TIMESTAMP('2025-07-03 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 2265916, 77);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('AS103', TO_TIMESTAMP('2025-07-04 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 629396, 118);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('AS103', TO_TIMESTAMP('2025-07-04 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 2133912, 104);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('AS103', TO_TIMESTAMP('2025-07-04 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 2291026, 110);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('LU104', TO_TIMESTAMP('2025-07-05 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 2898771, 139);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO105', TO_TIMESTAMP('2025-07-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 800095, 53);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('LU106', TO_TIMESTAMP('2025-07-07 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 2616901, 55);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN107', TO_TIMESTAMP('2025-07-08 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 1996416, 24);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN107', TO_TIMESTAMP('2025-07-08 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 2137209, 19);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN108', TO_TIMESTAMP('2025-07-09 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 1629680, 127);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('UN108', TO_TIMESTAMP('2025-07-09 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 2358993, 46);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO109', TO_TIMESTAMP('2025-07-10 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 1193382, 63);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO109', TO_TIMESTAMP('2025-07-10 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 1036236, 44);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('DE110', TO_TIMESTAMP('2025-07-11 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 1229384, 28);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('DE110', TO_TIMESTAMP('2025-07-11 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 2913762, 71);

INSERT INTO Seats (flightNo, departureDateTime, seatClass, price, no_of_seats) VALUES ('KO111', TO_TIMESTAMP('2025-07-12 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 822714, 107);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('AS119', TO_TIMESTAMP('2025-07-20 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 603223, TO_TIMESTAMP('2025-06-25 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1000);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('DE113', TO_TIMESTAMP('2025-07-14 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 561627, TO_TIMESTAMP('2025-06-16 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1001);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('LU104', TO_TIMESTAMP('2025-07-05 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 1172632, TO_TIMESTAMP('2025-06-25 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1002);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('DE110', TO_TIMESTAMP('2025-07-11 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 2108118, TO_TIMESTAMP('2025-07-05 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1003);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('KO109', TO_TIMESTAMP('2025-07-10 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 1627334, TO_TIMESTAMP('2025-06-29 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1004);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('DE113', TO_TIMESTAMP('2025-07-14 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 757935, TO_TIMESTAMP('2025-06-22 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1005);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('AS119', TO_TIMESTAMP('2025-07-20 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 1332939, TO_TIMESTAMP('2025-06-30 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1006);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('DE113', TO_TIMESTAMP('2025-07-14 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 2376591, TO_TIMESTAMP('2025-07-04 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1007);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('UN108', TO_TIMESTAMP('2025-07-09 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 2415257, TO_TIMESTAMP('2025-06-12 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1008);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('LU104', TO_TIMESTAMP('2025-07-05 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 929662, TO_TIMESTAMP('2025-06-16 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1009);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('LU106', TO_TIMESTAMP('2025-07-07 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 1773519, TO_TIMESTAMP('2025-06-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1010);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('AS114', TO_TIMESTAMP('2025-07-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 2151362, TO_TIMESTAMP('2025-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1011);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('AS118', TO_TIMESTAMP('2025-07-19 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 1567970, TO_TIMESTAMP('2025-07-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1012);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('LU104', TO_TIMESTAMP('2025-07-05 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 1821991, TO_TIMESTAMP('2025-06-22 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1013);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('LU117', TO_TIMESTAMP('2025-07-18 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 1540273, TO_TIMESTAMP('2025-07-13 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1014);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('UN108', TO_TIMESTAMP('2025-07-09 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 1205787, TO_TIMESTAMP('2025-06-22 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1015);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('LU116', TO_TIMESTAMP('2025-07-17 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 1241480, TO_TIMESTAMP('2025-06-22 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1016);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('UN101', TO_TIMESTAMP('2025-07-02 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 1554933, TO_TIMESTAMP('2025-06-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1017);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('LU116', TO_TIMESTAMP('2025-07-17 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 704691, TO_TIMESTAMP('2025-07-02 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1018);

INSERT INTO Reserve (flightNo, departureDateTime, seatClass, payment, reserveDateTime, cno) VALUES ('LU106', TO_TIMESTAMP('2025-07-07 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 1984449, TO_TIMESTAMP('2025-06-14 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1019);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('LU106', TO_TIMESTAMP('2025-07-07 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 1076937, TO_TIMESTAMP('2025-07-03 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1000);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('LU116', TO_TIMESTAMP('2025-07-17 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 407892, TO_TIMESTAMP('2025-07-11 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1001);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('AS115', TO_TIMESTAMP('2025-07-16 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 1431407, TO_TIMESTAMP('2025-07-02 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1002);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('UN107', TO_TIMESTAMP('2025-07-08 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 1059510, TO_TIMESTAMP('2025-06-26 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1003);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('AS119', TO_TIMESTAMP('2025-07-20 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 1555225, TO_TIMESTAMP('2025-07-12 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1004);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('LU106', TO_TIMESTAMP('2025-07-07 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 1767695, TO_TIMESTAMP('2025-06-27 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1005);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('LU106', TO_TIMESTAMP('2025-07-07 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 991925, TO_TIMESTAMP('2025-06-29 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1006);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('LU104', TO_TIMESTAMP('2025-07-05 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 1399199, TO_TIMESTAMP('2025-07-04 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1007);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('AS118', TO_TIMESTAMP('2025-07-19 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 1196156, TO_TIMESTAMP('2025-07-14 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1008);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('AS103', TO_TIMESTAMP('2025-07-04 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 1447924, TO_TIMESTAMP('2025-06-24 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1009);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('AS118', TO_TIMESTAMP('2025-07-19 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 1422665, TO_TIMESTAMP('2025-07-18 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1010);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('UN101', TO_TIMESTAMP('2025-07-02 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 1648959, TO_TIMESTAMP('2025-06-21 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1011);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('AS115', TO_TIMESTAMP('2025-07-16 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 1706594, TO_TIMESTAMP('2025-07-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1012);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('UN108', TO_TIMESTAMP('2025-07-09 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 1121175, TO_TIMESTAMP('2025-06-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1013);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('KO100', TO_TIMESTAMP('2025-07-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Economy', 1057935, TO_TIMESTAMP('2025-06-20 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1014);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('KO109', TO_TIMESTAMP('2025-07-10 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 703533, TO_TIMESTAMP('2025-07-06 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1015);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('DE113', TO_TIMESTAMP('2025-07-14 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'First', 1756466, TO_TIMESTAMP('2025-07-04 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1016);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('AS102', TO_TIMESTAMP('2025-07-03 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 464512, TO_TIMESTAMP('2025-07-02 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1017);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('AS119', TO_TIMESTAMP('2025-07-20 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 682364, TO_TIMESTAMP('2025-07-15 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1018);

INSERT INTO Cancel (flightNo, departureDateTime, seatClass, refund, cancelDateTime, cno) VALUES ('LU104', TO_TIMESTAMP('2025-07-05 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Business', 821470, TO_TIMESTAMP('2025-07-03 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1019);