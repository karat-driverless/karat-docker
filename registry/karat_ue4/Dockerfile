## @file
# Temporary builder to extract a local build of UE4.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

# If the temporary builder was untagged, image prune would clean it.
ARG BASEIMAGE
ARG BUILDIMAGE
FROM ${BUILDIMAGE} AS builder

# Extends the base image by an installed build of UE4.
FROM ${BASEIMAGE}

# Copy the local build from the builder container to the base image.
COPY --from=builder /home/ue4/unreal/LocalBuilds/Engine/Linux/ /opt/unreal
