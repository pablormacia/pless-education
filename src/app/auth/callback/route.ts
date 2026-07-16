import { getRedirectForAuth } from '@/lib/auth/getRedirectForAuth'
import { getSessionUser } from '@/lib/auth/getSessionUser'
import { createClient } from '@/lib/supabase/server'
import { NextResponse } from 'next/server'
import {redirect} from 'next/navigation'

export async function GET(request: Request) {
  const { searchParams, origin } = new URL(request.url)

  const code = searchParams.get('code')
  //console.log('code', code)

  if (code) {
    const supabase = await createClient()

    await supabase.auth.exchangeCodeForSession(code)
  }

   const session = await getSessionUser();

   if (!session) {
    redirect("/login");
  }
   const redirectTo = getRedirectForAuth(session);

  return NextResponse.redirect(`${origin}${redirectTo}`)
}