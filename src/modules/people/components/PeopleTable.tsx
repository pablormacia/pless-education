import { Person }
  from '../types'


type Props = {
  people: Person[]
}


export default function PeopleTable({
  people,
}: Props) {


  return (
    <table className="w-full">

      <thead>
        <tr>
          <th>
            Nombre
          </th>

          <th>
            Documento
          </th>

          <th>
            Estado
          </th>
        </tr>
      </thead>


      <tbody>

        {people.map(person => (

          <tr key={person.id}>

            <td>
              {person.firstName}
              {' '}
              {person.lastName}
            </td>


            <td>
              {person.documentNumber ?? '-'}
            </td>


            <td>
              {person.status}
            </td>

          </tr>

        ))}

      </tbody>

    </table>
  )
}