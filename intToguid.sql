/* For increment integer switching to GUID */

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

ALTER TABLE "Users" ADD COLUMN "GUID" uuid DEFAULT (uuid_generate_v4());
UPDATE public."Users"
   SET "GUID" = uuid_generate_v4();
ALTER TABLE "Users" ALTER COLUMN "GUID" SET NOT NULL;

ALTER TABLE "Users" RENAME COLUMN  "Id" TO "Index";
ALTER TABLE "Users" RENAME COLUMN "GUID" TO "Id";

/* In order to set (UUID) Practitioner.Id as Foriegn Key TARGET from Other Table, it first needs to be CONTRAINT UNIQUE */
ALTER TABLE "Users" ADD CONSTRAINT "Temp_UNIQUE_User" UNIQUE ("Id");

ALTER TABLE "Bookings" ADD COLUMN "USERGUID" uuid;
UPDATE "Bookings"
SET "USERGUID" = (SELECT "Id"
                        FROM public."Users"
                        WHERE public."Users"."Index" = "Bookings"."UserId");
ALTER TABLE "Bookings" ALTER COLUMN "USERGUID" SET NOT NULL;

-- Replace UserId (USERGUID)
ALTER TABLE "Bookings" DROP COLUMN "UserId";
ALTER TABLE "Bookings" RENAME COLUMN "USERGUID" TO "UserId";
-- Bookings-->

ALTER TABLE "Reviews" ADD COLUMN "USERGUID" uuid;
UPDATE "Reviews"
SET "USERGUID" = (SELECT "Id"
                        FROM public."Users"
                        WHERE public."Users"."Index" = "Reviews"."UserId");
ALTER TABLE "Reviews" ALTER COLUMN "USERGUID" SET NOT NULL;

-- Replace UserId (USERGUID)
ALTER TABLE "Reviews" DROP COLUMN "UserId";
ALTER TABLE "Reviews" RENAME COLUMN "USERGUID" TO "UserId";
-- Reviews-->

--object table -->

ALTER TABLE "PromotionCode" ADD COLUMN "USERGUID" uuid;-- DEFAULT (uuid_generate_v4());
UPDATE "PromotionCode"
SET "USERGUID" = (SELECT "Id"
                        FROM public."Users"
                        WHERE public."Users"."Index" = "PromotionCode"."CorporateUserId");
--ALTER TABLE "PromotionCode" ALTER COLUMN "USERGUID" SET NOT NULL;

-- Replace UsersId (USERGUID)
ALTER TABLE "PromotionCode" DROP COLUMN "CorporateCodeUserId";
ALTER TABLE "PromotionCode" RENAME COLUMN "USERGUID" TO "CorporateCodeUserId";

ALTER TABLE "Bookings" DROP CONSTRAINT IF EXISTS "FK_Bookings_Users_UserId";
ALTER TABLE "PromotionCode" DROP CONSTRAINT IF EXISTS "FK_PromotionCode_Users_CorporateCodeUserId";
ALTER TABLE "Reviews" DROP CONSTRAINT IF EXISTS "FK_Reviews_Users_UserId";

ALTER TABLE "Users" DROP CONSTRAINT IF EXISTS "PK_Users";
ALTER TABLE "Users" ADD CONSTRAINT "PK_Users" PRIMARY KEY ("Id");
ALTER TABLE "Users" DROP CONSTRAINT IF EXISTS "Temp_UNIQUE_User" CASCADE;

ALTER TABLE "Bookings" ADD CONSTRAINT "FK_Bookings_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("Id");
ALTER TABLE "PromotionCode" ADD CONSTRAINT "FK_PromotionCode_Users_CorporateCodeUserId" FOREIGN KEY ("CorporateCodeUserId") REFERENCES public."Users"("Id");
ALTER TABLE "Reviews" ADD CONSTRAINT "FK_Reviews_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("Id");
