// lib/auth/hasSystemRole.ts

import { createClient } from '@/lib/supabase/server'

export async function hasSystemRole(personId: string) {
  const supabase = await createClient()

  const { data } = await supabase
    .from('person_roles')
    .select(`
      roles (
        type
      )
    `)
    .eq('person_id', personId)

  return (
    data?.some(
      role =>
        (role.roles as any)?.type === 'system'
    ) ?? false
  )
}