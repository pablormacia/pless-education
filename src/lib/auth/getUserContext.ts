import { redirect } from 'next/navigation'

import { getSessionUser } from './getSessionUser'
import { getPermissions } from './getPermissions'
import { getAllPermissions } from './getAllPermissions'
import { hasSystemRole } from './hasSystemRole'

export async function getUserContext() {
  const session = await getSessionUser()

  if (!session?.user) {
    redirect('/login')
  }

  const { user, authAccount, person } = session

  if (!authAccount) {
    redirect('/claim-account')
  }

  if (!person) {
    redirect('/claim-account')
  }

  switch (authAccount.status) {
    case 'pending_claim':
      redirect('/claim-account')

    case 'pending_validation':
      redirect('/pending')

    case 'blocked':
      redirect('/blocked')

    case 'active':
      break

    default:
      redirect('/login')
  }

  const isSystem = await hasSystemRole(person.id)

  const permissions = isSystem
    ? await getAllPermissions()
    : await getPermissions(person.id)

  return {
    user,
    authAccount,
    person,
    permissions,
  }
}