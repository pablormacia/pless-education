import Link from 'next/link'
import { navigation } from '@/config/navigation'

type Props = {
  permissions: string[]
}

export default function Sidebar({
  permissions,
}: Props) {
  const visibleItems = navigation.filter(item =>
    item.permissions.every(permission =>
      permissions.includes(permission)
    )
  )

  return (
    <aside className="w-64 border-r min-h-screen p-4">
      <div className="mb-8">
        <h2 className="font-bold text-xl">
          Pless
        </h2>
      </div>

      <nav className="space-y-2">
        {visibleItems.map(item => {
          const Icon = item.icon

          return (
            <Link
              key={item.href}
              href={item.href}
              className="
                flex items-center gap-3
                rounded-lg px-3 py-2
                hover:bg-gray-100
              "
            >
              <Icon size={18} />

              <span>{item.label}</span>
            </Link>
          )
        })}
      </nav>
    </aside>
  )
}