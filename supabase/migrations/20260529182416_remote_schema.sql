
COMMENT ON SCHEMA "public" IS 'standard public schema';


-- Extensions
CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";
CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";
CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";
CREATE EXTENSION IF NOT EXISTS "unaccent" WITH SCHEMA "public";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";


-- Types
CREATE TYPE "public"."audit_action" AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE'
);


CREATE TYPE "public"."auth_status" AS ENUM (
    'pending_claim',
    'pending_validation',
    'active',
    'blocked'
);


CREATE TYPE "public"."document_type" AS ENUM (
    'dni',
    'passport',
    'foreign_id'
);



CREATE TYPE "public"."person_status" AS ENUM (
    'active',
    'inactive',
    'archived'
);


CREATE TYPE "public"."role_scope_type" AS ENUM (
    'school',
    'level',
    'department',
    'course',
    'building'
);

CREATE TYPE "public"."role_type" AS ENUM (
    'system',
    'administrative',
    'academic',
    'service',
    'family',
    'student',
    'institutional'
);


CREATE TYPE "public"."school_type" AS ENUM (
    'private',
    'public'
);

-- Tables
CREATE TABLE IF NOT EXISTS "public"."audit_logs" (
    "id" "uuid" DEFAULT gen_random_uuid() NOT NULL,
    "table_name" "text" NOT NULL,
    "record_id" "uuid",
    "action" "public"."audit_action" NOT NULL,
    "old_data" "jsonb",
    "new_data" "jsonb",
    "performed_by" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."audit_logs" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."auth_accounts" (
    "id" "uuid" DEFAULT gen_random_uuid() NOT NULL,
    "auth_user_id" "uuid" NOT NULL,
    "person_id" "uuid",
    "email" "text" NOT NULL,
    "status" "public"."auth_status" DEFAULT 'pending_claim'::"public"."auth_status",
    "linked_method" "text",
    "linked_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "last_login_at" timestamp with time zone
);


ALTER TABLE "public"."auth_accounts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."people" (
    "id" "uuid" DEFAULT gen_random_uuid() NOT NULL,
    "school_id" "uuid" NOT NULL,
    "first_name" "text" NOT NULL,
    "last_name" "text" NOT NULL,
    "first_name_normalized" "text",
    "last_name_normalized" "text",
    "document_type" "public"."document_type",
    "document_number" "text",
    "birth_date" "date",
    "status" "public"."person_status" DEFAULT 'active'::public.person_status NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "created_by" "uuid",
    "updated_by" "uuid"
);

ALTER TABLE "public"."people" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."permissions" (
    "id" "uuid" DEFAULT gen_random_uuid() NOT NULL,
    "code" "text" NOT NULL,
    "description" "text",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."permissions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."person_roles" (
    "id" "uuid" DEFAULT gen_random_uuid() NOT NULL,
    "person_id" "uuid" NOT NULL,
    "role_id" "uuid" NOT NULL,
    "school_id" "uuid" NOT NULL,
    "scope_type" "public"."role_scope_type",
    "scope_value" text NOT NULL DEFAULT '',
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "created_by" "uuid",
    "updated_by" "uuid"
);


ALTER TABLE "public"."person_roles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."role_permissions" (
    "id" "uuid" DEFAULT gen_random_uuid() NOT NULL,
    "role_id" "uuid" NOT NULL,
    "permission_id" "uuid" NOT NULL
);


ALTER TABLE "public"."role_permissions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."roles" (
    "id" "uuid" DEFAULT gen_random_uuid() NOT NULL,
    "name" "text" NOT NULL,
    "type" "public"."role_type" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."roles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."schools" (
    "id" "uuid" DEFAULT gen_random_uuid() NOT NULL,
    "name" "text" NOT NULL,
    "type" "public"."school_type" NOT NULL,
    "address" "text",
    "city" "text",
    "province" "text",
    "country" "text",
    "postal_code" "text",
    "logo_path" "text",
    "created_by" "uuid",
    "updated_by" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."schools" OWNER TO "postgres";

ALTER TABLE ONLY "public"."audit_logs"
    ADD CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."auth_accounts"
    ADD CONSTRAINT "auth_accounts_auth_user_id_key" UNIQUE ("auth_user_id");

ALTER TABLE ONLY "public"."auth_accounts"
    ADD CONSTRAINT "auth_accounts_email_key" UNIQUE ("email");

ALTER TABLE ONLY "public"."auth_accounts"
    ADD CONSTRAINT "auth_accounts_person_id_key" UNIQUE ("person_id");

ALTER TABLE ONLY "public"."auth_accounts"
    ADD CONSTRAINT "auth_accounts_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."people"
    ADD CONSTRAINT "people_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."permissions"
    ADD CONSTRAINT "permissions_code_key" UNIQUE ("code");

ALTER TABLE ONLY "public"."permissions"
    ADD CONSTRAINT "permissions_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."person_roles"
    ADD CONSTRAINT "person_roles_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."role_permissions"
    ADD CONSTRAINT "role_permissions_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."role_permissions"
    ADD CONSTRAINT "role_permissions_role_id_permission_id_key" UNIQUE ("role_id", "permission_id");

ALTER TABLE ONLY "public"."roles"
    ADD CONSTRAINT "roles_name_key" UNIQUE ("name");

ALTER TABLE ONLY "public"."roles"
    ADD CONSTRAINT "roles_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."schools"
    ADD CONSTRAINT "schools_pkey" PRIMARY KEY ("id");

-- Indexes
CREATE INDEX "idx_audit_logs_created_at" ON "public"."audit_logs" USING "btree" ("created_at" DESC);
CREATE INDEX "idx_audit_logs_record_id" ON "public"."audit_logs" USING "btree" ("record_id");
CREATE INDEX "idx_audit_logs_table_name" ON "public"."audit_logs" USING "btree" ("table_name");
CREATE INDEX "idx_people_document" ON "public"."people" USING "btree" ("document_number");
CREATE INDEX "idx_people_last_name_normalized" ON "public"."people" USING "btree" ("last_name_normalized");
CREATE INDEX "idx_people_search" ON "public"."people" USING "btree" ("school_id", "last_name_normalized", "first_name_normalized");
CREATE UNIQUE INDEX "person_roles_unique_assignment" ON "public"."person_roles" USING "btree" ("person_id", "role_id", "school_id", "scope_type", "scope_value");


-- Functions
CREATE OR REPLACE FUNCTION "public"."audit_trigger"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
begin

  if tg_op = 'INSERT' then
    insert into public.audit_logs (
      table_name,
      record_id,
      action,
      new_data
    )
    values (
      tg_table_name,
      new.id,
      'INSERT',
      to_jsonb(new)
    );

    return new;
  end if;

  if tg_op = 'UPDATE' then
    insert into public.audit_logs (
      table_name,
      record_id,
      action,
      old_data,
      new_data
    )
    values (
      tg_table_name,
      new.id,
      'UPDATE',
      to_jsonb(old),
      to_jsonb(new)
    );

    return new;
  end if;

  if tg_op = 'DELETE' then
    insert into public.audit_logs (
      table_name,
      record_id,
      action,
      old_data
    )
    values (
      tg_table_name,
      old.id,
      'DELETE',
      to_jsonb(old)
    );

    return old;
  end if;

  return null;
end;
$$;


CREATE OR REPLACE FUNCTION "public"."get_current_person_id"() RETURNS "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select aa.person_id
  from public.auth_accounts aa
  where aa.auth_user_id = auth.uid()
  limit 1;
$$;


CREATE OR REPLACE FUNCTION "public"."get_current_school_id"() RETURNS "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select pr.school_id
  from public.person_roles pr
  where pr.person_id = public.get_current_person_id()
  limit 1;
$$;


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$begin
  insert into public.auth_accounts (
    auth_user_id,
    email,
    status
  )
  values (
    new.id,
    new.email,
    'pending_claim'
  )
  on conflict (auth_user_id)
  do nothing;

  return new;
end;$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."has_permission"("permission_code" "text") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select exists (
    select 1
    from public.person_roles pr
    join public.role_permissions rp
      on rp.role_id = pr.role_id
    join public.permissions p
      on p.id = rp.permission_id
    where pr.person_id = public.get_current_person_id()
      and pr.school_id = public.get_current_school_id()
      and p.code = permission_code
  );
$$;

CREATE OR REPLACE FUNCTION "public"."has_role"("role_name" "text") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select exists (
    select 1
    from public.person_roles pr
    join public.roles r
      on r.id = pr.role_id
    where pr.person_id = public.get_current_person_id()
      and pr.school_id = public.get_current_school_id()
      and lower(r.name) = lower(role_name)
  );
$$;


CREATE OR REPLACE FUNCTION "public"."normalize_people_fields"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  new.first_name_normalized :=
    public.normalize_text(new.first_name);

  new.last_name_normalized :=
    public.normalize_text(new.last_name);

  return new;
end;
$$;


CREATE OR REPLACE FUNCTION "public"."normalize_text"("input" "text") RETURNS "text"
    LANGUAGE "sql" IMMUTABLE
    AS $$
  select lower(unaccent(trim(input)));
$$;


CREATE OR REPLACE FUNCTION "public"."set_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  new.updated_at = now();
  return new;
end;
$$;



-- Triggers
CREATE OR REPLACE TRIGGER "audit_auth_accounts_trigger" AFTER INSERT OR DELETE OR UPDATE ON "public"."auth_accounts" FOR EACH ROW EXECUTE FUNCTION "public"."audit_trigger"();
CREATE OR REPLACE TRIGGER "audit_people_trigger" AFTER INSERT OR DELETE OR UPDATE ON "public"."people" FOR EACH ROW EXECUTE FUNCTION "public"."audit_trigger"();
CREATE OR REPLACE TRIGGER "audit_person_roles_trigger" AFTER INSERT OR DELETE OR UPDATE ON "public"."person_roles" FOR EACH ROW EXECUTE FUNCTION "public"."audit_trigger"();
CREATE OR REPLACE TRIGGER "normalize_people_fields_trigger" BEFORE INSERT OR UPDATE ON "public"."people" FOR EACH ROW EXECUTE FUNCTION "public"."normalize_people_fields"();
CREATE OR REPLACE TRIGGER "set_updated_at_people" BEFORE UPDATE ON "public"."people" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();
CREATE OR REPLACE TRIGGER "set_updated_at_person_roles" BEFORE UPDATE ON "public"."person_roles" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();
CREATE OR REPLACE TRIGGER "set_updated_at_schools" BEFORE UPDATE ON "public"."schools" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();


ALTER TABLE ONLY "public"."auth_accounts"
    ADD CONSTRAINT "auth_accounts_auth_user_id_fkey" FOREIGN KEY ("auth_user_id") REFERENCES "auth"."users"("id");

ALTER TABLE ONLY "public"."auth_accounts"
    ADD CONSTRAINT "auth_accounts_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "public"."people"("id");

ALTER TABLE ONLY "public"."people"
    ADD CONSTRAINT "people_school_id_fkey" FOREIGN KEY ("school_id") REFERENCES "public"."schools"("id");

ALTER TABLE ONLY "public"."person_roles"
    ADD CONSTRAINT "person_roles_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "public"."people"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."person_roles"
    ADD CONSTRAINT "person_roles_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."roles"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."person_roles"
    ADD CONSTRAINT "person_roles_school_id_fkey" FOREIGN KEY ("school_id") REFERENCES "public"."schools"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."role_permissions"
    ADD CONSTRAINT "role_permissions_permission_id_fkey" FOREIGN KEY ("permission_id") REFERENCES "public"."permissions"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."role_permissions"
    ADD CONSTRAINT "role_permissions_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."roles"("id") ON DELETE CASCADE;

ALTER TABLE "public"."people" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.auth_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.person_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.schools ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "people_create" ON "public"."people" FOR INSERT TO "authenticated" WITH CHECK ((("school_id" = "public"."get_current_school_id"()) AND "public"."has_permission"('users.create'::"text")));
CREATE POLICY "people_read" ON "public"."people" FOR SELECT TO "authenticated" USING ((("school_id" = "public"."get_current_school_id"()) AND "public"."has_permission"('users.read'::"text")));
CREATE POLICY "people_update" ON "public"."people" FOR UPDATE TO "authenticated" USING ((("school_id" = "public"."get_current_school_id"()) AND "public"."has_permission"('users.update'::"text"))) WITH CHECK (("school_id" = "public"."get_current_school_id"()));
CREATE POLICY "people_delete"
ON public.people
FOR DELETE
TO authenticated
USING (
  school_id = public.get_current_school_id()
  AND public.has_permission('users.delete')
);


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";


CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

