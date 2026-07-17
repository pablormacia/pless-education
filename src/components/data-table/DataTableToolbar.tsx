'use client'

import { X } from 'lucide-react'

import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'

import type { DataTableToolbarProps } from './types'


export function DataTableToolbar<TData>({
  table,
}: DataTableToolbarProps<TData>) {

  const isFiltered =
    table.getState().globalFilter ||
    table.getState().columnFilters.length > 0


  return (
    <div className="flex items-center justify-between gap-2">

      <div className="flex flex-1 items-center gap-2">

        <Input
          placeholder="Buscar..."
          value={
            (table.getState().globalFilter as string) ?? ''
          }
          onChange={(event) =>
            table.setGlobalFilter(event.target.value)
          }
          className="max-w-sm"
        />


        {isFiltered && (

          <Button
            variant="ghost"
            onClick={() => {
              table.resetGlobalFilter()
              table.resetColumnFilters()
            }}
          >
            Limpiar

            <X />
          </Button>

        )}

      </div>

    </div>
  )
}