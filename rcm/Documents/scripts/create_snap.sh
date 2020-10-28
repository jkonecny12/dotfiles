#!/bin/bash
#
# Utility to solve backups between major system upgrades. This tool will always remove
# the old snapshot and creates a new one.
#
# This utility will remove snapshot from the old system and from the current one
# before creting new.
#
# This script has to be executed under root.
#

set -eu

if [ $(id -u) -ne 0 ]; then
    echo "This script must have root privileges"
    exit 1
fi


# Change these values if they device name changes
SNAP_NAME_POSTFIX=pre_upgrade
LV_NAME=root
VG_NAME=jkonecny_laptop


CURRENT_SYSTEM_NUM=$(cat /etc/os-release | grep "VERSION_ID=")
CURRENT_SYSTEM_NUM=${CURRENT_SYSTEM_NUM##VERSION_ID=}

NEW_SNAP_NAME=${LV_NAME}_f${CURRENT_SYSTEM_NUM}_${SNAP_NAME_POSTFIX}
# Snapshot have name of version before update is executed
OLD_SNAP_NAME=${LV_NAME}_f$((CURRENT_SYSTEM_NUM - 1))_${SNAP_NAME_POSTFIX}


echo "Removing old LVM snapshot: ${OLD_SNAP_NAME}"
DISPLAY_OUTPUT=$(lvdisplay -S "lv_name = ${OLD_SNAP_NAME} && origin = ${LV_NAME} && vg_name = ${VG_NAME}")
if [ -n "$DISPLAY_OUTPUT" ]; then
    echo "Removing old LVM snapshot"
    lvremove ${VG_NAME}/${OLD_SNAP_NAME}
else
    echo "Old snapshot was not found"
fi

DISPLAY_OUTPUT=$(lvdisplay -S "lv_name = ${NEW_SNAP_NAME} && origin = ${LV_NAME} && vg_name = ${VG_NAME}")
if [ -n "$DISPLAY_OUTPUT" ]; then
    echo "Removing old version of snapshot: ${NEW_SNAP_NAME}"
    lvremove ${VG_NAME}/${NEW_SNAP_NAME}
fi

echo "Creating new snapshot: ${NEW_SNAP_NAME}"
lvcreate -n ${NEW_SNAP_NAME} -s ${VG_NAME}/${LV_NAME}
