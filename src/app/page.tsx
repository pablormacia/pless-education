import Link from 'next/link'

export default function HomePage() {
  return (
    <main className="min-h-screen flex flex-col items-center justify-center gap-4">
      <h1 className="text-4xl font-bold">
        Pless Education
      </h1>

      <p className="text-gray-600">
        Plataforma de gestión educativa
      </p>

      <Link
        href="/login"
        className="border rounded px-4 py-2"
      >
        Iniciar sesión
      </Link>
    </main>
  )
}