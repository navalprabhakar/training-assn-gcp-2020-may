CREATE DATABASE npdb
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;


CREATE TABLE "user_mgmt".t_user
(
    user_id serial,
    name character varying(255) COLLATE pg_catalog."default",
	age smallint,
	email character varying(255) COLLATE pg_catalog."default",

	CONSTRAINT t_user_pkey PRIMARY KEY (user_id),
    CONSTRAINT uk_t_user_email UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE "user_mgmt".t_user
    OWNER to postgres;
	
INSERT INTO "user_mgmt".t_user(
	name, age, email)
	VALUES ('Naval Prabhakar', 35, 'navalprabhakar@test.com');
INSERT INTO "user_mgmt".t_user(
	name, age, email)
	VALUES ('Abhishek Jaiswal', 35, 'abhishekjaiswal1234@test.com');