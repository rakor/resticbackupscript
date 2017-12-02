#!/bin/sh
# 
# This script does nearly nothing.. But I am lazy

SCRIPT=resticbackup
TARGET=/usr/local/bin
PERMISSIONS=555

SCRIPTDIR=`dirname $0`

if [ `id -u` != "0" ]; then
	echo "Must be run as root"
	exit 1
fi

# Only do anything if the script has changed. 
if cmp -s $SCRIPTDIR/$SCRIPT $TARGET/$SCRIPT ; then
	echo "Files are identical. Nothing to do. Exiting"
	exit 2
else
	echo "Installing $SCRIPT..."
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

#copy the script
cp $SCRIPTDIR/$SCRIPT $TARGET
#change the permissions
chmod $PERMISSIONS $TARGET/$SCRIPT
#change the owner
if [ -n "$OWNER" ]; then
	chown $OWNER $TARGET/$SCRIPT
fi

echo "Installed in $TARGET/$SCRIPT with owner $OWNER and permissions $PERMISSIONS."
