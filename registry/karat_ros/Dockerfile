## @file
# Extends the base image by the KaRaT ROS environment.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG UBUNTU_TAG
ARG ROS_TAG
ARG ROS_PYTHON
ARG NPROC

# Install git for dependency retrieval.
# Install clang-8 for AirSim.
# Install ros-${ROS_TAG}-desktop-full, ros-${ROS_TAG}-rqt-multiplot, and
# ros-${ROS_TAG}-plotjuggler-ros for KaRaT development.
# Install libeigen3-dev and libgsl-dev for Models.
# Install ros-${ROS_TAG}-tf2-geometry-msgs for Control.
# Install libbluetooth-dev, libcwiid-dev, libspnav-dev and libusb-dev for Utilities.
# Install libsuitesparse-dev for G2O.
# Install and use gcc-9 by default for native C++17 filesystem library integration.
# Install osrf-pycommon for python${ROS_PYTHON}-catkin-tools.
# Install pybind11 for Models and Control.
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test &&\
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 &&\
    echo "deb http://packages.ros.org/ros/ubuntu ${UBUNTU_TAG} main" > /etc/apt/sources.list.d/ros1-latest.list &&\
    cat /etc/apt/sources.list.d/ros1-latest.list &&\
    apt-get update -yq &&\
    apt-get -yq install git clang-8 ros-${ROS_TAG}-desktop-full ros-${ROS_TAG}-rqt-multiplot libbluetooth-dev libcwiid-dev\
        libspnav-dev libsuitesparse-dev libusb-dev python${ROS_PYTHON}-catkin-tools python${ROS_PYTHON}-rosdep python${ROS_PYTHON}-pip libgsl-dev gcc-9 g++-9\
        libeigen3-dev ros-${ROS_TAG}-tf2-geometry-msgs ros-${ROS_TAG}-plotjuggler-ros &&\
    pip${ROS_PYTHON} install osrf-pycommon==0.1.9 &&\
    pip${ROS_PYTHON} install pybind11[global]==2.6.2 &&\
    add-apt-repository --remove -y ppa:ubuntu-toolchain-r/test &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -f /etc/apt/sources.list.d/llvm.list &&\
    rm -f /etc/apt/sources.list.d/ros1-latest.list &&\
    ln -fs /usr/bin/gcc-9 /usr/bin/gcc && \
    ln -fs /usr/bin/g++-9 /usr/bin/g++

# Install Boost 1.72 for Models.
RUN wget https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.gz -P /tmp/ &&\
    tar -xzvf /tmp/boost_1_72_0.tar.gz -C /tmp/ &&\
    cd /tmp/boost_1_72_0/ &&\
    ./bootstrap.sh --prefix=/usr/local &&\
    ./b2 -j${NPROC} install &&\
    cd - &&\
    rm -rf /tmp/boost_1_72_0/ &&\
    rm -f /tmp/boost_1_72_0.tar.gz

# Install Blasfeo for Control.
RUN git clone --depth 1 -b 0.1.2 https://github.com/giaf/blasfeo.git /tmp/blasfeo &&\
    cd /tmp/blasfeo/ &&\
    make -j${NPROC} static_library &&\
    make -j${NPROC} install_static &&\
    cd - &&\
    rm -rf /tmp/blasfeo/

# Install HPIPM for Control.
RUN git clone --depth 1 -b 0.1.3 https://github.com/giaf/hpipm.git /tmp/hpipm &&\
    cd /tmp/hpipm/ &&\
    make -j${NPROC} static_library &&\
    make -j${NPROC} shared_library &&\
    make -j${NPROC} install_static &&\
    make -j${NPROC} install_shared &&\
    cd - &&\
    rm -rf /tmp/hpipm/

# Install G2O for Estimation.
RUN git clone --depth 1 -b 20201223_git https://github.com/RainerKuemmerle/g2o.git /tmp/g2o &&\
    mkdir /tmp/g2o/build/ &&\
    cd /tmp/g2o/build/ &&\
    cmake .. &&\
    make -j${NPROC} &&\
    make -j${NPROC} install &&\
    cd - &&\
    rm -rf /tmp/g2o/

# Initialize the ROS dependency service.
# Source ROS from the centralised KaRaT bashrc.
RUN rosdep init &&\
    rosdep update &&\
    echo ". /opt/ros/${ROS_TAG}/setup.bash" >> /etc/karat_setup.sh
