"use client";

import {
  flexRender,
  getCoreRowModel,
  getPaginationRowModel,
  getSortedRowModel,
  SortingState,
  useReactTable,
  VisibilityState,
  getFilteredRowModel,
  ColumnFiltersState,
} from "@tanstack/react-table";

import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

import { useState } from "react";

import { DataTablePagination } from "./DataTablePagination";
import { DataTableToolbar } from "./DataTableToolbar";
import { DataTableEmpty } from "./DataTableEmpty";
import type { DataTableProps } from "./types";
import { DataTableLoading } from "./DataTableLoading";

export function DataTable<TData, TValue = unknown>({
  columns,
  data,
  showToolbar = true,
  showPagination = true,
  toolbarContent,
  emptyMessage = "No hay registros.",
  loading = false
}: DataTableProps<TData, TValue>) {
  /**
   * Estado del ordenamiento.
   */
  const [sorting, setSorting] = useState<SortingState>([]);

  /**
   * Estado de visibilidad de columnas.
   */
  const [columnVisibility, setColumnVisibility] = useState<VisibilityState>({});

  const [columnFilters, setColumnFilters] = useState<ColumnFiltersState>([]);

  const [rowSelection, setRowSelection] = useState({});

  /**
   * Creamos la instancia de TanStack.
   */
  const table = useReactTable({
    data,
    columns,

    state: {
      sorting,
      columnVisibility,
      columnFilters,
    },

    onSortingChange: setSorting,

    onColumnVisibilityChange: setColumnVisibility,

    onColumnFiltersChange: setColumnFilters,

    getCoreRowModel: getCoreRowModel(),

    getSortedRowModel: getSortedRowModel(),

    getPaginationRowModel: getPaginationRowModel(),

    getFilteredRowModel: getFilteredRowModel(),
  });

  return (
    <div className="space-y-4">
      {showToolbar && (toolbarContent ?? <DataTableToolbar table={table} />)}

      <div className="rounded-md border">
        <Table>
          <TableHeader>
            {table.getHeaderGroups().map((headerGroup) => (
              <TableRow key={headerGroup.id}>
                {headerGroup.headers.map((header) => (
                  <TableHead key={header.id}>
                    {header.isPlaceholder
                      ? null
                      : flexRender(
                          header.column.columnDef.header,
                          header.getContext(),
                        )}
                  </TableHead>
                ))}
              </TableRow>
            ))}
          </TableHeader>

          <TableBody>
            {loading ? (
              <DataTableLoading rows={5} columns={table.getVisibleLeafColumns().length} />
            ) : table.getRowModel().rows.length ? (
              table.getRowModel().rows.map((row) => (
                <TableRow
                  key={row.id}
                  data-state={row.getIsSelected() && "selected"}
                >
                  {row.getVisibleCells().map((cell) => (
                    <TableCell key={cell.id}>
                      {flexRender(
                        cell.column.columnDef.cell,
                        cell.getContext(),
                      )}
                    </TableCell>
                  ))}
                </TableRow>
              ))
            ) : (
              <DataTableEmpty message={emptyMessage} colSpan={table.getVisibleLeafColumns().length} />
            )}
          </TableBody>
        </Table>
      </div>

      {showPagination && <DataTablePagination table={table} />}
    </div>
  );
}
