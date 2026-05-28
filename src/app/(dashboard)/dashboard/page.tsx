import { getUserContext }
  from '@/lib/auth/getUserContext'

export default async function DashboardPage() {
  const {
    person,
    authAccount,
    permissions,
  } = await getUserContext()

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold">
          Dashboard
        </h1>

        <p className="text-sm text-gray-500">
          Bienvenido a Pless Education
        </p>
      </div>

      <section className="rounded-lg border p-4">
        <h2 className="mb-4 text-lg font-semibold">
          Información de usuario
        </h2>

        <div className="space-y-2 text-sm">
          <p>
            <span className="font-medium">
              Nombre:
            </span>{' '}
            {person.first_name} {person.last_name}
          </p>

          <p>
            <span className="font-medium">
              Email:
            </span>{' '}
            {authAccount.email}
          </p>

          <p>
            <span className="font-medium">
              Estado:
            </span>{' '}
            {authAccount.status}
          </p>

          <p>
            <span className="font-medium">
              Escuela:
            </span>{' '}
            {person.school_id}
          </p>
        </div>
      </section>

      <section className="rounded-lg border p-4">
        <h2 className="mb-4 text-lg font-semibold">
          Permisos
        </h2>

        <div className="flex flex-wrap gap-2">
          {permissions.map((permission) => (
            <span
              key={permission}
              className="rounded-md border px-2 py-1 text-xs"
            >
              {permission}
            </span>
          ))}
        </div>
      </section>
    </div>
  )
}