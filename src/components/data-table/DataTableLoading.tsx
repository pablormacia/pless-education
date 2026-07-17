import {
  TableCell,
  TableRow,
} from '@/components/ui/table'

import type { DataTableLoadingProps } from './types'

import { Skeleton } from '@/components/ui/skeleton'


export function DataTableLoading({
  rows = 5,
  columns = 1,
}: DataTableLoadingProps) {

  return (
    <>
      {Array.from({ length: rows }).map((_, index) => (

        <TableRow key={index}>

          {Array.from({ length: columns }).map((_, columnIndex) => (

            <TableCell key={columnIndex}>

              <Skeleton className="h-4 w-full" />

            </TableCell>

          ))}

        </TableRow>

      ))}
    </>
  )
}