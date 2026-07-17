'use client'

import type { ColumnDef } from '@tanstack/react-table'

import { DataTableColumnHeader } from '@/components/data-table'

import type { Person } from '../types'

export const columns: ColumnDef<Person>[] = [
  {
    accessorKey: 'firstName',
    header: ({ column }) => (
      <DataTableColumnHeader
        column={column}
        title="Nombre"
      />
    ),
    cell: ({ row }) => {
      const person = row.original

      return (
        <div className="font-medium">
          {person.firstName} {person.lastName}
        </div>
      )
    },
  },
  {
    accessorKey: 'documentNumber',
    header: ({ column }) => (
      <DataTableColumnHeader
        column={column}
        title="Documento"
      />
    ),
    cell: ({ getValue }) => getValue<string | null>() ?? '-',
  },
  {
    accessorKey: 'status',
    header: ({ column }) => (
      <DataTableColumnHeader
        column={column}
        title="Estado"
      />
    ),
  },
]