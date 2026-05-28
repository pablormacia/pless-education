# Business Rules

## Usuarios

- Todo usuario nuevo inicia con estado `pending`.
- Los usuarios `pending` no pueden acceder al dashboard.
- Solo usuarios habilitados (`active`) pueden ingresar al sistema.
- Usuarios `blocked` no pueden utilizar la plataforma.

---

## Roles

- Un usuario puede tener múltiples roles.
- Los roles representan identidad organizacional.
- Los permisos representan capacidades reales.

---

## Permisos

- Los permisos son independientes de la interfaz.
- La seguridad debe validarse server-side.
- La interfaz solo refleja capacidades disponibles.

---

## Multi-tenant

- Cada usuario pertenece a una institución.
- Los datos institucionales deben permanecer aislados.
- Los permisos se aplican dentro del contexto institucional.

---

## Gestión administrativa

- Solo administradores pueden gestionar usuarios.
- Solo administradores pueden asignar roles.
- Los cambios de permisos deben ser auditables.

---

## Estados de usuario

### pending
Usuario creado pero no validado.

### active
Usuario habilitado para operar.

### blocked
Usuario suspendido o deshabilitado.