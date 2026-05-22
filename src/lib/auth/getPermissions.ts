import { createClient } from '@/lib/supabase/server'

export async function getPermissions(userId: string) {
  const supabase = await createClient()

  const { data, error } = await supabase
    .from('user_roles')
    .select(`
      role:roles (
        role_permissions (
          permission:permissions (
            code
          )
        )
      )
    `)
    .eq('user_id', userId)

  if (error || !data) {
    return []
  }

  const permissions = data.flatMap((item: any) =>
    item.role?.role_permissions?.map(
      (rp: any) => rp.permission.code
    ) ?? []
  )

  return [...new Set(permissions)]
}