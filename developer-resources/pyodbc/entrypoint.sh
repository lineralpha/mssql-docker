echo "This container includes everything necessary to start working with Python against SQL Server. Contents:\n\t- ODBC Drivers\n\t- pyodbc connector module.\n\t- A working Python to SQL Server sample.\n\t- SQL Server command-line utilities.\n\nTo start a shell session with this container:\n\tdocker run -it microsoft/pyodbc /bin/bash"



echo "Provided environment variables:\n\t- Host:$DB_HOST\n\t- User:$DB_USERNAME\n\t- Password:$DB_PASSWORD"

