#!/bin/bash
set -e  # Arrêter en cas d'erreur

# Vérifier que les variables d'environnement existent
if [ -z "$WORDPRESS_DB_HOST" ] || [ -z "$WORDPRESS_DB_USER" ] || [ -z "$WORDPRESS_DB_PASSWORD" ] || [ -z "$WORDPRESS_DB_NAME" ]; then
  echo "❌ ERREUR: Les variables d'environnement de la base de données ne sont pas définies."
  exit 1
fi

CONFIG_FILE="/var/www/html/wp-config.php"

echo "📌 Génération de wp-config.php..."

cat > "$CONFIG_FILE" <<EOF
<?php
define( 'DB_NAME', '${WORDPRESS_DB_NAME}' );
define( 'DB_USER', '${WORDPRESS_DB_USER}' );
define( 'DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}' );
define( 'DB_HOST', '${WORDPRESS_DB_HOST}' );
define( 'DB_CHARSET', 'utf8mb4' );
define( 'DB_COLLATE', '' );

/* Clés de sécurité générées */
define( 'AUTH_KEY',         '$(openssl rand -base64 32)' );
define( 'SECURE_AUTH_KEY',  '$(openssl rand -base64 32)' );
define( 'LOGGED_IN_KEY',    '$(openssl rand -base64 32)' );
define( 'NONCE_KEY',        '$(openssl rand -base64 32)' );
define( 'AUTH_SALT',        '$(openssl rand -base64 32)' );
define( 'SECURE_AUTH_SALT', '$(openssl rand -base64 32)' );
define( 'LOGGED_IN_SALT',   '$(openssl rand -base64 32)' );
define( 'NONCE_SALT',       '$(openssl rand -base64 32)' );

/* Préfixe des tables */
\$table_prefix = 'wp_';

/* Désactiver l'édition de fichiers depuis l'admin */
define( 'DISALLOW_FILE_EDIT', true );

/* Chemin absolu vers WordPress */
if ( !defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname(__FILE__) . '/' );
}
require_once ABSPATH . 'wp-settings.php';
EOF

echo "✅ wp-config.php généré avec succès."

# Assurer les bons droits
chown www-data:www-data "$CONFIG_FILE"
chmod 644 "$CONFIG_FILE"
