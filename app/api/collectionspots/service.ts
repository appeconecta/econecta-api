import prisma from "@/lib/prisma";

import { CollectionSpotInput } from "./validation";

export async function listCollectionSpots() {
  return prisma.collectionSpots.findMany();
}

export async function createCollectionSpot(
  data: CollectionSpotInput,
  userId: string
) {
  return prisma.collectionSpots.create({
    data: {
      ...data,
      registeredById: userId,
    },
  });
}

export async function getCollectionSpotById(id: number) {
  return prisma.collectionSpots.findUnique({ where: { id } });
}

export async function updateCollectionSpot(
  id: number,
  data: Partial<CollectionSpotInput>
) {
  return prisma.collectionSpots.update({
    where: { id },
    data,
  });
}

export async function deleteCollectionSpot(id: number) {
  return prisma.collectionSpots.delete({ where: { id } });
}
