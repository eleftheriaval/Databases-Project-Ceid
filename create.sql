DROP DATABASE if exists travel_agency ;
CREATE DATABASE travel_agency;
USE travel_agency;

DROP TABLE IF EXISTS branch;
CREATE TABLE branch(
	br_code INT(11) NOT NULL AUTO_INCREMENT,
	br_street VARCHAR(30) NOT NULL,
	br_num INT(4) NOT NULL,
	br_city VARCHAR(30) DEFAULT 'unknown city' NOT NULL,
	PRIMARY KEY (br_code)
);

DROP TABLE IF EXISTS phones;
CREATE TABLE phones(
	ph_br_code INT(11) NOT NULL,
	ph_number CHAR(10) NOT NULL,
	PRIMARY KEY(ph_br_code, ph_number),
	CONSTRAINT br_phone 
	FOREIGN KEY (ph_br_code) REFERENCES branch(br_code)
	ON DELETE CASCADE ON UPDATE CASCADE 
);

DROP TABLE IF EXISTS worker;
CREATE TABLE worker(
	wrk_AT CHAR(10) NOT NULL,
	wrk_name VARCHAR(20)  NOT NULL,
	wrk_lname VARCHAR(20) NOT NULL,
	wrk_salary FLOAT(7,2) NULL,
	wrk_br_code INT(11) NOT NULL,
	PRIMARY KEY(wrk_AT),
	CONSTRAINT wrk_branch 
	FOREIGN KEY (wrk_br_code) REFERENCES branch(br_code)
	ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS admin;
CREATE TABLE admin(
	adm_AT CHAR(10) NOT NULL,
	adm_type ENUM('LOGISTICS','ADMINISTRATIVE','ACCOUNTING') NOT NULL,
	adm_diploma VARCHAR(200) DEFAULT 'unknown diploma' NOT NULL,
	PRIMARY KEY(adm_AT),
	CONSTRAINT admin_AT
	FOREIGN KEY (adm_AT) REFERENCES worker(wrk_AT)
	ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS manages;
CREATE TABLE manages(
	mng_adm_AT CHAR(10) NOT NULL,
	mng_br_code INT(11) NOT NULL,
	PRIMARY KEY(mng_adm_AT, mng_br_code),
	CONSTRAINT managed_branch 
	FOREIGN KEY (mng_br_code) REFERENCES branch(br_code)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT branch_manager
	FOREIGN KEY (mng_adm_AT) REFERENCES admin(adm_AT)
	ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS driver;
CREATE TABLE driver(
	drv_AT CHAR(10) NOT NULL,
	drv_license ENUM('A','B','C','D') NOT NULL,
	drv_route ENUM('LOCAL','ABROAD') NOT NULL,
	drv_experience TINYINT(4) NOT NULL,
	PRIMARY KEY(drv_AT),
	CONSTRAINT driver_AT
	FOREIGN KEY (drv_AT) REFERENCES worker(wrk_AT)
	ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS guide;
CREATE TABLE guide(
	gui_AT CHAR(10) NOT NULL,
	gui_cv TEXT NULL,
	PRIMARY KEY(gui_AT),
	CONSTRAINT guide_AT
	FOREIGN KEY (gui_AT) REFERENCES worker(wrk_AT)
	ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS languages;
CREATE TABLE languages(
	lng_gui_AT CHAR(10) NOT NULL,
	lng_language VARCHAR(30) NOT NULL,	
	PRIMARY KEY(lng_gui_AT, lng_language),
	CONSTRAINT guide_language
	FOREIGN KEY (lng_gui_AT) REFERENCES guide(gui_AT)
	ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS trip;
CREATE TABLE trip(
	tr_id INT(11) NOT NULL AUTO_INCREMENT,
	tr_departure DATETIME NOT NULL,
	tr_return DATETIME NOT NULL,
	tr_maxseats TINYINT(4) NOT NULL,
	tr_cost FLOAT(7,2) NOT NULL,
	tr_br_code INT(11) NOT NULL,
	tr_gui_AT CHAR(10) NOT NULL,
	tr_drv_AT CHAR(10) NOT NULL,
	PRIMARY KEY(tr_id),
	CONSTRAINT trip_branch
	FOREIGN KEY (tr_br_code) REFERENCES branch(br_code)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT trip_guide
	FOREIGN KEY (tr_gui_AT) REFERENCES guide(gui_AT)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT trip_driver
	FOREIGN KEY (tr_drv_AT) REFERENCES driver(drv_AT)
	ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS event;
CREATE TABLE event(
	ev_tr_id INT(11) NOT NULL,
	ev_start DATETIME NOT NULL,
	ev_end DATETIME NULL,
	ev_descr TEXT NULL,
	PRIMARY KEY(ev_tr_id, ev_start),
	CONSTRAINT trip_event 
	FOREIGN KEY (ev_tr_id) REFERENCES TRIP(tr_id)
	ON DELETE CASCADE ON UPDATE CASCADE	
);

DROP TABLE IF EXISTS reservation;
CREATE TABLE reservation(
	res_tr_id INT(11) NOT NULL,
	res_seatnum TINYINT(4) NOT NULL,
	res_name VARCHAR(20) DEFAULT 'unknown' NOT NULL,
	res_lname VARCHAR(20) DEFAULT 'unknown' NOT NULL,
	res_isadult ENUM('ADULT','MINOR') NOT NULL,
	PRIMARY KEY(res_tr_id, res_seatnum),
	CONSTRAINT trip_reservation
 	FOREIGN KEY (res_tr_id) REFERENCES trip(tr_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS destination;
CREATE TABLE destination(
	dst_id INT(11) NOT NULL AUTO_INCREMENT,
	dst_name VARCHAR(50) NOT NULL,
	dst_descr TEXT NULL,
	dst_rtype ENUM('LOCAL','ABROAD') NOT NULL,
	dst_language VARCHAR(30) DEFAULT 'unknown language' NOT NULL,
	dst_location INT(11) NULL,
	PRIMARY KEY(dst_id),
	CONSTRAINT location_id
	FOREIGN KEY (dst_location) REFERENCES destination(dst_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS travel_to;
CREATE TABLE travel_to(
	to_tr_id INT(11) NOT NULL,
	to_dst_id INT(11) NOT NULL,
	to_arrival DATETIME NOT NULL,
	to_departure DATETIME NOT NULL,
	PRIMARY KEY(to_tr_id, to_dst_id),
	CONSTRAINT to_id
	FOREIGN KEY (to_tr_id) REFERENCES trip(tr_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT to_destination
	FOREIGN KEY (to_dst_id) REFERENCES destination(dst_id)
	ON DELETE CASCADE ON UPDATE CASCADE 
);

DROP TABLE IF EXISTS IT;
CREATE TABLE IT(
	IT_AT CHAR(10) NOT NULL,
	password VARCHAR(15) DEFAULT 'password' NOT NULL,
	start_date DATE NOT NULL, 
	end_date DATE NULL,
	PRIMARY KEY(IT_AT),
	CONSTRAINT worker_AT
	FOREIGN KEY(IT_AT) REFERENCES worker(wrk_AT)
	ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS offers;
CREATE TABLE offers(
	offer_id INT(5) AUTO_INCREMENT NOT NULL,
	offer_start DATE NOT NULL,
	offer_end DATE NOT NULL,
	person_cost FLOAT(7,2) NOT NULL,
	offer_dst INT(11) NOT NULL,
	PRIMARY KEY(offer_id),
	CONSTRAINT offer_destination
	FOREIGN KEY(offer_dst) REFERENCES destination(dst_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS reservation_offers;
CREATE TABLE reservation_offers(
	res_offer_num INT(11) AUTO_INCREMENT NOT NULL,
	offer_name VARCHAR(20) DEFAULT 'unknown name' NOT NULL,
	offer_lname VARCHAR(20) DEFAULT 'unknown lname' NOT NULL,
	res_offer_id INT(5) NOT NULL,
	deposit FLOAT(7,2) NOT NULL,
	PRIMARY KEY(res_offer_num),
	CONSTRAINT reservation
	FOREIGN KEY(res_offer_id) REFERENCES offers(offer_id)
	ON DELETE CASCADE ON UPDATE CASCADE 
);

DROP TABLE IF EXISTS log;
CREATE TABLE log(
        action_code INT(11) NOT NULL AUTO_INCREMENT,
	action_type ENUM('INSERT','UPDATE','DELETE') NOT NULL,
	action_table ENUM('trip','reservation','event','travel_to','destination') NOT NULL,
	it_AT CHAR(10) NOT NULL,
	it_lname VARCHAR(20),
        date_time DATETIME NOT NULL,
	PRIMARY KEY(action_code),
	CONSTRAINT IT_info
	FOREIGN KEY(it_AT) REFERENCES IT(IT_AT)
	ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE INDEX deposit_index ON reservation_offers(deposit);
CREATE INDEX name_index ON reservation_offers(offer_lname, offer_name); 