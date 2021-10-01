## @file
# Extends a common user container by user-specific components.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

ARG BASEIMAGE
FROM ${BASEIMAGE}

# Run as root by default as this is the Docker default.
ARG USER=root
ARG UID=0
ARG GID=0

# Allow the user sudo access in the container.
# Enable PulseAudio passthrough.
RUN echo "$USER  ALL=(ALL) ALL" >> /etc/sudoers &&\
    echo\
    "default-server = unix:/run/user/$UID/pulse/native\n\
    autospawn = no\n\
    daemon-binary = /bin/true\n\
    enable-shm = false\n" > /etc/pulse/client.conf

# Login as the defined user.
USER $UID:$GID
WORKDIR /home/$USER/
