FROM osrf/ros:melodic-desktop-bionic
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-melodic-desktop-full=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /home/DockerUser DockerUser -p $(perl -e 'print crypt("DockerUser", "salt"),"\n"') && \
    echo "DockerUser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV USER DockerUser
USER DockerUser

# install kobuki packages
RUN mkdir -p /home/DockerUser/catkin_ws/src && \
    cd /home/DockerUser/catkin_ws/src && \
    /bin/bash -c "source /opt/ros/melodic/setup.bash; /opt/ros/melodic/bin/catkin_init_workspace" && \
    cd /home/DockerUser/catkin_ws && \
    /bin/bash -c "sudo apt-get update" && \
    /bin/bash -c "source /opt/ros/melodic/setup.bash; catkin_make" && \
    /bin/bash -c "curl -sLf https://raw.githubusercontent.com/gaunthan/Turtlebot2-On-Melodic/master/install_basic.sh | bash" && \
    /bin/bash -c "source /opt/ros/melodic/setup.bash; catkin_make"&& \
    /bin/bash -c "sudo apt-get clean" && \
    /bin/bash -c "sudo rm -rf /var/lib/apt/lists/*" 
    

COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]