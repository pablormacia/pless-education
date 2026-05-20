export default function PendingPage() {
  return (
    <main className="min-h-screen flex items-center justify-center p-6">
      <div className="max-w-md text-center space-y-4">
        <h1 className="text-2xl font-bold">
          Cuenta pendiente de validación
        </h1>

        <p className="text-gray-600">
          Tu cuenta fue creada correctamente,
          pero todavía no fue habilitada
          por un administrador.
        </p>

        <p className="text-gray-600">
          Si creés que esto es un error,
          comunicate con:
        </p>

        <p className="font-medium">
          soporte@pless.education
        </p>
      </div>
    </main>
  )
}