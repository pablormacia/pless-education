export default function ClaimAccountPage() {
  return (
    <main className="max-w-md mx-auto py-20">
      <h1 className="text-2xl font-bold mb-6">
        Activar cuenta
      </h1>
      <form className="space-y-4">
        <label htmlFor="document" className="block text-sm font-medium text-gray-700">
          DNI
        </label>
        
        
        <input
          type="text"
          name="document"
          placeholder="DNI"
          className="w-full border rounded-lg p-3"
        />
        <label htmlFor="lastName" className="block text-sm font-medium text-gray-700">
          Apellido
        </label>
        <input
          type="text"
          name="lastName"
          placeholder="Apellido"
          className="w-full border rounded-lg p-3"
        />
        <label htmlFor="birthDate" className="block text-sm font-medium text-gray-700">
          Fecha de nacimiento
        </label>
        <input
          type="date"
          name="birthDate"
          placeholder="Fecha de nacimiento"
          className="w-full border rounded-lg p-3"
        />

        <button
          className="
            w-full rounded-lg bg-black
            text-white py-3
          "
        >
          Continuar
        </button>
      </form>
    </main>
  )
}