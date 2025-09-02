FROM flyway/flyway:10
# копируете sql из persistence-репо, например через build context или артефакт
COPY migrations /flyway/sql
ENTRYPOINT ["flyway"]
