## @file
# Extends the base image by the build prerequisites for UE4.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

ARG BASEIMAGE
FROM ${BASEIMAGE}

# Install the necessary build prerequisites for UE4.
RUN apt-get update -yq &&\
    apt-get install -yq --no-install-recommends\
        build-essential\
        ca-certificates\
        curl\
        git\
        python3\
        python3-dev\
        python3-pip\
        shared-mime-info\
        unzip\
        xdg-user-dirs\
        zip\
        openssh-client &&\
    rm -rf /var/lib/apt/lists/*
