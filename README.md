# ROSのインストール

## ROS noetic（Ubuntu 20.04）
```
wget https://github.com/naka-lab/ros_setup/raw/main/rosinstall_noetic.sh
chmod +x rosinstall_noetic.sh 
./rosinstall_noetic.sh
```

### IPの設定
`rosinstall_noetic.sh`でインストールすると，`catkin_ws`の中に以下のような`set_ip.sh`が作成されます．
```
export ROS_MASTER_URI=http://127.0.0.1:11311
export ROS_HOSTNAME=127.0.0.1
```
このファイルをダブルクリックで開いてIPを変更し，ターミナルを再起動（または，`source ~/.bashrc`）すれば設定したIPが反映されます．`bashrc`にIP設定を記載する必要はありません．
