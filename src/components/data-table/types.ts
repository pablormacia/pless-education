import type {
  ColumnDef,
  PaginationState,
  SortingState,
  VisibilityState,
  Table,
  Column
} from '@tanstack/react-table'
import type { ReactNode } from 'react'

export interface DataTableProps<TData, TValue = unknown> {
  /**
   * Columnas de TanStack.
   */
  columns: ColumnDef<TData, TValue>[]

  /**
   * Datos a mostrar.
   */
  data: TData[]

  /**
   * Muestra el toolbar superior.
   *
   * Default: true
   */
  showToolbar?: boolean

  /**
   * Muestra la paginación.
   *
   * Default: true
   */
  showPagination?: boolean

  /**
   * Toolbar personalizado.
   */
  toolbarContent?: ReactNode

  /**
   * Mensaje cuando no existen registros.
   */
  emptyMessage?: string

  /**
   * Estado de carga.
   */
  loading?: boolean
}

export interface DataTableState {
  sorting: SortingState
  columnVisibility: VisibilityState
  pagination: PaginationState
}

export interface DataTableToolbarProps<TData> {
  table: Table<TData>
}

export interface DataTableColumnHeaderProps<TData, TValue>
{
  column: Column<TData, TValue>
  title: string
}

export interface DataTablePaginationProps<TData> {
  table: Table<TData>
}

export interface DataTableViewOptionsProps<TData> {
  table: Table<TData>
}

export interface DataTableEmptyProps {
  message?: string
  colSpan?: number
}

export interface DataTableLoadingProps {
  rows?: number
  columns?: number
}