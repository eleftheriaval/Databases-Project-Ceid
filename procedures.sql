USE travel_agency;
delimiter $
drop procedure if exists new_driver$
create procedure new_driver(in driverAT char(10),in driverName varchar(20),in driverLname varchar(20),
in driverSalary float(7,2),in driverLicense enum('A','B','C','D'),in driverRoute enum('LOCAL','ABROAD'),in driverExperience tinyint(4))
begin
declare branch_code int(11);
declare num_of_drivers int(11);
select br_code,count(*) into branch_code,num_of_drivers from branch 
inner join worker on branch.br_code=worker.wrk_br_code 
inner join driver on worker.wrk_AT=driver.drv_AT group by br_code order by count(*) asc limit 0,1;
insert into worker values(driverAT,driverName,driverLname,driverSalary,branch_code);
insert into driver values(driverAT,driverLicense,driverRoute,driverExperience);
end$
delimiter ;





DROP PROCEDURE IF EXISTS trip_check;
DELIMITER $
CREATE PROCEDURE trip_check(IN branch_code INT(11), IN start_date DATE, IN end_date DATE)
BEGIN 
DECLARE reservations INT(11);
DECLARE trip_cost FLOAT(7.2);
DECLARE trip INT(11); 
DECLARE maximum_seats TINYINT(4);
DECLARE empty_seats TINYINT(4);
DECLARE guide VARCHAR(10);
DECLARE driver VARCHAR(10);
DECLARE guide_name VARCHAR(20);
DECLARE guide_lastname VARCHAR(20);
DECLARE driver_name VARCHAR(20);
DECLARE driver_lastname VARCHAR(20);

DECLARE trip_departure DATETIME;
DECLARE trip_return DATETIME;

DECLARE res_flag INT;
DECLARE res_cursor CURSOR FOR
	SELECT res_tr_id, tr_cost, tr_maxseats, COUNT(res_seatnum), tr_gui_AT, tr_drv_AT, tr_departure, tr_return FROM reservation
	INNER JOIN trip ON trip.tr_id= reservation.res_tr_id
	WHERE trip.tr_br_code=branch_code AND trip.tr_departure>=start_date 
	AND trip.tr_return<=end_date
	GROUP BY res_tr_id;



DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET res_flag=1;

OPEN res_cursor;
SET res_flag=0;

REPEAT 
FETCH res_cursor INTO trip, trip_cost, maximum_seats, reservations, guide, driver, trip_departure, trip_return;
IF (res_flag=0) THEN

SELECT wrk_name, wrk_lname INTO guide_name, guide_lastname 
FROM worker WHERE wrk_AT=guide;

SELECT wrk_name, wrk_lname INTO driver_name, driver_lastname
FROM worker WHERE wrk_AT=DRIVER; 

SET empty_seats=maximum_seats-reservations;
SELECT trip, trip_cost, maximum_seats, reservations, empty_seats;
SELECT trip, guide_name, guide_lastname, driver_name, driver_lastname;
SELECT trip, trip_departure, trip_return;
END IF;
UNTIL res_flag=1
END REPEAT;

CLOSE res_cursor;

END $
DELIMITER ;






DELIMITER $ 
DROP PROCEDURE IF EXISTS worker_info$
CREATE PROCEDURE worker_info(in workername varchar(20), in workerlname varchar(20))
BEGIN
DECLARE workerAT CHAR(10);
DECLARE admintype ENUM('LOGISTICS','ADMINISTRATIVE','ACCOUNTING');
DECLARE finishedflag INT;
DECLARE adm_cursor CURSOR FOR
SELECT wrk_AT,adm_type FROM worker INNER JOIN admin ON worker.wrk_AT=admin.adm_AT WHERE wrk_name=workername AND wrk_lname=workerlname;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedflag=1;
OPEN adm_cursor;
SET finishedflag=0; 
REPEAT
FETCH adm_cursor INTO workerAT,admintype;
IF (finishedflag=0) THEN
   IF(admintype='ADMINISTRATIVE') THEN 
     SELECT 'The worker is administrative.';
   ELSE
     DELETE FROM worker WHERE wrk_AT=workerAT;
     SELECT 'The worker deleted.';
   END IF;
END IF;
UNTIL(finishedflag=1)
END REPEAT;
CLOSE adm_cursor; 
END$
DELIMITER ;





DROP PROCEDURE IF EXISTS offer_check_a;
DELIMITER $
CREATE PROCEDURE offer_check_a(IN cost_min FLOAT(7,2), IN cost_max FLOAT(7,2))
BEGIN
DECLARE name VARCHAR(20);
DECLARE lastname VARCHAR(20);
DECLARE deposit_ammount FLOAT(7,2);

DECLARE offer_flag INT;
DECLARE offer_cursor CURSOR FOR 
	SELECT offer_name, offer_lname, deposit FROM reservation_offers
	WHERE deposit>=cost_min AND deposit<=cost_max;

DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET offer_flag=1;

OPEN offer_cursor;
SET offer_flag=0;

REPEAT 
FETCH offer_cursor INTO name, lastname, deposit_ammount;
IF (offer_flag=0) THEN 

SELECT name, lastname, deposit_ammount;
END IF;
UNTIL (offer_flag=1)
END REPEAT;

CLOSE offer_cursor;

END$
DELIMITER ;






DROP PROCEDURE IF EXISTS offer_check_b;
DELIMITER $
CREATE PROCEDURE offer_check_b(IN res_lastname VARCHAR(20))
BEGIN
DECLARE name VARCHAR(20);
DECLARE lastname VARCHAR(20);
DECLARE count INT(10);
DECLARE offer_id INT(5);

DECLARE check_flag INT;
DECLARE check_cursor CURSOR FOR 
	SELECT offer_name, COUNT(offer_name),  res_offer_id FROM reservation_offers
	WHERE offer_lname=res_lastname GROUP BY res_offer_id, offer_name;

DECLARE CONTINUE HANDLER FOR NOT FOUND
SET check_flag=1;

OPEN check_cursor;
SET check_flag=0;

REPEAT 
FETCH check_cursor INTO name, count, offer_id;
IF(check_flag=0) THEN 

SELECT name, count, res_lastname, offer_id;

END IF;
UNTIL check_flag=1
END REPEAT;

CLOSE check_cursor;

END $
DELIMITER ;








