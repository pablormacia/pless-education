import {
  TableCell,
  TableRow,
} from '@/components/ui/table'

import type { DataTableEmptyProps } from './types'


export function DataTableEmpty({
  message = 'No hay registros.',
  colSpan = 1,
}: DataTableEmptyProps) {

  return (
    <TableRow>

      <TableCell
        colSpan={colSpan}
        className="h-24 text-center text-muted-foreground"
      >
        {message}
      </TableCell>

    </TableRow>
  )
}