import { ReactNode } from 'react'

import { getUserContext } from '@/lib/auth/getUserContext'

import AppShell from '@/components/layout/AppShell'

export default async function DashboardLayout({
  children,
}: {
  children: ReactNode
}) {
  const { profile, permissions } =
    await getUserContext()

  return (
    <AppShell
      profile={profile}
      permissions={permissions}
    >
      {children}
    </AppShell>
  )
}