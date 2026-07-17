'use client'

import {
  ArrowDown,
  ArrowUp,
  ChevronsUpDown,
} from 'lucide-react'

import { Button } from '@/components/ui/button'

import type { DataTableColumnHeaderProps } from './types'


export function DataTableColumnHeader<
  TData,
  TValue
>({
  column,
  title,
}: DataTableColumnHeaderProps<TData, TValue>) {

  const sorted = column.getIsSorted()


  if (!column.getCanSort()) {
    return (
      <div>
        {title}
      </div>
    )
  }


  return (
    <Button
      variant="ghost"
      onClick={() =>
        column.toggleSorting(
          sorted === 'asc'
        )
      }
      className="-ml-3 h-8"
    >

      <span>
        {title}
      </span>


      {sorted === 'desc' ? (

        <ArrowDown />

      ) : sorted === 'asc' ? (

        <ArrowUp />

      ) : (

        <ChevronsUpDown />

      )}

    </Button>
  )
}