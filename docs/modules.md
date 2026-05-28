# Modules

La plataforma está pensada como un sistema modular.

Cada módulo debe contener:
- navegación
- permisos
- páginas
- lógica de negocio
- acciones server-side

---

# Módulos actuales

## Auth
- login
- logout
- OAuth
- validación SSR

---

## Users
Gestión de usuarios institucionales.

---

## Roles
Gestión de roles y permisos.

---

# Módulos futuros

## Students
Gestión de alumnos.

---

## Teachers
Gestión docente.

---

## Attendance
Asistencia.

---

## Communications
Comunicaciones institucionales.

---

## Maintenance
Pedidos y seguimiento técnico.

---

## Cleaning
Rutinas y tareas de maestranza.

---

# Filosofía modular

La aplicación evita:
- lógica global acoplada
- navegación hardcodeada
- permisos dispersos

Cada módulo debe poder evolucionar independientemente.