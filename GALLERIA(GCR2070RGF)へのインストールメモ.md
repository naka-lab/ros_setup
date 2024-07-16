# GALLERIAへのUbuntu20.04とROS noeticのインストール
以下のインストールで必要なファイルはネットワークドライブにまとめてます．

## Ubuntuのインストール
- Ubuntuのインストール時には「Ubuntu (safe graphich)」を選択
	- 解像度が低くてウィンドウ全体が見れない場合は，ウィンドウをWindowsキーを押しながらドラッグすることで動かせます
- フリーズするようなら，デフォルトのグラフィックドライバを無効化
  - recovery modeで`nano /etc/modprobe.d/blacklist-nouveau.conf`でファイルを作成
  - 以下をファイルに記述
  ```
  blacklist nouveau
  options nouveau modeset=0
  ```
  - `sudo update-initramfs -u`を実行
- これでもフリーズするようなら，セキュアブートを有効にする
  - 無効になっていると途中でフリーズする（？）
  - セキュアブートが有効かどうかは，`mokutil --sb-state`で確認
  - 無効になっていた場合は`sudo mokutil --enable-validation`で有効化（Ubuntuインストール後でもセーフモードから無効化することでフリーズを回避できます．）
- フリーズせずに再起動する方法
  - 起動時にESC連打でリカバリモードに入り，Advanced options for Ubuntu→Ubuntu *** (revovery mode)→resumeを選択すると起動できる．
  - ESC連打でgrubのプロンプトまで行ってしまった場合，normalを入力しEnter後，すぐにESCを押すと戻れる．
- 起動時のフリーズを回避する方法
  - `sudo nano /etc/default/grub`でGRUBの設定ファイル中の`GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"`を`GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"`に変更
  - その後`sudo update-grub`を実行し再起動するとフリーズしなくなるはず
- WIFI，タッチパッドが使えない場合
  - 左下の`アプリケーションを表示する`にある`ソフトウェアの更新`で更新すると使えるようになる（XL7C-R36Hの場合）
## 各種ソフトのインストール
- gitのインストール
  - gitのインストール
  ```
  sudo apt-get install git
  ```
  - gitのproxy設定
  ```
  git config --global http.proxy http://proxy.uec.ac.jp:8080
  ```
- pythonインストール
  ```
  wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
  chmod +x Anaconda3-2020.11-Linux-x86_64.sh
  ./Anaconda3-2020.11-Linux-x86_64.sh
  ```
  - インストール後にターミナルを立ち上げ直す（または，`source ~/.bashrc`を実行）
  - proxy環境下でcondaコマンドを使えるようにする
  ```
  conda config --set proxy_servers.http http://proxy.uec.ac.jp:8080
  conda config --set proxy_servers.https http://proxy.uec.ac.jp:8080
  ```
  
- rosインストール
  ```
  wget https://github.com/naka-lab/ros_setup/raw/main/rosinstall_noetic.sh
  chmod +x rosinstall_noetic.sh 
  ./rosinstall_noetic.sh
  ```
  
- nvidiaドライバ
  - RTX 2060の場合 
    ```
    sudo apt install nvidia-driver-440
    ```
  - RTX 3060の場合
    ```
    sudo apt install nvidia-driver-460
    ```

    - パスワードの入力を求められるので覚えやすい値（12345678等）を入力して再起動．再起動中に表示されたメニューから「Enroll MOK」を選んで，設定したパスワードを入力．
    - ドライバインストール前にセキュアブートを無効にしているとフリーズする（？）ため，その場合はセキュアブートを有効にして実行
  - その他のインストール方法
    - 左下の`アプリケーションを表示する`にある`ソフトウェアとアップデート`の`追加のドライバー`で最新のnvidia-driverをインストールして再起動 
  - 再起動して画面が真っ黒のままになる場合
    - 起動時にESCを押しリカバリモードに入り，`Advanced options for Ubuntu`→`Ubuntu *** (revovery mode)`→`resume`を選択するとなぜか起動できる．（Galleria XL7C-R36Hの場合）
- pytorchインストール
  ```
  conda install pytorch torchvision torchaudio cudatoolkit=11.0 -c pytorch
  ```
  エラーになる場合はpipを使う
  ```
  pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113
  ```
  
- その他アプリインストール
  ```
  sudo apt-get install openssh-server net-tools terminator
  ```
	- rosを使うときはterminatorを使うと便利
    - ctrl+o:縦分割
    - ctrl+e:横分割
  
- ssh有効
  ```
  sudo systemctl start ssh
  ```

- Visual Studio Codeインストール
	- https://code.visualstudio.com/Download
	- ダウンロードしてダブルクリックでインストール
  
- 画面共有（VNC）の有効化
  - vinoをインストール：`sudo apt-get install vino`
  - [設定]→[共有]→[画面共有]　で画面共有を有効化
  - Anaconda環境が入ってる場合は，base環境を抜ける: `conda deactivate`
  - 暗号化を解除する：`gsettings set org.gnome.Vino require-encryption false`

