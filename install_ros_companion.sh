#! /usr/bin/bash

# check locale for UTF-8
if echo $(locale) | grep -q "UTF-8"; then
    echo "UTF-8 already enabled"
else
    sudo apt update && sudo apt install locales
    sudo locale-gen en_US en_US.UTF-8
    sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
    export LANG=en_US.UTF-8

    locale
fi

# enable required repositories

# ubuntu universe repository
sudo apt install -y software-properties-common
sudo add-apt-repository universe

# ROS 2 GPG
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

# add the ROS 2 apt repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# dev tools
sudo apt update && sudo apt install ros-dev-tools

# install ros 2
sudo apt update && sudo apt full-upgrade && sudo apt install -y ros-jazzy-ros-base

# check bash source then append setup file
FILE="source /opt/ros/jazzy/setup.bash"
SOURCE="$HOME/.bashrc"

# check if line exists
if grep -Fxq "$FILE" "$SOURCE"; then
    echo "The line is already in .bashrc"
else
    # append line to .bashrc
    echo "$FILE" >> "$SOURCE"
    echo "The line has been added to .bashrc"
fi