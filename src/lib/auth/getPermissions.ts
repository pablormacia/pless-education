import { createClient } from '@/lib/supabase/server'

export async function getPermissions(personId: string) {
  const supabase = await createClient()

  const { data, error } = await supabase
    .from('person_roles')
    .select(`
      role:roles (
        role_permissions (
          permission:permissions (
            code
          )
        )
      )
    `)
    .eq('person_id', personId)

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