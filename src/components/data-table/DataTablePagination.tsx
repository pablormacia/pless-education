'use client'

import {
  ChevronLeft,
  ChevronRight,
} from 'lucide-react'

import { Button } from '@/components/ui/button'

import type { DataTablePaginationProps } from './types'


export function DataTablePagination<TData>({
  table,
}: DataTablePaginationProps<TData>) {

  return (
    <div className="flex items-center justify-between px-2">

      <div className="text-sm text-muted-foreground">
        {table.getFilteredSelectedRowModel().rows.length} seleccionados de{' '}
        {table.getFilteredRowModel().rows.length} registros.
      </div>


      <div className="flex items-center gap-2">

        <Button
          variant="outline"
          size="sm"
          onClick={() =>
            table.previousPage()
          }
          disabled={
            !table.getCanPreviousPage()
          }
        >
          <ChevronLeft />
          Anterior
        </Button>


        <span className="text-sm">
          Página{' '}
          {table.getState().pagination.pageIndex + 1}
          {' '}de{' '}
          {table.getPageCount()}
        </span>


        <Button
          variant="outline"
          size="sm"
          onClick={() =>
            table.nextPage()
          }
          disabled={
            !table.getCanNextPage()
          }
        >
          Siguiente
          <ChevronRight />
        </Button>

      </div>

    </div>
  )
}