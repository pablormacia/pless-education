export type PersonStatus =
  | 'active'
  | 'inactive'
  | 'archived'

export interface Person {
  id: string

  firstName: string
  lastName: string

  documentNumber: string | null

  status: PersonStatus | null
}