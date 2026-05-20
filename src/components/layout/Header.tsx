import LogoutButton from './LogoutButton'

type Props = {
  profile: {
    full_name: string | null
    email: string
    status: string
  }
}

export default function Header({ profile }: Props) {
  return (
    <header className="border-b p-4 flex items-center justify-between">
      <div>
        <h1 className="font-bold text-xl">
          Pless Education
        </h1>
      </div>

      <div className="flex items-center gap-4">
        <div className="text-sm text-right">
          <p>{profile.full_name ?? 'Usuario'}</p>
          <p className="text-gray-500">
            {profile.email}
          </p>
        </div>

        <LogoutButton />
      </div>
    </header>
  )
}