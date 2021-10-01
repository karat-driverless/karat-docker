## @file
# Extends the UE4 source base image by a local build of UE4.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

ARG BASEIMAGE
ARG BUILDIMAGE
FROM ${BUILDIMAGE} AS builder

# Re-use the user from karat_ue4_source.
USER ue4

# Compile a local build of UE4 without sample content.  
RUN cd ~/unreal/ &&\
    ./Setup.sh &&\
    ./GenerateProjectFiles.sh &&\
    ./Engine/Build/BatchFiles/RunUAT.sh BuildGraph\
        -target="Make Installed Build Linux"\
        -script=Engine/Build/InstalledEngineBuild.xml\
        -set:HostPlatformEditorOnly=true\
        -set:HostPlatformDDCOnly=true\
        -set:HostPlatformOnly=true\
        -set:WithDDC=false\
        -set:GameConfigurations=Development\
        -clean &&\
    rm -rf LocalBuilds/Engine/Linux/Sample\
        LocalBuilds/Engine/Linux/Templates\
        LocalBuilds/Engine/Linux/FeaturePacks
