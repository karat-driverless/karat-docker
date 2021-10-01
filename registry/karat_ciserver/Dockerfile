## @file
# Extends the base image by the CI server environment.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

ARG BASEIMAGE
FROM ${BASEIMAGE}

# Install openssh-client to be able to clone private repositories.
# /root/.ssh/ is mounted from the host and contains the CI key.
RUN apt-get update -yq &&\
    apt-get install -yq --no-install-recommends openssh-client &&\
    rm -rf /var/lib/apt/lists/*

# Source the KaRaT setup script into the non-interactive shell.
ENV BASH_ENV "/etc/karat_setup.sh"
