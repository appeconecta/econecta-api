import { NextResponse } from "next/server";
import { z } from "zod";

import { deleteSpot, getSpotById, updateSpot } from "../service";
import { spotUpdateSchema } from "../validation";

const idParamSchema = z.object({
  id: z.coerce.number().int().positive(),
});

export async function PATCH(
  req: Request,
  { params }: { params: { id: string } }
) {
  try {
    const { id: rawId } = await params;

    const parsedId = idParamSchema.safeParse({ id: rawId });
    if (!parsedId.success) {
      return NextResponse.json({ error: "ID inválido" }, { status: 400 });
    }

    const body = await req.json();
    const parsedBody = spotUpdateSchema.safeParse(body);
    if (!parsedBody.success) {
      return NextResponse.json(
        { error: "Payload inválido", issues: parsedBody.error.format() },
        { status: 400 }
      );
    }

    const { id } = parsedId.data;

    const existing = await getSpotById(id);
    if (!existing) {
      return NextResponse.json(
        { error: "Foco de lixo não encontrado" },
        { status: 404 }
      );
    }

    const updated = await updateSpot(id, parsedBody.data);
    return NextResponse.json({ data: updated });
  } catch (error: unknown) {
    console.error("Erro ao atualizar foco de lixo", error);
    return NextResponse.json(
      { error: "Erro ao atualizar o foco de lixo" },
      { status: 500 }
    );
  }
}

export async function DELETE(
  _req: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { id: rawId } = await params;

    const parsedId = idParamSchema.safeParse({ id: rawId });
    if (!parsedId.success) {
      return NextResponse.json({ error: "ID inválido" }, { status: 400 });
    }

    const { id } = parsedId.data;

    const existing = await getSpotById(id);
    if (!existing) {
      return NextResponse.json(
        { error: "Foco de lixo não encontrado" },
        { status: 404 }
      );
    }

    await deleteSpot(id);
    return NextResponse.json({ success: true });
  } catch (error: unknown) {
    console.error("Erro ao deletar foco de lixo", error);
    return NextResponse.json(
      { error: "Erro ao deletar o foco de lixo" },
      { status: 500 }
    );
  }
}
