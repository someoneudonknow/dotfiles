#!/bin/bash
set -e

if [ ! -f /var/lib/postgresql/data/PG_VERSION ]; then
    until PGUSER=postgres PGPASSWORD=1q2w3e psql -h primary -c "SELECT 1" > /dev/null 2>&1; do
        echo "Waiting for primary to be ready..."
        sleep 1
    done

    PGUSER=postgres PGPASSWORD=1q2w3e psql -h primary -c "DO \$\$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'replicator') THEN CREATE ROLE replicator WITH REPLICATION LOGIN ENCRYPTED PASSWORD 'replicator_password'; END IF; END \$\$;"

    # Create replication slot if it doesn’t exist
    PGUSER=postgres PGPASSWORD=1q2w3e psql -h primary -c "DO \$\$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_replication_slots WHERE slot_name = 'replication_slot_1') THEN PERFORM pg_create_physical_replication_slot('replication_slot_1'); END IF; END \$\$;"

    rm -rf /var/lib/postgresql/data/* && pg_basebackup --pgdata=/var/lib/postgresql/data -R --slot=replication_slot_1
    chown -R postgres:postgres /var/lib/postgresql/data && chmod 0700 /var/lib/postgresql/data
fi

su postgres -c postgres
