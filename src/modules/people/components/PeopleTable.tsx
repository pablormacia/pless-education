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
              {person.first_name}
              {' '}
              {person.last_name}
            </td>


            <td>
              {person.document_number ?? '-'}
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