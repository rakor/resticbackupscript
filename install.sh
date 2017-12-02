#!/bin/sh
# 
# This script does nearly nothing.. But I am lazy

SCRIPT="resticbackup resticcmd"
TARGET=/usr/local/bin
PERMISSIONS=555

SCRIPTDIR=`dirname $0`

if [ `id -u` != "0" ]; then
	echo "Must be run as root"
	exit 1
fi

# determin the fileowner to set later
case  "$(uname -s)" in
	FreeBSD)
		OWNER="root:wheel"
		;;
	Linux)
		OWNER="root:root"
		;;
	*) 
		echo "Dont know the operating System. Doing nothing"
		echo "You should change the owner of the script"
esac

for i in $SCRIPT ; do
	#copy the script
	cp $SCRIPTDIR/$i $TARGET
	#change the permissions
	chmod $PERMISSIONS $TARGET/$i
	#change the owner
	if [ -n "$OWNER" ]; then
		chown $OWNER $TARGET/$i
	fi
	echo "Installed $i in $TARGET with owner $OWNER and permissions $PERMISSIONS."
done

