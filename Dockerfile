FROM ubuntu
ENV TZ Asia/Shanghai
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt update
RUN apt install -y curl gnupg2
RUN sed -i '1i deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse' /etc/apt/sources.list
RUN sed -i '1i # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse' /etc/apt/sources.list
RUN sed -i '1i deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse' /etc/apt/sources.list
RUN sed -i '1i # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse' /etc/apt/sources.list
RUN sed -i '1i deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse' /etc/apt/sources.list
RUN sed -i '1i # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse' /etc/apt/sources.list
RUN sed -i '1i deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse' /etc/apt/sources.list
RUN sed -i '1i # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse' /etc/apt/sources.list
RUN apt update
RUN apt install -y software-properties-common git
RUN add-apt-repository ppa:ondrej/php
RUN apt install -y php-pear php7.1-cli php7.1-common php7.1-curl php7.1-dev php7.1-fpm php7.1-json php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-opcache php7.1-zip php7.1-intl php7.1-gd php7.1-xml
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata
RUN sed -i 's/listen = .*/listen = 127.0.0.1:9000/g' /etc/php/7.1/fpm/pool.d/www.conf
RUN service php7.1-fpm restart
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN sed -i 's/deb.nodesource.com\/node_10.x/mirrors.tuna.tsinghua.edu.cn\/nodesource\/deb_10.x/g' /etc/apt/sources.list.d/nodesource.list
RUN apt update
RUN apt install -y nodejs
RUN npm install -g yarn
RUN npm config set registry https://registry.npm.taobao.org
RUN yarn config set registry https://registry.npm.taobao.org

WORKDIR /var/www/edusoho
ADD ./ /var/www/edusoho/
RUN yarn

VOLUME ["/var/www/edusoho"]
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 9000
CMD ["/bin/bash"]
