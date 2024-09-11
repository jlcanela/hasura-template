-- Create the project assignment table
CREATE TABLE project_assignments (
    project_id INTEGER NOT NULL,
    party_role_id INTEGER NOT NULL,
    FOREIGN KEY (project_id) 
        REFERENCES projects (id) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
    FOREIGN KEY (party_role_id) 
        REFERENCES identity.party_roles (party_role_id) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
    PRIMARY KEY (project_id, party_role_id)
);
