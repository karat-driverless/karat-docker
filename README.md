# KaRaT Docker containers

This repository contains KaRaT Docker containers for both CI/CD and client usage.

## Structure

### Registry
Contains generic container images for the registry for both CI/CD and client usage.
* **karat_ubuntu**: The base Ubuntu image for all containers.
* **karat_ros**: The KaRaT ROS development environment.
* **karat_ue4_prereq**: The KaRaT UE4 build prerequisites image.
* **karat_ue4_source**: The KaRaT UE4 source code image.
* **karat_ue4_build**: The KaRaT UE4 local build with source code image.
* **karat_ue4**: The KaRaT UE4 installed build image.
* **karat_user_common**: The generic parts of the KaRaT user image.
* **karat_ciserver**: The KaRaT CI server image.

### User
Contains containers that need to be built by the user for client usage.
* **karat_user**: The user-specific parts of the KaRaT user container.
* **karat_user_ros**: The KaRaT ROS entry point for the KaRaT user container.
* **karat_user_ue4**: The KaRaT UE4 entry point for the KaRaT user container.

### Scripts
Contains scripts to build the KaRaT containers.
* **build_common_images.sh**: Builds the common images.
* **run_karat_user.sh**: Builds and runs the specified user image.

## Building and running

The following packages are required:
* **docker** for container build and runtime
* **nvidia-docker2** for NVIDIA GPU acceleration

The following scripts are available:
* **run_karat_user_ros.sh**: Builds and runs the KaRaT ROS user container.
* **run_karat_user_ue4.sh**: Builds and runs the KaRaT UE4 user container.

The following environment variables are available for building:
* **KARAT_ROS_TAG**: The name of the ROS distribution to use.
* **KARAT_UBUNTU_TAG**: The name of the Ubuntu distribution to use.
* **KARAT_ROS_PYTHON**: The package suffix for ROS Python packages.
* **KARAT_UE4_VER_TAG**: The version of the UE4 engine to use.
* **KARAT_NPROC**: The number of processors to compile with.

If not explicitly set, **ROS_TAG** defaults to **melodic**. If not explicitly set, **UBUNTU_TAG** and **ROS_PYTHON** are set based on **ROS_TAG**. Currently supported **ROS_TAG** values are **melodic** and **noetic**.

If not explicitly set, **UE4_VER_TAG** defaults to 4.26.1.

If not explicitly set, **NPROC** defaults to half of the available cores.

## The User container

The user container integrates several aspects of the host machine into the Docker, such as the root filesystem, the current user (including permissions and password), GIT and SVN configurations, as well as the PulseAudio service.

The host filesystem is mounted at ``/host`` in the User container.

**Attention**: As the host filesystem is mounted in the container, you can do irreversible damage to the host the same way as outside the container.
