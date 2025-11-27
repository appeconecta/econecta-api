-- CreateTable
CREATE TABLE "Confirmation" (
    "id" SERIAL NOT NULL,
    "confirmedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,
    "trashSpotId" INTEGER NOT NULL,

    CONSTRAINT "Confirmation_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Confirmation_trashSpotId_userId_key" ON "Confirmation"("trashSpotId", "userId");

-- AddForeignKey
ALTER TABLE "Confirmation" ADD CONSTRAINT "Confirmation_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Confirmation" ADD CONSTRAINT "Confirmation_trashSpotId_fkey" FOREIGN KEY ("trashSpotId") REFERENCES "TrashSpot"("id") ON DELETE CASCADE ON UPDATE CASCADE;
