# mssql-jdbc-login-sample
Contains a sample to reproduce a login failure on a docker hosted sqlserver with jdbc

## Setup
To reproduce the failed login start the sql server in the docker container:
```
docker-compose up
```

Then execute the database migrations (liquibase) via the provided batch file.
```
RunLiquibaseAgainstDocker.bat
```
