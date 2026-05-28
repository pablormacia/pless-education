# Pless Education

Pless Education es una plataforma de gestión educativa multi-tenant orientada a instituciones escolares.

El proyecto está siendo desarrollado con una arquitectura moderna basada en:

- Next.js App Router
- Supabase
- PostgreSQL
- SSR Authentication
- RBAC (Role-Based Access Control)

---

# Objetivos del proyecto

La plataforma busca centralizar distintos aspectos de la gestión institucional:

- Gestión de personas
- Gestión de usuarios
- Roles y permisos
- Comunicación institucional
- Gestión académica
- Mantenimiento
- Administración interna
- Seguimiento y auditoría

La arquitectura está diseñada desde el inicio para soportar múltiples instituciones educativas y crecimiento modular a largo plazo.

---

# Stack tecnológico

## Frontend

- Next.js
- React
- TypeScript
- Tailwind CSS

## Backend

- Supabase
- PostgreSQL
- Supabase Auth

## Arquitectura

- SSR Authentication
- OAuth Authorization Code Flow
- Route Handlers
- Server Actions
- Multi-tenant
- RBAC
- Server Components

---

# Estado actual del proyecto

## Implementado

---

## Autenticación

- Login con email/password
- Login con Google OAuth
- Callback OAuth SSR
- Logout
- Manejo de sesión SSR
- Cookies httpOnly
- OAuth Authorization Code Flow

---

## Modelo de identidad

Separación entre:

### Personas institucionales

```txt
people
```

Representa:
- alumnos
- docentes
- directivos
- padres
- personal

Contiene:
- identidad institucional
- DNI
- escuela
- datos personales

---

### Cuentas de autenticación

```txt
auth_accounts
```

Representa:
- acceso digital
- login
- vinculación auth
- estados acceso

---

## Estados de acceso

```txt
pending_claim
pending_validation
active
blocked
```

---

## Roles y permisos

Implementado:

```txt
roles
permissions
role_permissions
person_roles
```

Con soporte inicial para:
- múltiples roles
- permisos granulares
- scopes
- arquitectura extensible

---

## Navegación

- Sidebar dinámico
- Navegación basada en permisos
- Layout administrativo
- Layouts protegidos SSR

---

## Arquitectura

- Multi-tenant preparado desde el inicio
- Separación auth/persona
- Auth centralizada
- Route groups
- Server-side protection
- Contexto usuario tipado
- Tipos generados desde Supabase

---

# Arquitectura de autenticación

La aplicación separa:

## Identidad institucional

```txt
people
```

de:

## Acceso digital

```txt
auth_accounts
```

Esto permite:

- personas sin login
- validación institucional
- onboarding progresivo
- múltiples tipos de usuarios
- desacoplar identidad y acceso

---

# Flujo de autenticación

## Email/password

1. Usuario inicia sesión.
2. Supabase autentica.
3. Se crea sesión SSR.
4. Se obtiene contexto usuario.
5. Se validan estados y permisos.
6. Se redirige según autorización.

---

## Google OAuth

1. Usuario selecciona Google.
2. Supabase inicia OAuth.
3. Google autentica usuario.
4. Callback SSR ejecuta:

```ts
exchangeCodeForSession()
```

5. Se crean cookies SSR.
6. Se obtiene contexto institucional.
7. Se validan permisos y acceso.

---

# Gestión de personas

La arquitectura está preparada para soportar:

- usuarios con login
- personas sin login
- alumnos menores
- padres vinculados
- personal institucional
- múltiples roles por persona

La autenticación se vincula posteriormente a registros institucionales mediante:

- DNI
- apellido
- validaciones manuales

---

# Multi-tenant

Cada institución educativa posee:

- school
- personas
- roles
- permisos
- configuraciones

La arquitectura está diseñada para:
- aislamiento institucional
- escalabilidad horizontal
- crecimiento modular
- soporte multi escuela

---

# Seguridad

El proyecto utiliza:

- SSR Authentication
- Cookies HTTP-only
- OAuth Authorization Code Flow
- Separación de permisos y roles
- Contexto protegido server-side
- Validación centralizada
- Arquitectura preparada para RLS

---

# Estructura general

```txt
src/
  app/
  components/
  config/
  lib/
  types/
  docs/
```

---

# Generación de tipos

Los tipos TypeScript se generan automáticamente desde Supabase:

```bash
npm run db:types
```

Esto mantiene sincronizados:
- PostgreSQL
- Supabase
- TypeScript

---

# Filosofía de arquitectura

El proyecto prioriza:

- Escalabilidad
- Modularidad
- Separación de responsabilidades
- Flexibilidad institucional
- Simplicidad evolutiva
- Seguridad
- Consistencia tipada
- Arquitectura desacoplada

---

# Próximos pasos

## Core

- Gestión de personas
- Vinculación de cuentas
- Validación institucional
- Gestión de roles
- Gestión de permisos

---

## Seguridad

- RLS
- Auditoría
- Logs administrativos
- Policies multi-tenant

---

## Administración

- Dashboard administrativo
- Gestión de escuelas
- Gestión de usuarios
- Configuración institucional

---

## Académico

- Gestión de cursos
- Gestión de alumnos
- Gestión docente
- Comunicaciones
- Reportes

---

## Infraestructura

- Migrations
- Seeds
- Testing
- CI/CD
- Observabilidad