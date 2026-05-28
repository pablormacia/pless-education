# Authentication Flow

## Tecnologías

- Next.js App Router
- Supabase Auth
- Supabase SSR
- OAuth Authorization Code Flow
- Server Components
- Route Handlers

---

# Arquitectura de autenticación

La aplicación separa:

## Identidad institucional

Representada por:

```txt
people
```

Contiene:
- nombre
- apellido
- DNI
- escuela
- información institucional

---

## Cuenta de autenticación

Representada por:

```txt
auth_accounts
```

Contiene:
- usuario Supabase Auth
- email login
- estado acceso
- método vinculación
- sesión

---

# Flujo general de autenticación

1. Usuario inicia sesión.
2. Supabase autentica usuario.
3. Se obtiene `auth.users`.
4. El sistema busca `auth_accounts`.
5. Se valida vinculación con `people`.
6. Se evalúa estado acceso.
7. Se generan cookies SSR.
8. Usuario accede al sistema.

---

# Login email/password

1. Usuario ingresa credenciales.
2. Supabase autentica usuario.
3. Se crea sesión SSR.
4. Se buscan datos institucionales.
5. Se validan permisos y estado.
6. Se redirige según corresponda.

---

# Login Google OAuth

1. Usuario selecciona Google.
2. Supabase inicia OAuth.
3. Google autentica usuario.
4. Supabase redirige a:

```txt
/auth/callback
```

5. El callback ejecuta:

```ts
exchangeCodeForSession()
```

6. Se crean cookies SSR.
7. Se valida cuenta institucional.
8. Usuario ingresa al sistema.

---

# Route Handler OAuth

Archivo:

```txt
app/auth/callback/route.ts
```

Responsabilidades:
- recibir `code`
- intercambiar sesión OAuth
- crear cookies SSR
- redireccionar usuario

---

# Estados de acceso

Los estados pertenecen a:

```txt
auth_accounts.status
```

---

## pending_claim

La cuenta existe en Auth pero aún no fue vinculada a una persona institucional.

Redirige a:

```txt
/claim
```

---

## pending_validation

La cuenta fue vinculada pero requiere validación manual.

Redirige a:

```txt
/pending
```

---

## active

Acceso normal al sistema.

---

## blocked

Acceso bloqueado.

Redirige a:

```txt
/blocked
```

---

# Estados institucionales

Separados de autenticación.

Pertenecen a:

```txt
people.status
```

Ejemplos:
- active
- inactive
- archived
- graduated

Estos estados representan la situación institucional de la persona y NO el acceso digital.

---

# Session Context

La aplicación utiliza dos capas:

---

## getSessionUser()

Obtiene:
- auth user
- auth account
- person

No realiza:
- redirects
- validaciones negocio
- autorización

Se utiliza como capa base de sesión.

---

## getUserContext()

Obtiene:
- person
- authAccount
- permissions

Aplica:
- validaciones
- redirects
- control acceso
- autorización

Es la principal entrada para rutas protegidas.

---

# Layouts protegidos

Las rutas autenticadas utilizan:

```txt
app/(dashboard)/layout.tsx
```

Este layout:
- valida sesión
- obtiene contexto usuario
- obtiene permisos
- monta AppShell
- protege navegación

---

# SSR Authentication

La aplicación utiliza autenticación SSR.

Clientes separados:

## Browser Client

```txt
lib/supabase/client.ts
```

Usado en:
- Client Components
- browser auth
- realtime
- interacciones cliente

---

## Server Client

```txt
lib/supabase/server.ts
```

Usado en:
- Server Components
- Route Handlers
- Server Actions
- layouts protegidos

---

# Ventajas del enfoque SSR

- cookies seguras httpOnly
- protección server-side
- layouts protegidos
- mejor SEO
- menos exposición tokens
- control centralizado acceso

---

# Permisos y roles

La autorización se desacopla de autenticación.

Modelo:

```txt
people
→ person_roles
→ roles
→ role_permissions
→ permissions
```

Esto permite:
- múltiples roles
- permisos granulares
- scopes
- crecimiento modular

---

# Scope de roles

Los roles pueden limitarse mediante:

```txt
scope_type
scope_value
```

Ejemplos:
- director secundario
- docente nivel inicial
- mantenimiento edificio A

---

# Objetivo arquitectónico

Separar claramente:

- identidad institucional
- autenticación
- autorización
- permisos
- contexto organizacional

para permitir:
- escalabilidad
- multi institución
- auditoría
- control granular acceso
- crecimiento modular