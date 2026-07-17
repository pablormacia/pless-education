'use client'

import { DataTable } from '@/components/data-table'

import { columns } from '../table/columns'

import type { Person } from '../types'

type Props = {
  people: Person[]
}

export default function PeopleTable({
  people,
}: Props) {
  return (
    <DataTable
      columns={columns}
      data={people}
    />
  )
}