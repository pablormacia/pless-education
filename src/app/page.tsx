"use client";

import { useState } from "react";
import { createClient } from "@/lib/supabase/client";

export default function Home() {
  const [result, setResult] = useState("Sin verificar");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);

  async function handleLogin() {
    setLoading(true);
    setResult("");

    const supabase = createClient();

    try {
      const { error } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (error) {
        setResult(`Error: ${error.message}`);
        return;
      }

      setResult("Inicio de sesión correcto");
    } catch {
      setResult("No se pudo completar la solicitud");
    } finally {
      setLoading(false);
    }
  }

  return (
    <main>
      <h1>Pless Education</h1>

      <input
        type="email"
        placeholder="Correo electrónico"
        autoComplete="username"
        value={email}
        onChange={(event) => setEmail(event.target.value)}
      />

      <input
        type="password"
        placeholder="Contraseña"
        autoComplete="current-password"
        value={password}
        onChange={(event) => setPassword(event.target.value)}
      />

      <button type="button" onClick={handleLogin} disabled={loading}>
        {loading ? "Ingresando..." : "Iniciar sesión"}
      </button>

      <output>{result}</output>
    </main>
  );
}
