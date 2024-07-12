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
# Apply default cinnamon-layout-system IF none detected
# ------------------------------------------------------------------------------
# not using a Cinnamon-Layout means "default" and Wasta default is to use
#   cinnamon-layout-system redmond7

SYSTEM_LAYOUT=$(find /usr/share/glib-2.0/schemas/ -maxdepth 1 -type l \
    -name "z_15_cinnamon-layout*" 2>/dev/null)

if [[ -z "$SYSTEM_LAYOUT" ]]
then
    echo
    echo "*** Applying cinnamon-layout-system redmond7"
    echo
    cinnamon-layout-system redmond7
fi

# ------------------------------------------------------------------------------
# xdg-mime: ensure there are reasonable file extension defaults
# ------------------------------------------------------------------------------
if ! [ -f /usr/share/applications/defaults.list ]; then
  if [ -f /usr/share/applications/gnome-mimeapps.list ]; then
    cp /usr/share/applications/{gnome-mimeapps.list,defaults.list}
    echo
    echo "*** Copied missing mimeapps defaults.list from gnome's list"
    echo
  else
    echo "!!! WARNING: no mimeapps defaults.list !!!"
  fi
fi

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
