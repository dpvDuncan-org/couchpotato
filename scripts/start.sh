#! /bin/sh
chown -R $PUID:$PGID /config

GROUPNAME=$(getent group $PGID | cut -d: -f1)
USERNAME=$(getent passwd $PUID | cut -d: -f1)

if [ ! $GROUPNAME ]
then
        addgroup -g $PGID couchpotato
        GROUPNAME=couchpotato
fi

if [ ! $USERNAME ]
then
        adduser -G $GROUPNAME -u $PUID -D couchpotato
        USERNAME=couchpotato
fi

su $USERNAME -c '/opt/couchpotato/CouchPotato.py --data_dir=/config'
