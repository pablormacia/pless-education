import { Home, Users, Shield, Wrench } from "lucide-react";

export const navigation = [
  {
    label: "Dashboard",
    href: "/dashboard",
    icon: Home,
    permissions: [],
  },

  {
    label: "Usuarios",
    href: "/users",
    icon: Users,
    permissions: ["users.read"],
  },
  {
    label: "Personas",
    href: "/people",
    icon: Users,
    permissions: ["people.read"],
  },

  {
    label: "Roles y permisos",
    href: "/roles",
    icon: Shield,
    permissions: ["users.manage_roles"],
  },

  {
    label: "Mantenimiento",
    href: "/maintenance",
    icon: Wrench,
    permissions: ["maintenance.read"],
  },
];
