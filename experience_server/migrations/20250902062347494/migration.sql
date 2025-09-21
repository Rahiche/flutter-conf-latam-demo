BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "review" DROP CONSTRAINT "review_fk_2";
ALTER TABLE "review" DROP CONSTRAINT "review_fk_0";
ALTER TABLE "review" DROP CONSTRAINT "review_fk_1";
ALTER TABLE "review" DROP COLUMN "experienceId";
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "review"
    ADD CONSTRAINT "review_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "review"
    ADD CONSTRAINT "review_fk_1"
    FOREIGN KEY("_experienceReviewsExperienceId")
    REFERENCES "experience"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR experience
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('experience', '20250902062347494', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250902062347494', "timestamp" = now();

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
