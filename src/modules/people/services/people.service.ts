import { getPeople as getPeopleRepository } from '../repositories/people.repository'

export async function getPeople() {
  return getPeopleRepository()
}