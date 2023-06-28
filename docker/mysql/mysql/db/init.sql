USE yelp;

DROP TABLE IF EXISTS F_CHECKIN;
CREATE TABLE F_CHECKIN (
    checkin_id varchar(255) NOT NULL,
    business_id varchar(22) NOT NULL,
    date DATETIME,
    PRIMARY KEY (checkin_id,business_id)
);

DROP TABLE IF EXISTS F_REVIEW;
CREATE TABLE F_REVIEW (
    review_id varchar(22) NOT NULL,
    user_id varchar(22) NOT NULL,
    business_id varchar(22) NOT NULL,
    stars float,
    useful integer DEFAULT 0,
    funny integer DEFAULT 0,
    cool integer DEFAULT 0,
    text varchar(4000),
    date DATETIME,
    PRIMARY KEY (review_id)
);


DROP TABLE IF EXISTS F_TIP;
CREATE TABLE F_TIP (
    tip_id varchar(255) NOT NULL,
    user_id varchar(22) NOT NULL,
    business_id varchar(22) NOT NULL,
    text varchar(4000),
    date DATETIME,
    compliment_count integer DEFAULT 0,
    PRIMARY KEY (tip_id)
);

DROP TABLE IF EXISTS M_BUSINESS;
CREATE TABLE M_BUSINESS (
    business_id varchar(22) NOT NULL,
    name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    city varchar(255) NOT NULL,
    state varchar(255) NOT NULL,
    postal_code varchar(255) NOT NULL,
    latitude float NOT NULL,
    longitude float NOT NULL,
    stars float,
    review_count integer DEFAULT 0,
    is_open integer NOT NULL,
    categories varchar(1000),
    PRIMARY KEY (business_id)
);

DROP TABLE IF EXISTS M_BUSINESS_HOURS;
CREATE TABLE M_BUSINESS_HOURS (
    business_id varchar(22) NOT NULL,
    Monday varchar(255),
    Tuesday varchar(255),
    Wednesday varchar(255),
    Thursday varchar(255),
    Friday varchar(255),
    Saturday varchar(255),
    Sunday varchar(255),
    PRIMARY KEY (business_id)
);
    

DROP TABLE IF EXISTS M_USER;
CREATE TABLE M_USER (
    user_id varchar(22) NOT NULL,
    name varchar(255) NOT NULL,
    review_count integer DEFAULT 0,
    yelping_since DATETIME,
    useful integer DEFAULT 0,
    funny integer DEFAULT 0,
    cool integer DEFAULT 0,
    elite varchar(1000),
    friends LONGTEXT,
    fans integer DEFAULT 0,
    average_stars float,
    compliment_hot integer DEFAULT 0,
    compliment_more integer DEFAULT 0,
    compliment_profile integer DEFAULT 0,
    compliment_cute integer DEFAULT 0,
    compliment_list integer DEFAULT 0,
    compliment_note integer DEFAULT 0,
    compliment_plain integer DEFAULT 0,
    compliment_cool integer DEFAULT 0,
    compliment_funny integer DEFAULT 0,
    compliment_writer integer DEFAULT 0,
    compliment_photos integer DEFAULT 0,
    PRIMARY KEY (user_id)
);
