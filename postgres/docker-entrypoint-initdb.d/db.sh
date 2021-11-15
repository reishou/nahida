#!/bin/bash

set -e
set -u

function create_user_and_database_with_postgis() {
  local database=$1
  echo "  Creating user and database '$database'"
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER $database;
    CREATE DATABASE $database;
    GRANT ALL PRIVILEGES ON DATABASE $database TO $database;
    CREATE EXTENSION IF NOT EXISTS postgis;
    CREATE EXTENSION IF NOT EXISTS postgis_topology;
    CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
    CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;
EOSQL
}

if [ -n "$POSTGRES_MULTIPLE_DATABASES_WITH_POSTGIS" ]; then
  echo "Multiple database creation requested: $POSTGRES_MULTIPLE_DATABASES_WITH_POSTGIS"
  for db in $(echo "$POSTGRES_MULTIPLE_DATABASES_WITH_POSTGIS" | tr ',' ' '); do
    create_user_and_database_with_postgis "$db"
  done
  echo "Multiple databases created"
fi
