CREATE DATABASE npdb
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;


CREATE TABLE "order_mgmt".t_order
(
    order_id serial,
    user_id bigint,
    amount numeric(18,2),
	order_date character varying(30) COLLATE pg_catalog."default",

	CONSTRAINT t_order_pkey PRIMARY KEY (order_id),
)

TABLESPACE pg_default;

ALTER TABLE "order_mgmt".t_order
    OWNER to postgres;
	
INSERT INTO "order_mgmt".t_order(
	user_id, amount, order_date)
	VALUES (1, 1235.50, '21 May 2020');

INSERT INTO "order_mgmt".t_order(
	user_id, amount, order_date)
	VALUES (1, 1035.80, '11 Apr 2020');

INSERT INTO "order_mgmt".t_order(
	user_id, amount, order_date)
	VALUES (1, 7235.50, '15 Sep 2019');

INSERT INTO "order_mgmt".t_order(
	user_id, amount, order_date)
	VALUES (2, 935.50, '12 Mar 2020');

INSERT INTO "order_mgmt".t_order(
	user_id, amount, order_date)
	VALUES (2, 12350.50, '21 Jan 2020');
	