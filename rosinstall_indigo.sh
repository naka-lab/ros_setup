# ROSインストール
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
#sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --keyserver-option http-proxy=http://proxy.uec.ac.jp:8080 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install ros-indigo-desktop-full
sudo apt-get install python3-rosdep python3-rosinstall-generator python3-vcstool build-essential python3-rosinstall
sudo -E rosdep init
rosdep update
pip install empy catkin_pkg rospkg

# catkin_ws作成
sudo echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source /opt/ros/indigo/setup.bash
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
catkin_init_workspace
cd ~/catkin_ws
catkin_make
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

# IP設定用の独自設定
echo "export ROS_MASTER_URI=http://127.0.0.1:11311" > ~/catkin_ws/set_ip.sh
echo "export ROS_HOSTNAME=127.0.0.1" >> ~/catkin_ws/set_ip.sh
echo "# ROSのIPは以下のファイルで切り替える" >>  ~/.bashrc
echo "source ~/catkin_ws/set_ip.sh" >> ~/.bashrc

source ~/.bashrc
