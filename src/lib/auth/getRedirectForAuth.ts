import { User } from "@supabase/supabase-js";



export function getRedirectForAuth(session: {
  user: User;
  authAccount: any;
  person: any;
}) {
  const { authAccount, person } = session;

  if (!authAccount) {
    return "/claim-account";
  }

  if (!person) {
    return "/claim-account";
  }

  switch (authAccount.status) {
    case "pending_claim":
      return "/claim-account";

    case "pending_validation":
      return "/pending";

    case "blocked":
      return "/blocked";

    case "active":
      return "/dashboard";

    default:
      return "/login";
  }
}