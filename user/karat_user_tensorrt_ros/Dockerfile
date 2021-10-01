## @file
# Extends a user-specific user container by the ROS container entry point.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

#
# TODO: Duplicate of karat_user_ros.
#

ARG BASEIMAGE
FROM ${BASEIMAGE}

# Execute 'rosdep update' if it has not yet been executed before.
ENTRYPOINT ["bash", "-c", "[[ ! -d ~/.ros/rosdep/sources.cache ]] && rosdep update ; bash"]
