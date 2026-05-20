import { getUserContext } from '@/lib/auth/getUserContext'

export default async function DashboardPage() {
  const { profile } = await getUserContext()

  return (
    <div>
      <h1 className="text-2xl font-bold">
        Dashboard
      </h1>

      <pre className="mt-4">
        {JSON.stringify(profile, null, 2)}
      </pre>
    </div>
  )
}