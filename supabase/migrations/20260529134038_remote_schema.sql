create extension if not exists "unaccent" with schema "public";

alter table "public"."person_roles" drop constraint "user_roles_school_id_fkey";

alter table "public"."person_roles" drop constraint "user_roles_pkey";

drop index if exists "public"."user_roles_pkey";


  create table "public"."audit_logs" (
    "id" uuid not null default gen_random_uuid(),
    "table_name" text not null,
    "record_id" uuid,
    "action" text not null,
    "old_data" jsonb,
    "new_data" jsonb,
    "performed_by" uuid,
    "created_at" timestamp with time zone not null default now()
      );


alter table "public"."person_roles" alter column "created_by" drop default;

alter table "public"."person_roles" alter column "updated_by" drop default;

alter table "public"."roles" alter column "created_at" set data type timestamp with time zone using "created_at"::timestamp with time zone;

alter table "public"."schools" alter column "created_at" set data type timestamp with time zone using "created_at"::timestamp with time zone;

alter table "public"."schools" alter column "updated_at" set data type timestamp with time zone using "updated_at"::timestamp with time zone;

CREATE UNIQUE INDEX audit_logs_pkey ON public.audit_logs USING btree (id);

CREATE UNIQUE INDEX person_roles_pkey ON public.person_roles USING btree (id);

CREATE UNIQUE INDEX person_roles_unique_assignment ON public.person_roles USING btree (person_id, role_id, school_id, scope_type, scope_value);

alter table "public"."audit_logs" add constraint "audit_logs_pkey" PRIMARY KEY using index "audit_logs_pkey";

alter table "public"."person_roles" add constraint "person_roles_pkey" PRIMARY KEY using index "person_roles_pkey";

alter table "public"."person_roles" add constraint "person_roles_person_id_fkey" FOREIGN KEY (person_id) REFERENCES public.people(id) ON DELETE CASCADE not valid;

alter table "public"."person_roles" validate constraint "person_roles_person_id_fkey";

alter table "public"."person_roles" add constraint "person_roles_school_id_fkey" FOREIGN KEY (school_id) REFERENCES public.schools(id) ON DELETE CASCADE not valid;

alter table "public"."person_roles" validate constraint "person_roles_school_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.audit_trigger()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.normalize_people_fields()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  new.first_name_normalized :=
    public.normalize_text(new.first_name);

  new.last_name_normalized :=
    public.normalize_text(new.last_name);

  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.normalize_text(input text)
 RETURNS text
 LANGUAGE sql
 IMMUTABLE
AS $function$
  select lower(unaccent(trim(input)));
$function$
;

grant delete on table "public"."audit_logs" to "anon";

grant insert on table "public"."audit_logs" to "anon";

grant references on table "public"."audit_logs" to "anon";

grant select on table "public"."audit_logs" to "anon";

grant trigger on table "public"."audit_logs" to "anon";

grant truncate on table "public"."audit_logs" to "anon";

grant update on table "public"."audit_logs" to "anon";

grant delete on table "public"."audit_logs" to "authenticated";

grant insert on table "public"."audit_logs" to "authenticated";

grant references on table "public"."audit_logs" to "authenticated";

grant select on table "public"."audit_logs" to "authenticated";

grant trigger on table "public"."audit_logs" to "authenticated";

grant truncate on table "public"."audit_logs" to "authenticated";

grant update on table "public"."audit_logs" to "authenticated";

grant delete on table "public"."audit_logs" to "service_role";

grant insert on table "public"."audit_logs" to "service_role";

grant references on table "public"."audit_logs" to "service_role";

grant select on table "public"."audit_logs" to "service_role";

grant trigger on table "public"."audit_logs" to "service_role";

grant truncate on table "public"."audit_logs" to "service_role";

grant update on table "public"."audit_logs" to "service_role";

CREATE TRIGGER audit_auth_accounts_trigger AFTER INSERT OR DELETE OR UPDATE ON public.auth_accounts FOR EACH ROW EXECUTE FUNCTION public.audit_trigger();

CREATE TRIGGER audit_people_trigger AFTER INSERT OR DELETE OR UPDATE ON public.people FOR EACH ROW EXECUTE FUNCTION public.audit_trigger();

CREATE TRIGGER normalize_people_fields_trigger BEFORE INSERT OR UPDATE ON public.people FOR EACH ROW EXECUTE FUNCTION public.normalize_people_fields();

CREATE TRIGGER set_updated_at_people BEFORE UPDATE ON public.people FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER set_updated_at_person_roles BEFORE UPDATE ON public.person_roles FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


