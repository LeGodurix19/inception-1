#!/bin/bash
set -e  # Exit immediately if a command fails

echo "📌 Checking environment variables..."
if [[ -z "${MYSQL_ROOT_PASSWORD}" ]]; then
  echo "❌ ERROR: MYSQL_ROOT_PASSWORD is not set."
  exit 1
fi

if [[ -z "${MYSQL_PASSWORD}" ]]; then
  echo "❌ ERROR: MYSQL_PASSWORD is not set."
  exit 1
fi

echo "🟢 Initializing MariaDB..."
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld /var/lib/mysql

echo "⌛ Waiting for MariaDB to be ready..."
mysqld_safe --skip-networking &  # Start MariaDB in the background
sleep 5  # Give it time to initialize

echo "✅ MariaDB is ready!"

# Create database if not exists
DB_EXISTS=$(mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES LIKE 'mydb';" | grep mydb || true)
if [[ -z "$DB_EXISTS" ]]; then
  echo "📌 Creating database 'mydb'..."
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE mydb;"
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER 'myuser'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON mydb.* TO 'myuser'@'%';"
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
else
  echo "✅ Database 'mydb' already exists. Skipping setup."
fi

echo "🚀 Starting MariaDB as the main process..."
exec mysqld --bind-address=0.0.0.0

