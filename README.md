# docker-webserver

使用docker构建web环境，目前包括nginx，php(composer)，mysql，redis

## 使用

先安装docker，docker-compose

复制.env.example，并改名为.env，修改相应的配置

#### 开发环境

以下命令将使用`docker-compose.yml`和`docker-compose.override.yml`文件配置，后者会覆盖前者配置，具体参考[docker-compose](https://docs.docker.com/compose/extends/)文档。

```bash
docker-compose build
docker-compose up -d
```

同时在window上为了解决数据卷性能问题，使用[docker-sync](https://github.com/EugenMayer/docker-sync)，具体安装参考其文档。

之后可以使用web.sh启动sync和docker服务

```bash
./web.sh up         启动服务
./web.sh stop       停止服务
./web.sh sync       同步文件
./web.sh clean      清除同步文件
```

PS：OSX可使用cached解决数据卷性能问题，无须使用第三方插件。见[Docker for Mac](https://docs.docker.com/docker-for-mac/osxfs-caching/#tuning-with-consistent-cached-and-delegated-configurations)

#### 生产环境

以下命令将使用`docker-compose.yml`和`docker-compose.prod.yml`文件配置，后者会覆盖前者配置。

```bash
docker-compose build
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

## 应用路径

运行服务之前须得按.env里设置的路径一样在主机创建好相应的目录。

查看[.env.example](./.env.example)的建议路径

## 关于php-composer

composer直接使用官方镜像，所以直接拉取官方镜像即可

```bash
docker pull composer
```

在应用目录中，有[composer](./composer/)的文件夹，里面有[config.json](./composer/config.json)，通过数据卷挂载的形式，将配置导入composer容器中，同时也可共享缓存等。

config.json已经设置中国镜像，以加快install/update速度。

运行composer

```bash
docker run --rm --interactive --tty --volume $(composer_home):/tmp --volume $(project_dir):/app composer install/update
```

也可使用composer.sh。composer.sh脚本里使用了`COMPOSER_HOME`变量做为数据卷，请自行在服务器设置变量。建议将此脚本放入`/usr/bin`中，以便在项目目录中直接执行，而不用输入项目路径(脚本自动使用`$pwd`当前路径)。

```bash
#project_dir 可选，不输入使用当前路径
composer.sh install/update project_dir
```