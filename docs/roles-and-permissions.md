# Roles and Permissions

## Filosofía

La plataforma utiliza un modelo RBAC (Role-Based Access Control).

Los roles representan funciones organizacionales.

Los permisos representan acciones concretas dentro del sistema.

---

# Roles actuales

## admin
Administrador institucional.

Puede gestionar:
- usuarios
- roles
- permisos
- configuraciones

---

## owner
Propietario institucional.

Orientado a:
- supervisión
- métricas
- control institucional

---

## director_general
Dirección general del establecimiento.

---

## level_director
Director de nivel:
- inicial
- primaria
- secundaria

Utiliza scopes para limitar alcance.

---

## department_director
Director de área:
- informática
- inglés
- educación física

---

## teacher
Docente.

---

## parent
Padre o tutor.

---

## student
Alumno.

---

## maintenance
Personal de mantenimiento.

---

## cleaning
Personal de maestranza.

---

# Permisos actuales MVP

## users.read
Puede visualizar usuarios.

## users.create
Puede crear usuarios.

## users.update
Puede modificar usuarios.

## users.manage_roles
Puede asignar roles.

---

# Arquitectura de permisos

La interfaz NO define seguridad.

Los permisos reales deben validarse:
- server-side
- server actions
- route handlers
- RLS

---

# Scopes

Los scopes permiten limitar permisos según contexto organizacional.

Ejemplos:
- nivel educativo
- departamento
- área institucional

Ejemplo:

```txt
role: level_director
scope_type: level
scope_value: secondary
```