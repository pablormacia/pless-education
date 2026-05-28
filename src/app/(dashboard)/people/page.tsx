export default function PeoplePage() {
  return (
    <div>
      <div className="flex items-center justify-between mb-8">
        <h1 className="text-3xl font-bold">
          Personas
        </h1>

        <button
          className="
            rounded-lg bg-black
            text-white px-4 py-2
          "
        >
          Nueva persona
        </button>
      </div>

      <div className="border rounded-2xl p-6">
        Lista de personas
      </div>
    </div>
  )
}