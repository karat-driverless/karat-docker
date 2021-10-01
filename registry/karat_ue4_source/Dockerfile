## @file
# Extends the base image by source code UE4.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG UE4_VER_TAG

# UE4 refuses to build with root privileges.
RUN useradd --create-home --home /home/ue4 --shell /bin/bash --uid 1000 ue4 &&\
    usermod -a -G audio,video ue4
USER ue4

# Clone the UE4 source code with the private key to the karat-dv GitHub account.
RUN mkdir -p ~/.ssh &&\
    chmod 700 ~/.ssh &&\
    echo "-----BEGIN OPENSSH PRIVATE KEY-----" > ~/.ssh/id_ed25519 &&\
    echo "b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW" >> ~/.ssh/id_ed25519 &&\
    echo "QyNTUxOQAAACDBc1C6MUCswd6NfiUerykvT333MGb32Otmowk3PnJiJQAAAKi7/oVHu/6F" >> ~/.ssh/id_ed25519 &&\
    echo "RwAAAAtzc2gtZWQyNTUxOQAAACDBc1C6MUCswd6NfiUerykvT333MGb32Otmowk3PnJiJQ" >> ~/.ssh/id_ed25519 &&\
    echo "AAAEC+WAoot3XhHWvu2mf8aZx0yTc60c8rm8kUZJYdyWQIW8FzULoxQKzB3o1+JR6vKS9P" >> ~/.ssh/id_ed25519 &&\
    echo "ffcwZvfY62ajCTc+cmIlAAAAHm1hcnZpbi5oYWV1c2VyQGthcmF0LXJhY2luZy5kZQECAw" >> ~/.ssh/id_ed25519 &&\
    echo "QFBgc=" >> ~/.ssh/id_ed25519 &&\
    echo "-----END OPENSSH PRIVATE KEY-----" >> ~/.ssh/id_ed25519 &&\
    ssh-keyscan github.com >> ~/.ssh/known_hosts &&\
    chmod 600 ~/.ssh/id_ed25519 ~/.ssh/known_hosts &&\
    git clone --depth 1 -b ${UE4_VER_TAG}-release git@github.com:EpicGames/UnrealEngine.git ~/unreal
