import LogoutButton from './LogoutButton'

import type { Database } from '@/types/supabase'

type Person =
  Database['public']['Tables']['people']['Row']

type AuthAccount =
  Database['public']['Tables']['auth_accounts']['Row']

type Props = {
  person: Person
  authAccount: AuthAccount
}

export default function Header({
  person,
  authAccount,
}: Props) {
  return (
    <header className="flex items-center justify-between border-b p-4">
      <div>
        <h1 className="text-xl font-bold">
          Pless Education
        </h1>
      </div>

      <div className="flex items-center gap-4">
        <div className="text-right text-sm">
          <p>
            {person.first_name} {person.last_name}
          </p>

          <p className="text-gray-500">
            {authAccount.email ?? 'Sin email'}
          </p>
        </div>

        <LogoutButton />
      </div>
    </header>
  )
}