-- Combined up migration

-- Create the 'identity' schema
CREATE SCHEMA "identity";

-- Create a function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$
 language 'plpgsql';

-- Create the 'parties' table with timestamp fields
CREATE TABLE "identity"."parties" (
    "party_id" SERIAL NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "idp_id" TEXT NOT NULL,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("party_id")
);

CREATE FUNCTION identity.party_full_name(party_row identity.parties)
RETURNS TEXT AS $$
  SELECT party_row.first_name || ' ' || party_row.last_name
$$
 LANGUAGE sql STABLE;
 
-- Create trigger for parties table
CREATE TRIGGER update_parties_updated_at
BEFORE UPDATE ON "identity"."parties"
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Create the 'role_type' table
CREATE TABLE "identity"."role_type" (
    "value" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    PRIMARY KEY ("value")
);

-- Insert initial data into 'role_type' table
INSERT INTO "identity"."role_type" ("description", "value") VALUES
    ('Project Lead', 'ProjectLead'),
    ('Administrator', 'Administrator'),
    ('Developer', 'Developer');

-- Create the 'party_roles' table with foreign key constraints and timestamp fields
CREATE TABLE "identity"."party_roles" (
    "party_role_id" SERIAL NOT NULL,
    "party_id" INTEGER NOT NULL,
    "role_type_id" TEXT NOT NULL,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("party_role_id"),
    FOREIGN KEY ("party_id") 
        REFERENCES "identity"."parties" ("party_id") 
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
    FOREIGN KEY ("role_type_id") 
        REFERENCES "identity"."role_type" ("value") 
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);

-- Create trigger for party_roles table
CREATE TRIGGER update_party_roles_updated_at
BEFORE UPDATE ON "identity"."party_roles"
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Create the project_status table
CREATE TABLE project_status (
    value TEXT PRIMARY KEY,    
    description TEXT
);

-- Insert initial data into project_status
INSERT INTO project_status (value, description) VALUES
('NotStarted', 'Not Started'),
('InProgress', 'In Progress'),
('OnHold', 'On Hold'),
('Completed', 'Completed'),
('Cancelled', 'Cancelled');

-- Create the project table with owner field
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    status TEXT REFERENCES project_status(value) DEFAULT 'NotStarted',
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    owner INTEGER REFERENCES "identity"."parties"("party_id")
);

-- Create trigger for projects table
CREATE TRIGGER update_project_updated_at
BEFORE UPDATE ON projects
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();
