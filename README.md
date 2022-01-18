# kobuki を操縦する

## 初期設定

## 実行
```bash
$ cd （任意のディレクトリ）
$ git clone git@github.com:sh-hay/kobuki-controller.git
$ cd kobuki-controller
$ docker build -t kobuki_image .
$ docker run -it --rm \
  --name kobuki_container \
  kobuki_image
```

## 参考
https://github.com/gaunthan/Turtlebot2-On-Melodic