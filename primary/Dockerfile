FROM postgres:13

ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin123
ENV POSTGRES_DB=postgresdb
ENV PGDATA=/data

VOLUME /data
VOLUME /config
VOLUME /mnt/server/archive

CMD ["postgres", "-c", "config_file=/config/postgresql.conf"]