# GALLERIA(GCR2070RGF)へのUbuntu20.04とROS noeticのインストール
以下のインストールで必要なファイルはネットワークドライブにまとめてます．

## Ubuntuのインストール
- セキュアブートを有効にする
  - 無効になっていると途中でフリーズします
  - セキュアブートが有効かどうかは，`mokutil --sb-state`で確認
- Ubuntuのインストール時には「Ubuntu (safe graphich)」を選択
	- 解像度が低くてウィンドウ全体が見れない場合は，ウィンドウをWindowsキーを押しながらドラッグすることで動かせます

## 各種ソフトのインストール
- apt-get proxy設定
	- bashrcに以下を追加（`gedit ~/.bashrc`）
  ```
  export http_proxy="http://proxy.uec.ac.jp:80880/"
  export https_proxy="http://proxy.uec.ac.jp:8080/"
  ```
	- /etc/apt/apt.confに以下を追加（`sudo gedit /etc/apt/apt.conf`）
  ```
  Acquire::http::proxy "http://proxy.uec.ac.jp:8080/";
  Acquire::https::proxy "http://proxy.uec.ac.jp:8080/";
  ```
  
- pythonインストール
  ```
  chmod +x Anaconda3-2020.11-Linux-x86_64.sh
  ./Anaconda3-2020.11-Linux-x86_64.sh
  ```
	- インストール後bashを立ち上げ直す
  
- rosインストール
  ```
  wget https://github.com/naka-lab/ros_setup/raw/main/rosinstall_noetic.sh
  chmod +x rosinstall_noetic.sh 
  ./rosinstall_noetic.sh
  ```
  
- nvidiaドライバ
  ```
  sudo apt install nvidia-driver-440
  ```
	- パスワードの入力を求められるので覚えやすい値（12345678等）を入力して再起動．再起動中に表示されたメニューから「Enroll MOK」を選んで，設定したパスワードを入力．
	- ドライバインストール前にセキュアブートを無効にしているとフリーズするため，必ずセキュアブートを有効にして実行
  
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
