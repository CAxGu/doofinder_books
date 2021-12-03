-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         PostgreSQL 14.1 (Debian 14.1-1.pgdg110+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 10.2.1-6) 10.2.1 20210110, 64-bit
-- SO del servidor:              
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES  */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Volcando estructura para tabla public.authors
CREATE TABLE IF NOT EXISTS "authors" (
	"id" BIGINT NOT NULL DEFAULT 'nextval(''authors_id_seq''::regclass)',
	"fullname" VARCHAR(255) NOT NULL,
	"pseudonym" VARCHAR(255) NULL DEFAULT NULL,
	"birth" DATE NOT NULL,
	"death" DATE NULL DEFAULT NULL,
	"nationality" VARCHAR(255) NULL DEFAULT NULL,
	"inserted_at" TIMESTAMP NOT NULL,
	"updated_at" TIMESTAMP NOT NULL,
	PRIMARY KEY ("id")
);

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla public.books
CREATE TABLE IF NOT EXISTS "books" (
	"id" BIGINT NOT NULL DEFAULT 'nextval(''books_id_seq''::regclass)',
	"isbn" VARCHAR(255) NOT NULL,
	"title" VARCHAR(255) NOT NULL,
	"description" TEXT NULL DEFAULT NULL,
	"publishing_date" DATE NOT NULL,
	"retired_date" DATE NULL DEFAULT NULL,
	"publishing" VARCHAR(255) NOT NULL,
	"language" VARCHAR(255) NULL DEFAULT NULL,
	"inserted_at" TIMESTAMP NOT NULL,
	"updated_at" TIMESTAMP NOT NULL,
	PRIMARY KEY ("id")
);

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla public.categories
CREATE TABLE IF NOT EXISTS "categories" (
	"id" BIGINT NOT NULL DEFAULT 'nextval(''categories_id_seq''::regclass)',
	"name" VARCHAR(255) NOT NULL,
	"description" TEXT NULL DEFAULT NULL,
	"inserted_at" TIMESTAMP NOT NULL,
	"updated_at" TIMESTAMP NOT NULL,
	PRIMARY KEY ("id")
);

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla public.rel_books_authors
CREATE TABLE IF NOT EXISTS "rel_books_authors" (
	"id" BIGINT NOT NULL DEFAULT 'nextval(''rel_books_authors_id_seq''::regclass)',
	"book_id" BIGINT NOT NULL,
	"author_id" BIGINT NOT NULL,
	"inserted_at" TIMESTAMP NOT NULL,
	"updated_at" TIMESTAMP NOT NULL,
	PRIMARY KEY ("id"),
	UNIQUE INDEX "id_bookauthors" ("book_id"),
	CONSTRAINT "author_id_fk" FOREIGN KEY ("author_id") REFERENCES "public"."authors" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "book_id_fk" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla public.rel_books_categories
CREATE TABLE IF NOT EXISTS "rel_books_categories" (
	"id" BIGINT NOT NULL DEFAULT 'nextval(''rel_books_categories_id_seq''::regclass)',
	"book_id" BIGINT NOT NULL,
	"category_id" BIGINT NOT NULL,
	"inserted_at" TIMESTAMP NOT NULL,
	"updated_at" TIMESTAMP NOT NULL,
	PRIMARY KEY ("id"),
	UNIQUE INDEX "id_bookcategories" ("book_id"),
	CONSTRAINT "book_id_fk" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "category_id_fk" FOREIGN KEY ("category_id") REFERENCES "public"."categories" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla public.schema_migrations
CREATE TABLE IF NOT EXISTS "schema_migrations" (
	"version" BIGINT NOT NULL,
	"inserted_at" TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY ("version")
);

-- La exportación de datos fue deseleccionada.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
