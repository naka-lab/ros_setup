# GALLERIA(GCR2070RGF)へのUbuntu20.04とROS noeticのインストール
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

## 各種ソフトのインストール
- proxy設定
  - bashrcに以下を追加（`gedit ~/.bashrc`）
  ```
  export http_proxy="http://proxy.uec.ac.jp:8080/"
  export https_proxy="http://proxy.uec.ac.jp:8080/"
  ```
  - /etc/apt/apt.confに以下を追加（`sudo gedit /etc/apt/apt.conf`）
  ```
  Acquire::http::proxy "http://proxy.uec.ac.jp:8080/";
  Acquire::https::proxy "http://proxy.uec.ac.jp:8080/";
  ```
- 設定後にターミナルを立ち上げ直す（または，`source ~/.bashrc`を実行）

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
  
- pytorchインストール
  ```
  conda install pytorch torchvision torchaudio cudatoolkit=11.0 -c pytorch
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

- proxy環境下での時刻合わせ（時刻がづれているとROSで通信できない）
  - 時刻合わせスクリプトのダウンロード
  ```
  cd
  wget https://github.com/naka-lab/ros_setup/raw/main/set_time.sh
  chmod +x set_time.sh
  ```
  - 時刻合わせの実行
  ```
  sudo -E ~/set_time.sh
  ```
  表示される時間がずれているようであれば再度上記コマンドを実行する．（サーバーエラー等で失敗するときが時々あるため）
  

