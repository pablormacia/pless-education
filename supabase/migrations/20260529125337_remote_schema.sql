drop extension if exists "pg_net";

create type "public"."auth_status" as enum ('pending_claim', 'pending_validation', 'active', 'blocked');

create type "public"."document_type" as enum ('dni', 'passport', 'foreign_id');

create type "public"."person_status" as enum ('active', 'inactive', 'archived');

create type "public"."role_scope_type" as enum ('school', 'level', 'department', 'course', 'building');

create type "public"."role_type" as enum ('system', 'administrative', 'academic', 'service', 'family', 'student', 'institutional');

create type "public"."school_type" as enum ('private', 'public');


  create table "public"."auth_accounts" (
    "id" uuid not null default gen_random_uuid(),
    "auth_user_id" uuid not null,
    "person_id" uuid,
    "email" text not null,
    "status" public.auth_status default 'pending_claim'::public.auth_status,
    "linked_method" text,
    "linked_at" timestamp with time zone,
    "created_at" timestamp with time zone default now(),
    "last_login_at" timestamp with time zone
      );



  create table "public"."people" (
    "id" uuid not null default gen_random_uuid(),
    "school_id" uuid not null,
    "first_name" text not null,
    "last_name" text not null,
    "first_name_normalized" text,
    "last_name_normalized" text,
    "document_type" public.document_type,
    "document_number" text,
    "birth_date" date,
    "status" public.person_status,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now(),
    "created_by" uuid,
    "updated_by" uuid
      );



  create table "public"."permissions" (
    "id" uuid not null default gen_random_uuid(),
    "code" text not null,
    "description" text,
    "created_at" timestamp with time zone default now()
      );



  create table "public"."person_roles" (
    "id" uuid not null default gen_random_uuid(),
    "person_id" uuid,
    "role_id" uuid,
    "school_id" uuid,
    "scope_type" public.role_scope_type,
    "scope_value" text,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone,
    "created_by" uuid default gen_random_uuid(),
    "updated_by" uuid default gen_random_uuid()
      );



  create table "public"."role_permissions" (
    "id" uuid not null default gen_random_uuid(),
    "role_id" uuid not null,
    "permission_id" uuid not null
      );



  create table "public"."roles" (
    "id" uuid not null default gen_random_uuid(),
    "name" text not null,
    "type" public.role_type,
    "created_at" timestamp without time zone default now()
      );



  create table "public"."schools" (
    "id" uuid not null default gen_random_uuid(),
    "name" text not null,
    "type" public.school_type,
    "address" text,
    "city" text,
    "province" text,
    "country" text,
    "postal_code" text,
    "logo_path" text,
    "created_at" timestamp without time zone default now(),
    "updated_at" timestamp without time zone default now(),
    "created_by" uuid,
    "updated_by" uuid
      );


CREATE UNIQUE INDEX auth_accounts_auth_user_id_key ON public.auth_accounts USING btree (auth_user_id);

CREATE UNIQUE INDEX auth_accounts_email_key ON public.auth_accounts USING btree (email);

CREATE UNIQUE INDEX auth_accounts_person_id_key ON public.auth_accounts USING btree (person_id);

CREATE UNIQUE INDEX auth_accounts_pkey ON public.auth_accounts USING btree (id);

CREATE INDEX idx_people_document ON public.people USING btree (document_number);

CREATE INDEX idx_people_last_name_normalized ON public.people USING btree (last_name_normalized);

CREATE UNIQUE INDEX people_pkey ON public.people USING btree (id);

CREATE UNIQUE INDEX permissions_code_key ON public.permissions USING btree (code);

CREATE UNIQUE INDEX permissions_pkey ON public.permissions USING btree (id);

CREATE UNIQUE INDEX role_permissions_pkey ON public.role_permissions USING btree (id);

CREATE UNIQUE INDEX role_permissions_role_id_permission_id_key ON public.role_permissions USING btree (role_id, permission_id);

CREATE UNIQUE INDEX roles_name_key ON public.roles USING btree (name);

CREATE UNIQUE INDEX roles_pkey ON public.roles USING btree (id);

CREATE UNIQUE INDEX schools_pkey ON public.schools USING btree (id);

CREATE UNIQUE INDEX user_roles_pkey ON public.person_roles USING btree (id);

alter table "public"."auth_accounts" add constraint "auth_accounts_pkey" PRIMARY KEY using index "auth_accounts_pkey";

alter table "public"."people" add constraint "people_pkey" PRIMARY KEY using index "people_pkey";

alter table "public"."permissions" add constraint "permissions_pkey" PRIMARY KEY using index "permissions_pkey";

alter table "public"."person_roles" add constraint "user_roles_pkey" PRIMARY KEY using index "user_roles_pkey";

alter table "public"."role_permissions" add constraint "role_permissions_pkey" PRIMARY KEY using index "role_permissions_pkey";

alter table "public"."roles" add constraint "roles_pkey" PRIMARY KEY using index "roles_pkey";

alter table "public"."schools" add constraint "schools_pkey" PRIMARY KEY using index "schools_pkey";

alter table "public"."auth_accounts" add constraint "auth_accounts_auth_user_id_fkey" FOREIGN KEY (auth_user_id) REFERENCES auth.users(id) not valid;

alter table "public"."auth_accounts" validate constraint "auth_accounts_auth_user_id_fkey";

alter table "public"."auth_accounts" add constraint "auth_accounts_auth_user_id_key" UNIQUE using index "auth_accounts_auth_user_id_key";

alter table "public"."auth_accounts" add constraint "auth_accounts_email_key" UNIQUE using index "auth_accounts_email_key";

alter table "public"."auth_accounts" add constraint "auth_accounts_person_id_fkey" FOREIGN KEY (person_id) REFERENCES public.people(id) not valid;

alter table "public"."auth_accounts" validate constraint "auth_accounts_person_id_fkey";

alter table "public"."auth_accounts" add constraint "auth_accounts_person_id_key" UNIQUE using index "auth_accounts_person_id_key";

alter table "public"."people" add constraint "people_school_id_fkey" FOREIGN KEY (school_id) REFERENCES public.schools(id) not valid;

alter table "public"."people" validate constraint "people_school_id_fkey";

alter table "public"."permissions" add constraint "permissions_code_key" UNIQUE using index "permissions_code_key";

alter table "public"."person_roles" add constraint "person_roles_role_id_fkey" FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE not valid;

alter table "public"."person_roles" validate constraint "person_roles_role_id_fkey";

alter table "public"."person_roles" add constraint "user_roles_school_id_fkey" FOREIGN KEY (school_id) REFERENCES public.schools(id) ON DELETE CASCADE not valid;

alter table "public"."person_roles" validate constraint "user_roles_school_id_fkey";

alter table "public"."role_permissions" add constraint "role_permissions_permission_id_fkey" FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE not valid;

alter table "public"."role_permissions" validate constraint "role_permissions_permission_id_fkey";

alter table "public"."role_permissions" add constraint "role_permissions_role_id_fkey" FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE not valid;

alter table "public"."role_permissions" validate constraint "role_permissions_role_id_fkey";

alter table "public"."role_permissions" add constraint "role_permissions_role_id_permission_id_key" UNIQUE using index "role_permissions_role_id_permission_id_key";

alter table "public"."roles" add constraint "roles_name_key" UNIQUE using index "roles_name_key";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$begin
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
end;$function$
;

CREATE OR REPLACE FUNCTION public.set_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  new.updated_at = now();
  return new;
end;
$function$
;

grant delete on table "public"."auth_accounts" to "anon";

grant insert on table "public"."auth_accounts" to "anon";

grant references on table "public"."auth_accounts" to "anon";

grant select on table "public"."auth_accounts" to "anon";

grant trigger on table "public"."auth_accounts" to "anon";

grant truncate on table "public"."auth_accounts" to "anon";

grant update on table "public"."auth_accounts" to "anon";

grant delete on table "public"."auth_accounts" to "authenticated";

grant insert on table "public"."auth_accounts" to "authenticated";

grant references on table "public"."auth_accounts" to "authenticated";

grant select on table "public"."auth_accounts" to "authenticated";

grant trigger on table "public"."auth_accounts" to "authenticated";

grant truncate on table "public"."auth_accounts" to "authenticated";

grant update on table "public"."auth_accounts" to "authenticated";

grant delete on table "public"."auth_accounts" to "service_role";

grant insert on table "public"."auth_accounts" to "service_role";

grant references on table "public"."auth_accounts" to "service_role";

grant select on table "public"."auth_accounts" to "service_role";

grant trigger on table "public"."auth_accounts" to "service_role";

grant truncate on table "public"."auth_accounts" to "service_role";

grant update on table "public"."auth_accounts" to "service_role";

grant delete on table "public"."people" to "anon";

grant insert on table "public"."people" to "anon";

grant references on table "public"."people" to "anon";

grant select on table "public"."people" to "anon";

grant trigger on table "public"."people" to "anon";

grant truncate on table "public"."people" to "anon";

grant update on table "public"."people" to "anon";

grant delete on table "public"."people" to "authenticated";

grant insert on table "public"."people" to "authenticated";

grant references on table "public"."people" to "authenticated";

grant select on table "public"."people" to "authenticated";

grant trigger on table "public"."people" to "authenticated";

grant truncate on table "public"."people" to "authenticated";

grant update on table "public"."people" to "authenticated";

grant delete on table "public"."people" to "service_role";

grant insert on table "public"."people" to "service_role";

grant references on table "public"."people" to "service_role";

grant select on table "public"."people" to "service_role";

grant trigger on table "public"."people" to "service_role";

grant truncate on table "public"."people" to "service_role";

grant update on table "public"."people" to "service_role";

grant delete on table "public"."permissions" to "anon";

grant insert on table "public"."permissions" to "anon";

grant references on table "public"."permissions" to "anon";

grant select on table "public"."permissions" to "anon";

grant trigger on table "public"."permissions" to "anon";

grant truncate on table "public"."permissions" to "anon";

grant update on table "public"."permissions" to "anon";

grant delete on table "public"."permissions" to "authenticated";

grant insert on table "public"."permissions" to "authenticated";

grant references on table "public"."permissions" to "authenticated";

grant select on table "public"."permissions" to "authenticated";

grant trigger on table "public"."permissions" to "authenticated";

grant truncate on table "public"."permissions" to "authenticated";

grant update on table "public"."permissions" to "authenticated";

grant delete on table "public"."permissions" to "service_role";

grant insert on table "public"."permissions" to "service_role";

grant references on table "public"."permissions" to "service_role";

grant select on table "public"."permissions" to "service_role";

grant trigger on table "public"."permissions" to "service_role";

grant truncate on table "public"."permissions" to "service_role";

grant update on table "public"."permissions" to "service_role";

grant delete on table "public"."person_roles" to "anon";

grant insert on table "public"."person_roles" to "anon";

grant references on table "public"."person_roles" to "anon";

grant select on table "public"."person_roles" to "anon";

grant trigger on table "public"."person_roles" to "anon";

grant truncate on table "public"."person_roles" to "anon";

grant update on table "public"."person_roles" to "anon";

grant delete on table "public"."person_roles" to "authenticated";

grant insert on table "public"."person_roles" to "authenticated";

grant references on table "public"."person_roles" to "authenticated";

grant select on table "public"."person_roles" to "authenticated";

grant trigger on table "public"."person_roles" to "authenticated";

grant truncate on table "public"."person_roles" to "authenticated";

grant update on table "public"."person_roles" to "authenticated";

grant delete on table "public"."person_roles" to "service_role";

grant insert on table "public"."person_roles" to "service_role";

grant references on table "public"."person_roles" to "service_role";

grant select on table "public"."person_roles" to "service_role";

grant trigger on table "public"."person_roles" to "service_role";

grant truncate on table "public"."person_roles" to "service_role";

grant update on table "public"."person_roles" to "service_role";

grant delete on table "public"."role_permissions" to "anon";

grant insert on table "public"."role_permissions" to "anon";

grant references on table "public"."role_permissions" to "anon";

grant select on table "public"."role_permissions" to "anon";

grant trigger on table "public"."role_permissions" to "anon";

grant truncate on table "public"."role_permissions" to "anon";

grant update on table "public"."role_permissions" to "anon";

grant delete on table "public"."role_permissions" to "authenticated";

grant insert on table "public"."role_permissions" to "authenticated";

grant references on table "public"."role_permissions" to "authenticated";

grant select on table "public"."role_permissions" to "authenticated";

grant trigger on table "public"."role_permissions" to "authenticated";

grant truncate on table "public"."role_permissions" to "authenticated";

grant update on table "public"."role_permissions" to "authenticated";

grant delete on table "public"."role_permissions" to "service_role";

grant insert on table "public"."role_permissions" to "service_role";

grant references on table "public"."role_permissions" to "service_role";

grant select on table "public"."role_permissions" to "service_role";

grant trigger on table "public"."role_permissions" to "service_role";

grant truncate on table "public"."role_permissions" to "service_role";

grant update on table "public"."role_permissions" to "service_role";

grant delete on table "public"."roles" to "anon";

grant insert on table "public"."roles" to "anon";

grant references on table "public"."roles" to "anon";

grant select on table "public"."roles" to "anon";

grant trigger on table "public"."roles" to "anon";

grant truncate on table "public"."roles" to "anon";

grant update on table "public"."roles" to "anon";

grant delete on table "public"."roles" to "authenticated";

grant insert on table "public"."roles" to "authenticated";

grant references on table "public"."roles" to "authenticated";

grant select on table "public"."roles" to "authenticated";

grant trigger on table "public"."roles" to "authenticated";

grant truncate on table "public"."roles" to "authenticated";

grant update on table "public"."roles" to "authenticated";

grant delete on table "public"."roles" to "service_role";

grant insert on table "public"."roles" to "service_role";

grant references on table "public"."roles" to "service_role";

grant select on table "public"."roles" to "service_role";

grant trigger on table "public"."roles" to "service_role";

grant truncate on table "public"."roles" to "service_role";

grant update on table "public"."roles" to "service_role";

grant delete on table "public"."schools" to "anon";

grant insert on table "public"."schools" to "anon";

grant references on table "public"."schools" to "anon";

grant select on table "public"."schools" to "anon";

grant trigger on table "public"."schools" to "anon";

grant truncate on table "public"."schools" to "anon";

grant update on table "public"."schools" to "anon";

grant delete on table "public"."schools" to "authenticated";

grant insert on table "public"."schools" to "authenticated";

grant references on table "public"."schools" to "authenticated";

grant select on table "public"."schools" to "authenticated";

grant trigger on table "public"."schools" to "authenticated";

grant truncate on table "public"."schools" to "authenticated";

grant update on table "public"."schools" to "authenticated";

grant delete on table "public"."schools" to "service_role";

grant insert on table "public"."schools" to "service_role";

grant references on table "public"."schools" to "service_role";

grant select on table "public"."schools" to "service_role";

grant trigger on table "public"."schools" to "service_role";

grant truncate on table "public"."schools" to "service_role";

grant update on table "public"."schools" to "service_role";

CREATE TRIGGER set_updated_at_schools BEFORE UPDATE ON public.schools FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


