BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "category" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "approved" boolean
);

--
-- ACTION DROP TABLE
--
DROP TABLE "experience" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "experience" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "location" text NOT NULL,
    "photoUrl" text,
    "startsAt" timestamp without time zone NOT NULL,
    "endsAt" timestamp without time zone NOT NULL,
    "categoryId" bigint NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "experience"
    ADD CONSTRAINT "experience_fk_0"
    FOREIGN KEY("categoryId")
    REFERENCES "category"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR experience
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('experience', '20250904060731487', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250904060731487', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
