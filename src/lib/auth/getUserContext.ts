import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'

export async function getUserContext() {
  const supabase = await createClient()

  const {
    data: { user },
  } = await supabase.auth.getUser()

  // no logueado
  if (!user) {
    redirect('/login')
  }

  // profile
  const { data: profile, error } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', user.id)
    .single()

  if (error || !profile) {
    throw new Error('Profile not found')
  }

  // estados
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