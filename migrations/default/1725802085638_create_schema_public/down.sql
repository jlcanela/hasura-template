-- Combined down migration

-- Drop triggers
DROP TRIGGER IF EXISTS update_project_updated_at ON projects;
DROP TRIGGER IF EXISTS update_party_roles_updated_at ON "identity"."party_roles";
DROP TRIGGER IF EXISTS update_parties_updated_at ON "identity"."parties";

-- Drop function
DROP FUNCTION IF EXISTS update_updated_at_column();
DROP FUNCTION IF EXISTS "identity".party_full_name();

-- Drop tables
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS project_status;
DROP TABLE IF EXISTS "identity"."party_roles";
DROP TABLE IF EXISTS "identity"."role_type";
DROP TABLE IF EXISTS "identity"."parties";

-- Drop schema
DROP SCHEMA IF EXISTS "identity" CASCADE;
