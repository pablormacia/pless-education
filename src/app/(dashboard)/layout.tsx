import { ReactNode } from 'react'
import { getUserContext } from '@/lib/auth/getUserContext'
import Header from '@/components/layout/Header'

export default async function DashboardLayout({
  children,
}: {
  children: ReactNode
}) {
  const { profile } = await getUserContext()

  return (
    <>
      <Header profile={profile} />

      <main className="p-6">
        {children}
      </main>
    </>
  )
}