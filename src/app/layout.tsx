import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'Pless Education',
  description: 'Sistema de gestión educativa',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="es">
      <body>
        {children}
      </body>
    </html>
  )
}