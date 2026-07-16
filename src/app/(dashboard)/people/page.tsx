import { getPeople }
  from '@/modules/people/queries'

import PeopleTable from '@/modules/people/components/PeopleTable'


export default async function PeoplePage() {

  const people = await getPeople()


  return (
    <main className="space-y-6">

      <header>
        <h1 className="text-3xl font-bold">
          Personas
        </h1>

        <p className="text-muted-foreground">
          Gestión de alumnos, familias y personal.
        </p>
      </header>


      <PeopleTable
        people={people}
      />

    </main>
  )
}