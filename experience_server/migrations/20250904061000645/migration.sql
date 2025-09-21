BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "category" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "category" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "iconUrl" text NOT NULL,
    "approved" boolean
);


--
-- MIGRATION VERSION FOR experience
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('experience', '20250904061000645', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250904061000645', "timestamp" = now();

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
