USE travel_agency;
DROP TRIGGER IF EXISTS trip_insert;
DELIMITER $
CREATE TRIGGER trip_insert
AFTER INSERT ON trip
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'INSERT','trip', user, lname, curDatetime);
END $
DELIMITER ;


DROP TRIGGER IF EXISTS trip_update;
DELIMITER $
CREATE TRIGGER trip_update
AFTER UPDATE ON trip
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'UPDATE','trip', user, lname, curDatetime);
END $
DELIMITER ;


DROP TRIGGER IF EXISTS trip_delete;
DELIMITER $
CREATE TRIGGER trip_delete
AFTER DELETE ON trip
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'DELETE','trip', user, lname, curDatetime);
END $
DELIMITER ;



DROP TRIGGER IF EXISTS reservation_insert;
DELIMITER $
CREATE TRIGGER reservation_insert
AFTER INSERT ON reservation
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'INSERT','reservation', user, lname, curDatetime);
END $
DELIMITER ;



DROP TRIGGER IF EXISTS reservation_update;
DELIMITER $
CREATE TRIGGER reservation_update
AFTER UPDATE ON reservation
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'UPDATE','reservation', user, lname, curDatetime);
END $
DELIMITER ;


DROP TRIGGER IF EXISTS reservation_delete;
DELIMITER $
CREATE TRIGGER reservation_delete
AFTER DELETE ON reservation
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'DELETE','reservation', user, lname, curDatetime);
END $
DELIMITER ;



DROP TRIGGER IF EXISTS event_insert;
DELIMITER $
CREATE TRIGGER event_insert
AFTER INSERT ON event
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'INSERT','event', user, lname, curDatetime);
END $
DELIMITER ;



DROP TRIGGER IF EXISTS event_update;
DELIMITER $
CREATE TRIGGER event_update
AFTER UPDATE ON event
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'UPDATE','event', user, lname, curDatetime);
END $
DELIMITER ;


DROP TRIGGER IF EXISTS event_delete;
DELIMITER $
CREATE TRIGGER event_delete
AFTER DELETE ON event
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'DELETE','event', user, lname, curDatetime);
END $
DELIMITER ;


DROP TRIGGER IF EXISTS travel_to_insert;
DELIMITER $
CREATE TRIGGER travel_to_insert
AFTER INSERT ON travel_to
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'INSERT','travel_to', user, lname, curDatetime);
END $
DELIMITER ;



DROP TRIGGER IF EXISTS travel_to_update;
DELIMITER $
CREATE TRIGGER travel_to_update
AFTER UPDATE ON travel_to
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'UPDATE','travel_to', user, lname, curDatetime);
END $
DELIMITER ;



DROP TRIGGER IF EXISTS travel_to_delete;
DELIMITER $
CREATE TRIGGER travel_to_delete
AFTER DELETE ON travel_to
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'DELETE','travel_to', user, lname, curDatetime);
END $
DELIMITER ;



DROP TRIGGER IF EXISTS destination_insert;
DELIMITER $
CREATE TRIGGER destination_insert
AFTER INSERT ON destination
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'INSERT','destination', user, lname, curDatetime);
END $
DELIMITER ;



DROP TRIGGER IF EXISTS destination_update;
DELIMITER $
CREATE TRIGGER destination_update
AFTER UPDATE ON destination
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'UPDATE','destination', user, lname, curDatetime);
END $
DELIMITER ;



DROP TRIGGER IF EXISTS destination_delete;
DELIMITER $
CREATE TRIGGER destination_delete
AFTER DELETE ON destination
FOR EACH ROW
BEGIN
DECLARE curDatetime DATETIME;
DECLARE user CHAR(10);
DECLARE lname VARCHAR(20);
SET curDatetime=NOW();
SELECT SUBSTRING(USER(),1,LOCATE('@',USER())-1) INTO user;
SELECT wrk_lname INTO lname FROM worker WHERE wrk_AT=user;
INSERT INTO log VALUES (NULL, 'DELETE','destination', user, lname, curDatetime);
END $
DELIMITER ;

DROP TRIGGER IF EXISTS res_check;
DELIMITER $ 
CREATE TRIGGER res_check 
BEFORE UPDATE ON trip 
FOR EACH ROW 
BEGIN 
DECLARE trip_id INT(11);
DECLARE reserved_trip INT(11);
DECLARE trip_departure DATETIME;
DECLARE trip_return DATETIME;
DECLARE trip_cost FLOAT(7,2);
SET trip_departure=OLD.tr_departure;
SET trip_return=OLD.tr_return;
SET trip_cost=OLD.tr_cost;
SELECT tr_id INTO trip_id FROM trip WHERE tr_departure=trip_departure;
SELECT COUNT(res_tr_id) INTO reserved_trip FROM reservation WHERE res_tr_id=trip_id; 
IF reserved_trip NOT LIKE '0' THEN 
SET NEW.tr_departure=trip_departure;
SET NEW.tr_return=trip_return;
SET NEW.tr_cost=trip_cost;
END IF;
END $
DELIMITER ;




DROP TRIGGER IF EXISTS salary_check;
DELIMITER $
CREATE TRIGGER salary_check
BEFORE UPDATE ON worker 
FOR EACH ROW 
BEGIN
DECLARE old_salary FLOAT(7,2);
SET old_salary=OLD.wrk_salary;

IF NEW.wrk_salary<old_salary THEN SET NEW.wrk_salary=old_salary;

END IF;
END $
DELIMITER ;