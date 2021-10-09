#!/bin/bash

. ./.env

mkdir -p $BACKUP_PATH 
rm -r ${BACKUP_PATH}/*

#Create database backup
mysqldump --databases $WP_MYSQL_DATABASE --add-drop-table -u root -p${WP_MYSQL_ROOT_PASSWORD} -h $MY_SQL_SERVER_ADRESS -P $WP_MYSQL_EXPOSED_PORT | gzip > ${BACKUP_PATH}/${MYSQL_DB_BACKUP_NAME}


#Folder backup & compress
BACKUP_FILE=${BACKUP_NAME}.`date +%Y%m%d-%H%M%S`.tar.gz
tar -czvf ${BACKUP_PATH}/${WP_BACKUP_NAME} ${WP_PATH}
tar -cvzf $BACKUP_FILE ${BACKUP_PATH} 
gpg -c --symmetric $BACKUP_FILE

rm $BACKUP_FILE
rm -r $BACKUP_PATH
