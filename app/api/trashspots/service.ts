import prisma from "@/lib/prisma";
import { SpotInput } from "./validation";

export async function listSpots() {
  return prisma.trashSpot.findMany();
}

export async function createSpot(data: SpotInput) {
  return prisma.trashSpot.create({ data });
}

export async function getSpotById(id: number) {
  return prisma.trashSpot.findUnique({ where: { id } });
}

export async function updateSpot(id: number, data: Partial<SpotInput>) {
  return prisma.trashSpot.update({
    where: { id },
    data,
  });
}

export async function deleteSpot(id: number) {
  return prisma.trashSpot.delete({ where: { id } });
}

export async function createConfirmation(trashSpotId: number, userId: string) {
  return prisma.confirmation.create({
    data: {
      trashSpotId,
      userId,
    },
  });
}

export async function deleteConfirmation(trashSpotId: number, userId: string) {
  return prisma.confirmation.delete({
    where: {
      trashSpotId_userId: { trashSpotId, userId },
    },
  });
}
