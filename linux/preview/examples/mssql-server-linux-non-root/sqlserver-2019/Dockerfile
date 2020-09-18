# The official SQL Server 2019 docker image does not have "Full-Text Search"
# component installed out of the box, https://github.com/microsoft/mssql-docker/issues/161.
#
# This dockerfile creates an image that installs the "Full-Text Search" component
# based upon the Microsoft official image. Note that the official image runs
# SQL Server 2019 as a non-root user (https://github.com/microsoft/mssql-docker/issues/575).
# Thus it is required to switch to root user to install the prerequisite tools
# and the optional SQL Server components (mssql-server-ha and mssql-server-fts),
# and then swithing back to the non-root user (mssql) to start SQL Server.
#
# Build the docker image:
#   docker build -t sqlserver-2019:private .
# Create and run the container:
#   docker run --name mssql-x -h mssql-x `
#              -e "ACCEPT_EULA=Y" `
#              -e "SA_PASSWORD=<YourSA$Password>" `
#              -e "MSSQL_AGENT_ENABLED=true" `
#              -p 1433:1433 `
#              -v /docker/shares/sqlserver:/sql `
#              -d sqlserver-2019:private
# Verify:
#   login to the container shell:
#       docker exec -it mssql-x "bash"
#   launch sqlcmd:
#       /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "<YourSA$Password>"
#   run these two SQL command to validate the SQL Server is running OK:
#       SELECT @@ServerName, @@Version;
#       SELECT FULLTEXTSERVICEPROPERTY('IsFullTextInstalled');
#

# Base container image
FROM mcr.microsoft.com/mssql/server:2019-latest

USER root
RUN export DEBIAN_FRONTEND=noninteractive APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn && \
    # Install prerequisites
    apt-get update && \
    apt-get install -y apt-utils sudo vim gnupg curl apt-transport-https && \
    # Get official Microsoft repository configuration
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list | tee /etc/apt/sources.list.d/mssql-server-2019.list && \
    # Install optional packages
    apt-get update && \
    apt-get install -y mssql-server-ha && \
    apt-get install -y mssql-server-fts && \
    # Cleanup the Dockerfile
    apt-get clean && \
    rm -rf /var/apt/cache/* /var/lib/apt/lists

# Start SQL Server as user 'mssql'
USER mssql
CMD ["/opt/mssql/bin/sqlservr"]
