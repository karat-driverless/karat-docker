## @file
# Extends Ubuntu for container usage.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

ARG BASEIMAGE
FROM ${BASEIMAGE}

# Disable user interaction for headless container setup.
ENV DEBIAN_FRONTEND=noninteractive

# Use UTF-8 encoding system-wide.
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Set the default timezone to UTC.
# Create a centralised setup script for later stages and source it system-wide.
RUN echo 'Etc/UTC' > /etc/timezone &&\
    ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime &&\
    echo "" > /etc/karat_setup.sh &&\
    chmod 755 /etc/karat_setup.sh &&\
    echo ". /etc/karat_setup.sh" >> /etc/bash.bashrc

# Install miscellaneous packages for APT usage.
RUN apt-get update -q &&\
    apt-get install -yq --no-install-recommends dirmngr gnupg2 apt-utils tzdata\
        software-properties-common wget &&\
    rm -rf /var/lib/apt/lists/*
