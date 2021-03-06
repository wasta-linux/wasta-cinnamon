#!/bin/bash

# ==============================================================================
# wasta-cinnamon-postinst.sh
#
#   This script is automatically run by the postinst configure step on
#   installation of wasta-cinnamon. It can be manually re-run, but
#   is only intended to be run at package installation.
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Check to ensure running as root
# ------------------------------------------------------------------------------
#   No fancy "double click" here because normal user should never need to run
if [ $(id -u) -ne 0 ]
then
	echo
	echo "You must run this script with sudo." >&2
	echo "Exiting...."
	sleep 5s
	exit 1
fi

# ------------------------------------------------------------------------------
# Initial setup
# ------------------------------------------------------------------------------

echo
echo "*** Script Entry: wasta-cinnamon-postinst.sh"
echo

# Setup Directory for later reference
DIR=/usr/share/wasta-cinnamon
LAYOUT_DIR=/usr/share/cinnamon-layout

# Reconfigure wasta-multidesktop so that login sessions are correctly displayed.
dpkg-reconfigure wasta-multidesktop

# ------------------------------------------------------------------------------
# Dconf / Gsettings Default Value adjustments
# ------------------------------------------------------------------------------
echo
echo "*** Updating dconf / gsettings default values"
echo

# MAIN System schemas: we have placed our override file in this directory
# Sending any "error" to null (if key not found don't want to worry user)
glib-compile-schemas /usr/share/glib-2.0/schemas/ # > /dev/null 2>&1 || true;

# ------------------------------------------------------------------------------
# Finished
# ------------------------------------------------------------------------------
echo
echo "*** Script Exit: wasta-cinnamon-postinst.sh"
echo

exit 0
