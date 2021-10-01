#!/bin/sh

## @file
# Build the preliminary KaRaT TKDNN image.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

FROM nvcr.io/nvidia/tensorrt:20.12-py3

# START TODO: karat_ubuntu

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

# END TODO

RUN apt-get update -yq && apt-get install -yq --no-install-recommends git wget libeigen3-dev libyaml-cpp-dev && rm -rf /var/lib/apt/lists/*
RUN cd /tmp && \
    wget https://github.com/Kitware/CMake/releases/download/v3.17.3/cmake-3.17.3-Linux-x86_64.sh && \
    chmod +x cmake-3.17.3-Linux-x86_64.sh && \
    ./cmake-3.17.3-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir --skip-license && \
    rm ./cmake-3.17.3-Linux-x86_64.sh

RUN apt-get update -yq &&\
    apt-get install -yq --no-install-recommends build-essential \
      unzip \
      pkg-config \
      libjpeg-dev \
      libpng-dev \
      libtiff-dev \
      libavcodec-dev \
      libavformat-dev \
      libswscale-dev \
      libv4l-dev \
      libxvidcore-dev \
      libx264-dev \
      libgtk-3-dev \
      libatlas-base-dev \
      gfortran \
      libgstreamer1.0-dev \
      libgstreamer-plugins-base1.0-dev \
      libdc1394-22-dev \
      libavresample-dev &&\
      rm -rf /var/lib/apt/lists/*
RUN cd && wget https://github.com/opencv/opencv/archive/4.5.1.tar.gz && tar -xf 4.5.1.tar.gz  && rm 4.5.1.tar.gz && wget https://github.com/opencv/opencv_contrib/archive/4.5.1.tar.gz && tar -xf 4.5.1.tar.gz && rm 4.5.1.tar.gz
RUN cd && ls -a
RUN cd && cd opencv-4.5.1 && mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D INSTALL_C_EXAMPLES=OFF \
    -D OPENCV_EXTRA_MODULES_PATH='~/opencv_contrib-4.5.1/modules' \
    -D BUILD_EXAMPLES=OFF \
    -D WITH_CUDA=ON \
    -D CUDA_ARCH_BIN=7.2 \
    -D CUDA_ARCH_PTX="" \
    -D ENABLE_FAST_MATH=ON \
    -D CUDA_FAST_MATH=ON \
    -D WITH_CUBLAS=ON \
    -D WITH_LIBV4L=ON \
    -D WITH_GSTREAMER=ON \
    -D WITH_GSTREAMER_0_10=OFF \
    -D WITH_TBB=ON \
    -D BUILD_TIFF=ON \
    -D OPENCV_SKIP_PYTHON_WARNING=ON \
  -D BUILD_opencv_java=OFF \
  -D BUILD_TESTS=OFF \
  -D BUILD_PERF_TESTS=OFF \
    ../ && make -j${NPROC} && make install

RUN cd && git clone https://github.com/ceccocats/tkDNN.git && cd tkDNN && mkdir build && cd build \ 
    && cmake .. && make -j${NPROC}

RUN cd && cd tkDNN && cd build && make install

#-D WITH_EIGEN=ON -D WITH_IPP=ON
