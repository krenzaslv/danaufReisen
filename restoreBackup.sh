#!/bin/bash

docker-compose down --remove-orphans

. ./.env
BACKUP_FILE_ENCRYPTED=$1
BACKUP_FILE=${BACKUP_FILE_ENCRYPTED::-4}

gpg -d -o $BACKUP_FILE $BACKUP_FILE_ENCRYPTED

mkdir -p ${WP_PATH}
mkdir -p ${MYSQL_DB_RESTORE_PATH}
mkdir -p ${MYSQL_DB_VOLUME_PATH}

echo "Extracting backup"
tar -xvf $BACKUP_FILE 
echo "Extracting wp-backup"
tar -xf ${BACKUP_PATH}/${WP_BACKUP_NAME} 

mv ${BACKUP_PATH}/${MYSQL_DB_BACKUP_NAME} ${MYSQL_DB_RESTORE_PATH}

echo "cleanup ..."
rm -rf ${BACKUP_PATH}
rm -f ${BACKUP_FILE}
