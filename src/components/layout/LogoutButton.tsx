'use client'

import { logout } from '@/app/(auth)/login/actions'

export default function LogoutButton() {
  return (
    <form action={logout}>
      <button
        className="border rounded px-3 py-1"
      >
        Cerrar sesión
      </button>
    </form>
  )
}