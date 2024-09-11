-- Create the 'identity' schema
CREATE SCHEMA "identity";

-- Create the 'parties' table
CREATE TABLE "identity"."parties" (
    "party_id" SERIAL NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "idp_id" TEXT NOT NULL,
    PRIMARY KEY ("party_id")
);

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

-- Create the 'party_roles' table with foreign key constraints
CREATE TABLE "identity"."party_roles" (
    "party_role_id" SERIAL NOT NULL,
    "party_id" INTEGER NOT NULL,
    "role_type_id" TEXT NOT NULL,
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
