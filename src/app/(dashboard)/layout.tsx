import { ReactNode } from 'react'

import { getUserContext }
  from '@/lib/auth/getUserContext'

import AppShell
  from '@/components/layout/AppShell'

type Props = {
  children: ReactNode
}

export default async function DashboardLayout({
  children,
}: Props) {
  const {
    person,
    authAccount,
    permissions,
  } = await getUserContext()

  return (
    <AppShell
      person={person}
      authAccount={authAccount}
      permissions={permissions}
    >
      {children}
    </AppShell>
  )
}