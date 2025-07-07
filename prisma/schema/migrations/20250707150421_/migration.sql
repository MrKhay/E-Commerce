/*
  Warnings:

  - The values [ECommerce,Services] on the enum `BusinessType` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "BusinessType_new" AS ENUM ('BeautyProfessional', 'LocalProducts');
ALTER TABLE "accounts" ALTER COLUMN "business_type" TYPE "BusinessType_new" USING ("business_type"::text::"BusinessType_new");
ALTER TYPE "BusinessType" RENAME TO "BusinessType_old";
ALTER TYPE "BusinessType_new" RENAME TO "BusinessType";
DROP TYPE "BusinessType_old";
COMMIT;
