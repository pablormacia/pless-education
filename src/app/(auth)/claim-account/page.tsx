export default function ClaimAccountPage() {
  return (
    <main className="max-w-md mx-auto py-20">
      <h1 className="text-2xl font-bold mb-6">
        Vincular cuenta
      </h1>

      <form className="space-y-4">
        <input
          type="text"
          name="document"
          placeholder="DNI"
          className="w-full border rounded-lg p-3"
        />

        <input
          type="text"
          name="lastName"
          placeholder="Apellido"
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