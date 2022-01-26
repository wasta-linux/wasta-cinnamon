#!/bin/bash

# ==============================================================================
# wasta-cinnamon-postinst.sh
#
#   This script is automatically run by the postinst configure step on
#       installation of wasta-cinnamon-*. It can be manually re-run, but
#       is only intended to be run at package installation.
#
#   2016-02-21 rik: initial script
#   2016-03-02 rik: modifying cinnamon version check
#   2016-03-30 rik: reverting removal of panelEditMode from right-click
#   2016-04-29 rik: cinnamon backgrounds cleanup
#   2016-07-27 rik: cinnamon-backgrounds-settings: symlink if doesn't exist
#   2016-09-28 rik: adding nemo permissions to evince (so can 'open containing
#       folder')
#   2016-10-07 rik: notifications applet: set to show empty tray by default
#   2016-10-31 rik: adding gtk scrollbar fix (so will scroll 'one page at a
#       time')
#   2017-03-15 rik: cleaning up cinnamon json sed selections (to match only
#       within the specified block of code)
#   2017-11-22 rik: cleaning up "send by email" nemo action logic
#       - wallpapers name fix: adding 0-9 to matching so that system76 is
#       is matched, for example.
#   2017-12-03 rik: initial bionic release
#   2018-04-03 rik: removing schemas compile: schemas now in
#       wasta-cinnmaon-layout-3-6
#   2018-04-04 rik: re-adding schemas compile
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

# ------------------------------------------------------------------------------
# Dconf / Gsettings Default Value adjustments
# ------------------------------------------------------------------------------
echo
echo "*** Updating dconf / gsettings default values"
echo

# MAIN System schemas: we have placed our override file in this directory
# Sending any "error" to null (if key not found don't want to worry user)
glib-compile-schemas /usr/share/glib-2.0/schemas/ > /dev/null 2>&1 || true;

# ------------------------------------------------------------------------------
# Finished
# ------------------------------------------------------------------------------
echo
echo "*** Script Exit: wasta-cinnamon-postinst.sh"
echo

exit 0
