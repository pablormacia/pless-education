# Pless Education - Guía de Arquitectura

> Versión: 1.0
> Estado: Activa
> Última actualización: 16/07/2026

---

# Objetivo

Esta guía define la arquitectura y las convenciones de desarrollo de Pless Education.

Su objetivo es garantizar que todos los módulos del sistema mantengan una estructura consistente, reutilizable y fácil de mantener a largo plazo.

El principio fundamental del proyecto es:

> **Construir una plataforma, no un conjunto de pantallas.**

---

# Principios

## 1. Arquitectura Modular

Cada funcionalidad del sistema debe pertenecer a un único módulo.

Ejemplos:

```
people
users
students
courses
subjects
permissions
institutions
communication
```

Cada módulo contiene únicamente la lógica relacionada con ese dominio.

Nunca debe contener componentes reutilizables de la aplicación.

---

## 2. Componentes Compartidos

Todo componente reutilizable debe vivir fuera de los módulos.

```
src/components
```

Estos componentes forman la librería visual de Pless Education.

---

## 3. Separación de Responsabilidades

Cada capa tiene una única responsabilidad.

```
UI
↓

Componentes reutilizables

↓

Módulo

↓

Server Actions

↓

Repository

↓

Supabase
```

---

## 4. Componentes UI

```
src/components/ui
```

Contiene exclusivamente componentes generados por shadcn/ui.

Ejemplos:

```
Button

Input

Dialog

Badge

Table

Card
```

No deben modificarse para agregar lógica de negocio.

---

## 5. Componentes Compartidos

```
src/components
```

Contiene componentes reutilizables propios de Pless Education.

Ejemplos:

```
data-table/

forms/

dialogs/

layout/

feedback/

navigation/

common/
```

Estos componentes pueden utilizar componentes de `ui`.

Nunca deben depender de un módulo específico.

---

# Organización del Proyecto

```
src/

app/

components/

modules/

lib/

hooks/

types/

styles/
```

---

# Organización de Components

```
components/

ui/

data-table/

forms/

dialogs/

layout/

feedback/

navigation/

common/
```

---

# Organización de Módulos

Ejemplo:

```
modules/

people/

components/

actions/

repositories/

schemas/

types/

hooks/

constants/

utils/
```

---

# Responsabilidad de cada carpeta

## components/

Componentes específicos del módulo.

Ejemplo:

```
PersonForm

PersonCard

PersonFilters

PersonDetails
```

---

## actions/

Server Actions.

Responsabilidades:

- validar permisos
- validar datos
- ejecutar reglas de negocio
- llamar al Repository
- revalidar cache
- devolver resultado

Nunca deben acceder directamente a Supabase.

---

## repositories/

Única capa que conoce la base de datos.

Responsabilidades:

- consultas
- inserts
- updates
- deletes
- llamadas RPC

Toda comunicación con Supabase pasa por aquí.

---

## schemas/

Esquemas Zod.

Responsabilidades:

- validación
- transformación
- tipos inferidos

---

## types/

Tipos específicos del módulo.

Nunca colocar tipos globales aquí.

---

## hooks/

Hooks React exclusivos del módulo.

---

## constants/

Constantes del módulo.

---

## utils/

Funciones auxiliares exclusivas del módulo.

---

# Flujo de Datos

```
Página

↓

Componente

↓

Server Action

↓

Repository

↓

Supabase
```

Nunca:

```
Componente

↓

Supabase
```

---

# Convenciones de Nombres

## Carpetas

Siempre:

```
kebab-case
```

Ejemplo

```
data-table

user-profile

page-header
```

---

## Componentes React

Siempre:

```
PascalCase
```

Ejemplo

```
PersonForm

DataTable

ConfirmDialog
```

---

## Hooks

Siempre

```
usePeople

usePerson

usePermissions
```

---

## Repositories

Siempre

```
people.repository.ts

users.repository.ts
```

No:

```
personRepository.ts
```

---

## Schemas

Siempre

```
people.schema.ts

users.schema.ts
```

---

## Types

Siempre

```
people.types.ts

users.types.ts
```

---

# Librerías Oficiales

## UI

- shadcn/ui

---

## Iconos

- lucide-react

---

## Formularios

- react-hook-form

---

## Validación

- zod

---

## Base de datos

- Supabase SDK

---

## Tablas

- TanStack Table

---

## Notificaciones

- Sonner

---

# Diseño de Componentes

Los componentes deben ser:

- pequeños
- reutilizables
- desacoplados
- testeables

Evitar componentes gigantes.

---

# Componentes Compartidos

Ejemplo:

```
DataTable

FormSection

ConfirmDialog

PageHeader

StatusBadge

EmptyState
```

No deben conocer ningún módulo.

---

# Módulos

Los módulos solamente configuran la infraestructura compartida.

Ejemplo:

```
<DataTable

columns={peopleColumns}

data={people}

/>
```

La lógica específica vive en:

```
people.columns.tsx
```

No dentro de DataTable.

---

# Principios SOLID

Se buscará respetar:

- Single Responsibility
- Open / Closed
- Dependency Inversion

Siempre que sea posible.

---

# Escalabilidad

La incorporación de un nuevo módulo debe requerir únicamente:

- crear el módulo
- definir las columnas
- crear formularios
- implementar repositories
- implementar actions

Toda la infraestructura debe reutilizarse.

---

# Objetivo Final

Pless Education debe evolucionar como una plataforma modular donde cada nuevo módulo reutilice la infraestructura existente.

La mayor parte del tiempo de desarrollo debe invertirse en reglas de negocio y no en volver a construir interfaces o componentes repetitivos.