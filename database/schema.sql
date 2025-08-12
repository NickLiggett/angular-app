-- Enable extension for UUID generation
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Create app_user table
CREATE TABLE IF NOT EXISTS app_user
(
  id                       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  first_name               VARCHAR(100) NOT NULL,
  last_name                VARCHAR(100) NOT NULL,
  email                    VARCHAR(255) NOT NULL UNIQUE,
  role                     VARCHAR(50) DEFAULT 'USER',
  username                 VARCHAR(100) NOT NULL UNIQUE,
  password                 VARCHAR(255) NOT NULL,
  password_change_required BOOLEAN     DEFAULT FALSE,
  created_date             TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
  last_login               TIMESTAMP,
  active                   BOOLEAN     DEFAULT TRUE
  );

-- Create verification_token table
CREATE TABLE IF NOT EXISTS verification_token
(
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  token        VARCHAR(255) NOT NULL UNIQUE,
  user_id      UUID         NOT NULL,
  expiry_date  TIMESTAMP    NOT NULL,
  created_date TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_user
  FOREIGN KEY (user_id)
  REFERENCES app_user (id)
  ON DELETE CASCADE
  );

-- Create indexes for better performance
-- (email already has an implicit index from UNIQUE)
CREATE INDEX IF NOT EXISTS idx_users_role ON app_user (role);
CREATE INDEX IF NOT EXISTS idx_users_active ON app_user (active);
CREATE INDEX IF NOT EXISTS idx_users_created_date ON app_user (created_date);

-- Insert sample data (passwords will be encoded by migratePasswords())
INSERT INTO app_user (first_name, last_name, email, role, username, password, active)
VALUES
  ('John', 'Doe', 'john.doe@example.com', 'ADMIN', 'admin', 'admin', true),
  ('Jane', 'Smith', 'jane.smith@example.com', 'MANAGER', 'jane.smith', 'Password1', true),
  ('Bob', 'Johnson', 'bob.johnson@example.com', 'USER', 'bob.johnson', 'Password1', true),
  ('Alice', 'Brown', 'alice.brown@example.com', 'USER', 'alice.brown', 'Password1', false),
  ('Charlie', 'Wilson', 'charlie.wilson@example.com', 'MANAGER', 'charlie.wilson', 'Password1', true),
  ('Diana', 'Martinez', 'diana.martinez@example.com', 'USER', 'diana.martinez', 'Password1', true),
  ('Edward', 'Taylor', 'edward.taylor@example.com', 'USER', 'edward.taylor', 'Password1', true),
  ('Fiona', 'Anderson', 'fiona.anderson@example.com', 'MANAGER', 'fiona.anderson', 'Password1', false),
  ('George', 'Thomas', 'george.thomas@example.com', 'USER', 'george.thomas', 'Password1', true),
  ('Helen', 'Jackson', 'helen.jackson@example.com', 'MANAGER', 'helen.jackson', 'Password1', true)
  ON CONFLICT (email) DO NOTHING;

-- Create a view for active app_user
CREATE OR REPLACE VIEW active_users AS
SELECT id, first_name, last_name, email, role, created_date
FROM app_user
WHERE active = true;
