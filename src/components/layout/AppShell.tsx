import { ReactNode } from 'react'
import Sidebar from './Sidebar'
import Header from './Header'

type Props = {
  children: ReactNode
  profile: any
  permissions: string[]
}

export default function AppShell({
  children,
  profile,
  permissions,
}: Props) {
  return (
    <div className="flex">
      <Sidebar permissions={permissions} />

      <div className="flex-1">
        <Header profile={profile} />

        <main className="p-6">
          {children}
        </main>
      </div>
    </div>
  )
}