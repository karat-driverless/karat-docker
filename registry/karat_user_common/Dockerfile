## @file
# Extends the base image by the generic components of the user container.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

ARG BASEIMAGE
FROM ${BASEIMAGE}

# Set environment variables crucial to X11 and OpenGL.
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all
ENV QT_X11_NO_MITSHM=1

# Install x11-xserver-utils for X11 support.
# Install libgl1-mesa-glx libgl1-mesa-dri for Mesa GPU acceleration.
# Install pulseaudio-utils for PulseAudio passthrough.
# Install libvulkan1 for Vulkan support.
# Install sudo, openssh-client, git and subversion for the development workflow.
RUN apt-get update -yq &&\
    apt-get install -yq --no-install-recommends x11-xserver-utils\
        libgl1-mesa-glx libgl1-mesa-dri libvulkan1 git openssh-client\
        pulseaudio-utils subversion sudo &&\
    rm -rf /var/lib/apt/lists/*

# Enable Vulkan support.
# Source the KaRaT bashrc from the system bashrc.
RUN VULKAN_API_VERSION=`dpkg -s libvulkan1 | grep -oP 'Version: [0-9|\.]+' | grep -oP '[0-9|\.]+'` &&\
    mkdir -p /etc/vulkan/icd.d/ &&\
    echo\
    "{\
      \"file_format_version\" : \"1.0.0\",\
      \"ICD\": {\
        \"library_path\": \"libGLX_nvidia.so.0\",\
        \"api_version\" : \"${VULKAN_API_VERSION}\"\
      }\
    }" > /etc/vulkan/icd.d/nvidia_icd.json

# Do not explicitly disable user interaction.
ENV DEBIAN_FRONTEND=
