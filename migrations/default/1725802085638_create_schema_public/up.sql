-- migrations/1_create_project_and_status_tables.sql

-- Create the project_status table
CREATE TABLE project_status (
    value TEXT PRIMARY KEY,    
    description TEXT
);

-- Insert initial data into project_status
INSERT INTO project_status (value, description) VALUES
('NotStarted', 'Not Started'), -- Project has been created but work has not begun
('InProgress', 'In Progress'), -- Project is currently being worked on
('OnHold', 'On Hold'), -- Project has been temporarily paused
('Completed', 'Completed'), -- Project has been finished
('Cancelled', 'Cancelled'); -- Project has been terminated before completion

-- Create the project table
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    status TEXT REFERENCES project_status(value) DEFAULT 'NotStarted',
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create a function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$
 language 'plpgsql';

-- Create triggers to automatically update the updated_at column
CREATE TRIGGER update_project_updated_at
BEFORE UPDATE ON projects
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

