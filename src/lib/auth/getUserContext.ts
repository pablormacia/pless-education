import { redirect } from 'next/navigation'
import { getSessionUser } from './getSessionUser'

export async function getUserContext() {
  const session = await getSessionUser()

  if (!session?.user || !session.profile) {
    redirect('/login')
  }

  const { user, profile } = session

  if (profile.status === 'pending') {
    redirect('/pending')
  }

  if (profile.status === 'blocked') {
    redirect('/blocked')
  }

  if (profile.status !== 'active') {
    redirect('/login')
  }

  return {
    user,
    profile,
  }
}