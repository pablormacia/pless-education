export function getRedirectForAuth(session: {
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