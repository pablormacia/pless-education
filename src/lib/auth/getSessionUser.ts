import { createClient } from '@/lib/supabase/server'

export async function getSessionUser() {
  const supabase = await createClient()

  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    return null
  }

  const { data: authAccount } = await supabase
    .from('auth_accounts')
    .select(`
      *,
      person:people (*)
    `)
    .eq('auth_user_id', user.id)
    .single()

  return {
    user,
    authAccount,
    person: authAccount?.person ?? null,
  }
}