CREATE TABLE "nf_trener" (
  "tId" integer GENERATED AS IDENTITY PRIMARY KEY,
  "jmeno" VARCHAR2(50) NOT NULL,
  "prijmeni" VARCHAR2(50) NOT NULL,
  "telefon" VARCHAR2(13) NOT NULL,
  "email" VARCHAR2(100) NOT NULL,
  "datumRegistrace" DATE DEFAULT SYSDATE NOT NULL,
  "aktivni" NUMBER(1) DEFAULT 1 NOT NULL,
  "cenaZaHodinu" NUMBER(8,2) NOT NULL
);

CREATE TABLE "nf_misto" (
  "mId" integer GENERATED AS IDENTITY PRIMARY KEY,
  "jmeno" VARCHAR2(100) NOT NULL,
  "popis" VARCHAR2,
  "adresa" VARCHAR2(100) NOT NULL,
  "lat" NUMBER(8,6) NOT NULL,
  "lon" NUMBER(9,6) NOT NULL,
  "vevnitr" NUMBER(1) DEFAULT 0 NOT NULL,
  "najem" NUMBER(8,2)
);

CREATE TABLE "nf_zakaznik" (
  "zId" integer GENERATED AS IDENTITY PRIMARY KEY,
  "jmeno" VARCHAR2(50) NOT NULL,
  "prijmeni" VARCHAR2(50) NOT NULL,
  "telefon" VARCHAR2(13),
  "email" VARCHAR2(100) NOT NULL,
  "datumRegistrace" DATE DEFAULT SYSDATE NOT NULL,
  "overeny" NUMBER(1) DEFAULT 0 NOT NULL,
  "aktivni" NUMBER(1) DEFAULT 1 NOT NULL
);

CREATE TABLE "nf_vycvik" (
  "vId" integer GENERATED AS IDENTITY PRIMARY KEY,
  "poznamky" VARCHAR2,
  "od" DATE NOT NULL,
  "do" DATE NOT NULL,
  "pocetMist" integer NOT NULL,
  "pocetVolnychMist" integer NOT NULL,
  "trener" integer NOT NULL,
  "misto" integer NOT NULL
);

CREATE TABLE "nf_ucast" (
  "uId" integer GENERATED AS IDENTITY PRIMARY KEY,
  "stav" integer NOT NULL,
  "vycvik" integer NOT NULL,
  "pes" integer NOT NULL,
  "kupon" VARCHAR2(8) UNIQUE,
  "celkovaCena" NUMBER(8,2) NOT NULL
);

CREATE TABLE "nf_pes" (
  "pId" integer GENERATED AS IDENTITY PRIMARY KEY,
  "jmeno" VARCHAR2(50) NOT NULL,
  "plemeno" VARCHAR2(50) NOT NULL,
  "datumNarozeni" DATE NOT NULL,
  "poznamky" VARCHAR2,
  "majitel" integer NOT NULL,
  "aktivni" NUMBER(1) DEFAULT 1 NOT NULL
);

CREATE TABLE "nf_kupon" (
  "kod" VARCHAR2(8) PRIMARY KEY,
  "sleva" NUMBER(2,0) NOT NULL
);

CREATE TABLE "nf_stavUcasti" (
  "sId" integer GENERATED AS IDENTITY PRIMARY KEY,
  "stav" VARCHAR2(50) NOT NULL
);

ALTER TABLE "nf_vycvik" ADD FOREIGN KEY ("trener") REFERENCES "nf_trener" ("tId") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "nf_vycvik" ADD FOREIGN KEY ("misto") REFERENCES "nf_misto" ("mId") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "nf_ucast" ADD FOREIGN KEY ("stav") REFERENCES "nf_stavUcasti" ("sId") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "nf_ucast" ADD FOREIGN KEY ("vycvik") REFERENCES "nf_vycvik" ("vId") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "nf_ucast" ADD FOREIGN KEY ("pes") REFERENCES "nf_pes" ("pId") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "nf_ucast" ADD FOREIGN KEY ("kupon") REFERENCES "nf_kupon" ("kod") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "nf_pes" ADD FOREIGN KEY ("majitel") REFERENCES "nf_zakaznik" ("zId") DEFERRABLE INITIALLY IMMEDIATE;
