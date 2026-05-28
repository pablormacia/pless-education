import { ReactNode } from "react";

import Sidebar from "./Sidebar";
import Header from "./Header";

import { Database } from "@/types/supabase";

type Person = Database["public"]["Tables"]["people"]["Row"];

type AuthAccount = Database["public"]["Tables"]["auth_accounts"]["Row"];

type Props = {
  children: ReactNode;

  person: Person;

  authAccount: AuthAccount;

  permissions: string[];
};

export default function AppShell({
  children,
  person,
  authAccount,
  permissions,
}: Props) {
  return (
    <div className="flex min-h-screen">
      <Sidebar permissions={permissions} />

      <div className="flex flex-1 flex-col">
        <Header person={person} authAccount={authAccount} />

        <main className="flex-1 p-6">{children}</main>
      </div>
    </div>
  );
}
