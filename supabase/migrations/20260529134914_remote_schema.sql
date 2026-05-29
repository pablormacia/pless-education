create type "public"."audit_action" as enum ('INSERT', 'UPDATE', 'DELETE');

alter table "public"."audit_logs" alter column "action" set data type public.auth_status using "action"::public.auth_status;

CREATE INDEX idx_audit_logs_created_at ON public.audit_logs USING btree (created_at DESC);

CREATE INDEX idx_audit_logs_record_id ON public.audit_logs USING btree (record_id);

CREATE INDEX idx_audit_logs_table_name ON public.audit_logs USING btree (table_name);

CREATE INDEX idx_people_search ON public.people USING btree (school_id, last_name_normalized, first_name_normalized);

CREATE TRIGGER audit_person_roles_trigger AFTER INSERT OR DELETE OR UPDATE ON public.person_roles FOR EACH ROW EXECUTE FUNCTION public.audit_trigger();


