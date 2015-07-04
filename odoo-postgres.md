# docker with postgres for odoo

start a postgres instance
'''
docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres
'''
This image includes EXPOSE 5432 (the postgres port), so standard container linking will 
make it automatically available to the linked containers. The default postgres user and database are created in the entrypoint with initdb.

The postgres database is a default database meant for use by users, utilities and third party applications.
http://postgresql.org/docs connect to it from an application

'''
docker run --name some-app --link some-postgres:postgres -d application-that-uses-postgres

# or via psql
docker run -it --link some-postgres:postgres --rm postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'

docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name db postgres
docker run -p 0.0.0.0:8069:8069 --name odoo --link db:db -t odoo

docker run -p 0.0.0.0:5432:5432 -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name db postgres_1
docker run -p 0.0.0.0:8069:8069 --name odoo2 --link db:db -t odoo_2

sudo iptables -L -n
```

https://docs.docker.com/examples/postgresql_service/

#### system level postgress backup

tar -cf backup.tar /usr/local/pgsql/data

export TERM=linux
apt-get install -y postgresql-client

### pg_dump
`./pg_dump -U postgres -Fc -f /home/user/sample_backup sample`

 ./pg_restore -l /home/user/sample_backup

./pg_restore -d postgres -U postgres -C /home/user/sample_backup

