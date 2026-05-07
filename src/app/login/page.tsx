import { login, loginWithGoogle } from './actions'

export default function LoginPage() {
  return (
    <main className="flex min-h-screen items-center justify-center">
      <div className="w-full max-w-sm space-y-4">
        <h1 className="text-2xl font-bold">
          Pless Education
        </h1>

        <form action={login} className="space-y-4">
          <input
            name="email"
            type="email"
            placeholder="Email"
            className="w-full rounded border p-2"
            required
          />

          <input
            name="password"
            type="password"
            placeholder="Password"
            className="w-full rounded border p-2"
            required
          />

          <button
            type="submit"
            className="w-full rounded border p-2"
          >
            Login
          </button>
        </form>

        <form action={loginWithGoogle}>
          <button
            type="submit"
            className="w-full rounded border p-2"
          >
            Continue with Google
          </button>
        </form>
      </div>
    </main>
  )
}