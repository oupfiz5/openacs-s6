#!/usr/bin/with-contenv bash

until PGPASSWORD="${PGPASSWORD}" pg_isready -h "${PGHOST}" -U "${PGUSER}"; do
    >&2 echo "wait-postgres-onetime.sh: Postgres db is unavailable - sleeping"
    sleep 1
done

>&2 echo "wait-postgres-onetime.sh: PostgreSQL on host <${PGHOST}> for db user <${PGUSER}> is ready."
