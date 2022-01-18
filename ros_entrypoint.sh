#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ${HOME}/.bashrc

source "${HOME}/catkin_ws/devel/setup.bash"
echo "source ~/catkin_ws/devel/setup.bash" >> ${HOME}/.bashrc

exec "$@"
