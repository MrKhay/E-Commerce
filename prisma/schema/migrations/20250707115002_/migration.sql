/*
  Warnings:

  - You are about to drop the column `user_id` on the `user_sessions` table. All the data in the column will be lost.
  - You are about to drop the column `vendor_id` on the `user_sessions` table. All the data in the column will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `vendors` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `account_id` to the `user_sessions` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "AccountType" AS ENUM ('USER', 'VENDOR');

-- DropForeignKey
ALTER TABLE "appointments" DROP CONSTRAINT "appointments_userId_fkey";

-- DropForeignKey
ALTER TABLE "appointments" DROP CONSTRAINT "appointments_vendorId_fkey";

-- DropForeignKey
ALTER TABLE "user_sessions" DROP CONSTRAINT "user_sessions_user_id_fkey";

-- DropForeignKey
ALTER TABLE "user_sessions" DROP CONSTRAINT "user_sessions_vendor_id_fkey";

-- DropForeignKey
ALTER TABLE "vendor_services" DROP CONSTRAINT "vendor_services_vendorId_fkey";

-- DropIndex
DROP INDEX "user_sessions_user_id_idx";

-- AlterTable
ALTER TABLE "user_sessions" DROP COLUMN "user_id",
DROP COLUMN "vendor_id",
ADD COLUMN     "account_id" TEXT NOT NULL;

-- DropTable
DROP TABLE "users";

-- DropTable
DROP TABLE "vendors";

-- CreateTable
CREATE TABLE "accounts" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT,
    "phone_number" TEXT NOT NULL,
    "password" TEXT,
    "avatar_url" TEXT,
    "type" "AccountType" NOT NULL DEFAULT 'USER',
    "business_name" TEXT,
    "business_type" "BusinessType",
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "accounts_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "accounts_email_key" ON "accounts"("email");

-- CreateIndex
CREATE UNIQUE INDEX "accounts_phone_number_key" ON "accounts"("phone_number");

-- CreateIndex
CREATE INDEX "accounts_email_idx" ON "accounts"("email");

-- CreateIndex
CREATE INDEX "accounts_phone_number_idx" ON "accounts"("phone_number");

-- CreateIndex
CREATE INDEX "user_sessions_account_id_idx" ON "user_sessions"("account_id");

-- AddForeignKey
ALTER TABLE "user_sessions" ADD CONSTRAINT "user_sessions_account_id_fkey" FOREIGN KEY ("account_id") REFERENCES "accounts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendor_services" ADD CONSTRAINT "vendor_services_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES "accounts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_userId_fkey" FOREIGN KEY ("userId") REFERENCES "accounts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES "accounts"("id") ON DELETE CASCADE ON UPDATE CASCADE;
