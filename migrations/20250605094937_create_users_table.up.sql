CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


CREATE TABLE users (
  id uuid PRIMARY KEY NOT NULL DEFAULT (uuid_generate_v4()),
  full_name VARCHAR(100),
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash TEXT,
  role VARCHAR(20) CHECK (role IN ('client', 'freelancer')),
  bio TEXT,
  location VARCHAR(100),
  profile_picture TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);