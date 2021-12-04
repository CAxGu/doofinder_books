#!/bin/bash
set -e
export PGPASSWORD=$POSTGRES_PASSWORD;
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';
  CREATE DATABASE $APP_DB_NAME;
  GRANT ALL PRIVILEGES ON DATABASE $APP_DB_NAME TO $APP_DB_USER;
  \connect $APP_DB_NAME $APP_DB_USER

BEGIN;
	CREATE TABLE IF NOT EXISTS authors (
		id SERIAL  NOT NULL PRIMARY KEY,
		fullname VARCHAR(255) NOT NULL,
		pseudonym VARCHAR(255) NULL,
		birth TIMESTAMP NOT NULL,
		death DATE NULL,
		nationality VARCHAR(255) NULL,
		inserted_at TIMESTAMP NOT NULL,
		updated_at TIMESTAMP NOT NULL);
COMMIT;
BEGIN;
	CREATE TABLE IF NOT EXISTS books (
		id SERIAL  NOT NULL PRIMARY KEY,
		isbn VARCHAR(255) NOT NULL,
		title VARCHAR(255) NOT NULL,
		description TEXT NULL,
		publishing_date DATE NOT NULL,
		retired_date DATE NULL,
		publishing VARCHAR(255) NOT NULL,
		language VARCHAR(255) NULL,
		inserted_at TIMESTAMP NOT NULL,
		updated_at TIMESTAMP NOT NULL);
COMMIT;
BEGIN;
	CREATE TABLE IF NOT EXISTS categories (
		id SERIAL  NOT NULL PRIMARY KEY,
		name VARCHAR(255) NOT NULL,
		description TEXT NULL,
		inserted_at TIMESTAMP NOT NULL,
		updated_at TIMESTAMP NOT NULL);
COMMIT;
BEGIN;
	CREATE TABLE IF NOT EXISTS rel_books_authors (
		id SERIAL  NOT NULL PRIMARY KEY,
		book_id BIGINT NOT NULL,
		author_id BIGINT NOT NULL,
		inserted_at TIMESTAMP NOT NULL,
		updated_at TIMESTAMP NOT NULL,
		CONSTRAINT author_id_fk FOREIGN KEY (author_id) REFERENCES public.authors (id) ,
		CONSTRAINT book_id_fk FOREIGN KEY (book_id) REFERENCES public.books (id));
		CREATE UNIQUE INDEX id_bookauthors ON rel_books_authors (book_id);
COMMIT;
BEGIN;
	CREATE TABLE IF NOT EXISTS rel_books_categories (
		id SERIAL  NOT NULL PRIMARY KEY,
		book_id BIGINT NOT NULL,
		category_id BIGINT NOT NULL,
		inserted_at TIMESTAMP NOT NULL,
		updated_at TIMESTAMP NOT NULL,
		CONSTRAINT book_id_fk FOREIGN KEY (book_id) REFERENCES public.books (id) ,
		CONSTRAINT category_id_fk FOREIGN KEY (category_id) REFERENCES public.categories (id));
		CREATE UNIQUE INDEX id_bookcategories ON rel_books_categories (book_id);
COMMIT;
EOSQL