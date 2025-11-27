/*
  Warnings:

  - A unique constraint covering the columns `[collectionSpotId,userId]` on the table `Confirmation` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Comment" ADD COLUMN     "collectionSpotId" INTEGER,
ALTER COLUMN "trashSpotId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Confirmation" ADD COLUMN     "collectionSpotId" INTEGER,
ALTER COLUMN "trashSpotId" DROP NOT NULL;

-- CreateTable
CREATE TABLE "CollectionSpots" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "registeredById" TEXT,

    CONSTRAINT "CollectionSpots_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Confirmation_collectionSpotId_userId_key" ON "Confirmation"("collectionSpotId", "userId");

-- AddForeignKey
ALTER TABLE "CollectionSpots" ADD CONSTRAINT "CollectionSpots_registeredById_fkey" FOREIGN KEY ("registeredById") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_collectionSpotId_fkey" FOREIGN KEY ("collectionSpotId") REFERENCES "CollectionSpots"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Confirmation" ADD CONSTRAINT "Confirmation_collectionSpotId_fkey" FOREIGN KEY ("collectionSpotId") REFERENCES "CollectionSpots"("id") ON DELETE CASCADE ON UPDATE CASCADE;
