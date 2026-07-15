export type Person = {
  id: string
  first_name: string
  last_name: string
  document_number: string | null
  status: 'active' | 'inactive' | 'archived'
}