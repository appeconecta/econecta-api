import prisma from "@/lib/prisma";
import { SpotInput, SpotUpdateInput } from "./validation";

export async function listSpots() {
  return prisma.trashSpot.findMany({ include: { location: true } });
}

export async function createSpot(data: SpotInput, userId: string) {
  const { location, ...spotData } = data;

  return prisma.trashSpot.create({
    data: {
      ...spotData,
      location: { create: location },
      registeredBy: { connect: { id: userId } },
    },
    include: { location: true },
  });
}

export async function getSpotById(id: number) {
  return prisma.trashSpot.findUnique({
    where: { id },
    include: { location: true },
  });
}

export async function updateSpot(id: number, data: SpotUpdateInput) {
  const { location, ...spotData } = data;

  const updateData: Record<string, unknown> = { ...spotData };
  if (location) {
    updateData.location = { update: location };
  }

  return prisma.trashSpot.update({
    where: { id },
    data: updateData,
    include: { location: true },
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
