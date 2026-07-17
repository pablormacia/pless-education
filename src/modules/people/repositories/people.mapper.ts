import type { Person } from '../types'

type PersonRow = {
  id: string
  first_name: string
  last_name: string
  document_number: string | null
  status: Person['status']
}

export function mapPerson(row: PersonRow): Person {
  return {
    id: row.id,
    firstName: row.first_name,
    lastName: row.last_name,
    documentNumber: row.document_number,
    status: row.status,
  }
}