import { z } from "zod";

const stayDuration = z.enum([
  "UP_TO_5_DAYS",
  "SEVERAL_WEEKS",
  "SEVERAL_MONTHS",
]);
const vegetation = z.enum(["NONE", "LOW", "TALL"]);
const water = z.enum(["ABUNDANT", "FRESH", "BRACKISH", "NONE"]);
const soil = z.enum(["FERTILE", "ROCKY", "COMPACT"]);
const terrain = z.enum(["FLAT", "STEEP", "INACCESSIBLE"]);
const animals = z.enum(["VARIOUS", "FLIES", "HORSES", "PIGS"]);
const climate = z.enum([
  "TROPICAL",
  "TEMPERATE",
  "ARCTIC",
  "UNKNOWN",
  "NO_RESPONSE",
]);
const disposal = z.enum(["TRASH_BINS_AVAILABLE"]);

export const spotSchema = z.object({
  name: z.string().min(1, "Nome é obrigatório"),
  location: z.string().min(1, "Endereço é obrigatório"),
  description: z.string().optional(),
  stayDuration: stayDuration.optional(),
  vegetation: vegetation.optional(),
  terrain: terrain.optional(),
  climate: climate.optional(),
  water: z.array(water).optional(),
  soil: z.array(soil).optional(),
  animals: z.array(animals).optional(),
  disposal: z.array(disposal).optional(),
});

export type SpotInput = z.infer<typeof spotSchema>;

export const spotUpdateSchema = spotSchema
  .partial()
  .refine((data) => Object.keys(data).length > 0, {
    message: "É preciso informar ao menos um campo para atualizar",
  });
