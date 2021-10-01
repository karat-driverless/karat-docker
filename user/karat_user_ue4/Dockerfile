## @file
# Extends a user-specific user container by the UE4 container entry point.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

ARG BASEIMAGE
FROM ${BASEIMAGE}

# TODO: Volumes to cache intermediate files.

ENTRYPOINT ["/opt/unreal/Engine/Binaries/Linux/UE4Editor"]
