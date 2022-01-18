# kobuki を操縦する

## 初期設定
```bash
# copy across udev rules
$ wget https://raw.githubusercontent.com/kobuki-base/kobuki_ftdi/devel/60-kobuki.rules
$ sudo cp 60-kobuki.rules /etc/udev/rules.d
$ sudo service udev reload
$ sudo service udev restart
```

## コンテナ起動
```bash
$ cd （任意のディレクトリ）
$ git clone git@github.com:sh-hay/kobuki-controller.git
$ cd kobuki-controller
$ docker build -t kobuki_image .
$ docker run -it --rm \
  --name kobuki_container \
  --device=/dev/kobuki:/dev/kobuki \
  --net=host \
  kobuki_image
```
## テスト
```bash
$ roslaunch kobuki_node minimal.launch

# 別ターミナルを用意
$ docker exec -it kobuki_container bash
$ rostopic pub -r 5 /mobile_base/commands/velocity geometry_msgs/Twist -- '[0.1, 0.0, 0.0]' '[0.0, 0.0, 0.0]' 
```

## 1行実行
```bash
$ cd kobuki-controller
$ docker build -t kobuki_image .
$ docker run -it --rm \
  --name kobuki_container \
  --device=/dev/kobuki:/dev/kobuki \
  --net=host \
  kobuki_image \
  roslaunch kobuki_node minimal.launch
```

## 参考
https://github.com/gaunthan/Turtlebot2-On-Melodic
https://github.com/kobuki-base/kobuki_ftdi