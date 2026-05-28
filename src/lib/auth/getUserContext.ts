import { redirect } from 'next/navigation'

import { getSessionUser } from './getSessionUser'
import { getPermissions } from './getPermissions'

export async function getUserContext() {
  const session = await getSessionUser()

  if (!session?.user) {
    redirect('/login')
  }

  const { user, authAccount, person } = session

  // Usuario autenticado
  // pero todavía no vinculó identidad institucional
  if (!authAccount) {
    redirect('/claim-account')
  }

  // Auth account sin persona vinculada
  if (!person) {
    redirect('/claim-account')
  }

  // Estados acceso digital
  if (authAccount.status === 'pending_validation') {
    redirect('/pending')
  }

  if (authAccount.status === 'blocked') {
    redirect('/blocked')
  }

  if (authAccount.status !== 'active') {
    redirect('/login')
  }

  const permissions = await getPermissions(
    person.id
  )

  return {
    user,
    authAccount,
    person,
    permissions,
  }
}