#!/bin/sh

## @file
# Set appropriate TAG variables if not set by the environment.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

set -e

# Set default ROS_TAG.
[ -z "${KARAT_ROS_TAG}" ] && ROS_TAG=noetic || ROS_TAG=${KARAT_ROS_TAG}

# Set default UBUNTU_TAG based on ROS_TAG.
if [ -z "${KARAT_UBUNTU_TAG}" ]; then
    if [ "${ROS_TAG}" = "melodic" ]; then
        UBUNTU_TAG=bionic
    elif [ "${ROS_TAG}" = "noetic" ]; then
        UBUNTU_TAG=focal
    else
        echo "Cannot determine correct UBUNTU_TAG for ROS_TAG ${ROS_TAG}." 1>&2
        exit 1
    fi
else
    UBUNTU_TAG=${KARAT_UBUNTU_TAG}
fi

# Set default ROS_PYTHON based on ROS_TAG. Assume anything different from
# 'bionic' is newer.
if [ -z "${KARAT_ROS_PYTHON}" ]; then
    if [ "${ROS_TAG}" != "melodic" ]; then
        ROS_PYTHON=3
    else
        ROS_PYTHON=
    fi
else
    ROS_PYTHON=${KARAT_ROS_PYTHON}
fi

# Set default UE4_VER_TAG.
[ -z "${UE4_VER_TAG}" ] && UE4_VER_TAG=4.26.1 || UE4_VER_TAG=${UE4_VER_TAG}

# Set default KARAT_NPROC.
[ -z "${KARAT_NPROC}" ] && NPROC=$(($(nproc)/2)) || NPROC=${KARAT_NPROC}
