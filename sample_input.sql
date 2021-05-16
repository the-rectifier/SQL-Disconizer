-- Table: public.person

-- DROP TABLE public.person;

CREATE TABLE public.person
(
    "idPerson" integer NOT NULL,
    fname character varying(45) COLLATE pg_catalog."default",
    lname character varying(45) COLLATE pg_catalog."default",
    sex character(1) COLLATE pg_catalog."default",
    dateofbirth date,
    address character varying(75) COLLATE pg_catalog."default",
    city character varying(45) COLLATE pg_catalog."default",
    country character varying(45) COLLATE pg_catalog."default",
    CONSTRAINT "idPerson_PK" PRIMARY KEY ("idPerson")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.person
    OWNER to postgres;

-- Table: public.client

-- DROP TABLE public.client;

CREATE TABLE public.client
(
    "idClient" integer NOT NULL,
    documentclient character varying(45) COLLATE pg_catalog."default",
    CONSTRAINT "idClient_PK" PRIMARY KEY ("idClient"),
    CONSTRAINT dc_uniq UNIQUE (documentclient),
    CONSTRAINT "idClient_FK" FOREIGN KEY ("idClient")
        REFERENCES public.person ("idPerson") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.client
    OWNER to postgres;

-- Table: public.hotel

-- DROP TABLE public.hotel;

CREATE TABLE public.hotel
(
    "idHotel" integer NOT NULL,
    name character varying(45) COLLATE pg_catalog."default",
    stars character varying(10) COLLATE pg_catalog."default",
    address character varying(75) COLLATE pg_catalog."default",
    city character varying(45) COLLATE pg_catalog."default",
    country character varying(45) COLLATE pg_catalog."default",
    phone character varying(25) COLLATE pg_catalog."default",
    fax character varying(25) COLLATE pg_catalog."default",
    CONSTRAINT "idHotel_PK" PRIMARY KEY ("idHotel"),
    CONSTRAINT "fax_UNIQUE" UNIQUE (fax),
    CONSTRAINT "phone_UNIQUE" UNIQUE (phone)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.hotel
    OWNER to postgres;