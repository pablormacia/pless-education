// lib/auth/getAllPermissions.ts

import { createClient } from '@/lib/supabase/server'

export async function getAllPermissions() {
  const supabase = await createClient()

  const { data, error } = await supabase
    .from('permissions')
    .select('code')

  if (error) {
    throw error
  }

  return data.map(permission => permission.code)
}