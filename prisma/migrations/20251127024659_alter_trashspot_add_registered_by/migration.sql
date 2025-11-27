-- AlterTable
ALTER TABLE "TrashSpot" ADD COLUMN     "registeredById" TEXT;

-- AddForeignKey
ALTER TABLE "TrashSpot" ADD CONSTRAINT "TrashSpot_registeredById_fkey" FOREIGN KEY ("registeredById") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;
