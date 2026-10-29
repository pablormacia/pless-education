import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

export default async function AdminPage() {
  const supabase = await createClient();

  const {
    data: { user },
    error,
  } = await supabase.auth.getUser();

  if (error || !user) {
    redirect("/");
  }

  return (
    <main>
      <h1>Pless Education - Administración</h1>
      <p>Usuario autenticado: {user.email}</p>
    </main>
  );
}
