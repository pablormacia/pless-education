import { createClient } from '@/lib/supabase/server'
import { Person } from './types'


export async function getPeople(): Promise<Person[]> {

  const supabase = await createClient()


  const {
    data,
    error,
  } = await supabase
    .from('people')
    .select(`
      id,
      first_name,
      last_name,
      document_number,
      status
    `)
    .order('last_name')
    .order('first_name')


  if (error) {
    throw new Error(error.message)
  }


  return data ?? []
}