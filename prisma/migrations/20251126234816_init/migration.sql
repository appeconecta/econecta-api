-- CreateEnum
CREATE TYPE "StayDuration" AS ENUM ('UP_TO_5_DAYS', 'SEVERAL_WEEKS', 'SEVERAL_MONTHS');

-- CreateEnum
CREATE TYPE "Vegetation" AS ENUM ('NONE', 'LOW', 'TALL');

-- CreateEnum
CREATE TYPE "Water" AS ENUM ('ABUNDANT', 'FRESH', 'BRACKISH', 'NONE');

-- CreateEnum
CREATE TYPE "Soil" AS ENUM ('FERTILE', 'ROCKY', 'COMPACT');

-- CreateEnum
CREATE TYPE "Terrain" AS ENUM ('FLAT', 'STEEP', 'INACCESSIBLE');

-- CreateEnum
CREATE TYPE "Animal" AS ENUM ('VARIOUS', 'FLIES', 'HORSES', 'PIGS');

-- CreateEnum
CREATE TYPE "Climate" AS ENUM ('TROPICAL', 'TEMPERATE', 'ARCTIC', 'UNKNOWN', 'NO_RESPONSE');

-- CreateEnum
CREATE TYPE "Disposal" AS ENUM ('TRASH_BINS_AVAILABLE');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "emailVerified" TIMESTAMP(3),
    "image" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Account" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerAccountId" TEXT NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Session" (
    "id" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TrashSpot" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "stayDuration" "StayDuration" NOT NULL,
    "vegetation" "Vegetation" NOT NULL,
    "terrain" "Terrain" NOT NULL,
    "climate" "Climate" NOT NULL,
    "water" "Water"[],
    "soil" "Soil"[],
    "animals" "Animal"[],
    "disposal" "Disposal"[],

    CONSTRAINT "TrashSpot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Comment" (
    "id" SERIAL NOT NULL,
    "content" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,
    "trashSpotId" INTEGER NOT NULL,

    CONSTRAINT "Comment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON "Account"("provider", "providerAccountId");

-- CreateIndex
CREATE UNIQUE INDEX "Session_sessionToken_key" ON "Session"("sessionToken");

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_trashSpotId_fkey" FOREIGN KEY ("trashSpotId") REFERENCES "TrashSpot"("id") ON DELETE CASCADE ON UPDATE CASCADE;
