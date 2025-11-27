import { z } from "zod";

export const collectionSpotSchema = z.object({
  name: z.string().min(1, "Nome obrigatorio"),
  email: z.string().email("Email invalido"),
  location: z.string().min(1, "Localizacao obrigatoria"),
});

export type CollectionSpotInput = z.infer<typeof collectionSpotSchema>;

export const collectionSpotUpdateSchema = collectionSpotSchema
  .partial()
  .refine((data) => Object.keys(data).length > 0, {
    message: "Informe pelo menos um campo para atualizar",
  });
