#!/bin/bash
# docker entrypoint script.

# wait until Postgres is ready
until pg_isready -h postgres_db -p 5432 -U doofinder
do
  echo "$(date) - waiting for database to start"
  sleep 2;
done

bin="/doofinder_books/bin/doofinder_books"
#eval "$bin eval \"DoofinderBooks.Release.migrate\""
# start the elixir application
exec "$bin" "start"