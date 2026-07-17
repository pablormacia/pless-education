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
  toolbar,
  emptyMessage = "No hay registros.",
  loading
}: DataTableProps<TData, TValue>) {
  /**
   * Estado del ordenamiento.
   */
  const [sorting, setSorting] = useState<SortingState>([]);

  /**
   * Estado de visibilidad de columnas.
   */
  const [columnVisibility, setColumnVisibility] = useState<VisibilityState>({});

  /**
   * Creamos la instancia de TanStack.
   */
  const table = useReactTable({
    data,
    columns,

    state: {
      sorting,
      columnVisibility,
    },

    onSortingChange: setSorting,

    onColumnVisibilityChange: setColumnVisibility,

    getCoreRowModel: getCoreRowModel(),

    getSortedRowModel: getSortedRowModel(),

    getPaginationRowModel: getPaginationRowModel(),

    getFilteredRowModel: getFilteredRowModel(),
  });

  return (
    <div className="space-y-4">
      {showToolbar && (toolbar ?? <DataTableToolbar table={table} />)}

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
              <DataTableLoading rows={5} columns={columns.length} />
            ) : table.getRowModel().rows.length ? (
              table.getRowModel().rows.map((row) => (
                <TableRow key={row.id}>
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
              <DataTableEmpty message={emptyMessage} colSpan={columns.length} />
            )}
          </TableBody>
        </Table>
      </div>

      {showPagination && <DataTablePagination table={table} />}
    </div>
  );
}
